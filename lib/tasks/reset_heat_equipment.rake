namespace :heat_equipment do
  desc "Reset current heat equipment assignments. Dry-run by default; set APPLY=true to apply."
  task season_reset: :environment do
    assigned_status = HeaterStatus.find_by!(status_name: "Assigned")
    unassigned_status = HeaterStatus.find_by!(status_name: "Unassigned")

    heaters = Heater.where(heater_status_id: assigned_status.id)
    tanks = ClientTankInteraction.where(status_id: assigned_status.id)
    hoses = ClientHoseInteraction.where(heater_status_id: assigned_status.id)
    clients = Client.where("number_tanks IS DISTINCT FROM 0 OR number_hoses IS DISTINCT FROM 0")

    client_description = lambda do |client_id|
      client = Client.find_by(id: client_id)
      if client
        name = [client.first_name, client.preferred_name, client.last_name].compact_blank.join(" ")
        "client_id=#{client.id} (#{name}, status=#{client.status || "<blank>"})"
      else
        "client_id=#{client_id || "<blank>"} (no matching client)"
      end
    end

    puts "Dry-run plan for heat equipment season reset:"
    puts "  Heaters to mark Unassigned and clear current client: #{heaters.count}"
    puts "  Tank interactions to mark Unassigned: #{tanks.count}"
    puts "  Hose interactions to mark Unassigned: #{hoses.count}"
    puts "  Clients whose tank/hose counts will be set to zero: #{clients.count}"
    puts "This does not verify physical returns. Confirm the inventory before applying."

    heaters.find_each do |heater|
      puts "  Heater ##{heater.id} serial=#{heater.serial_number || "<blank>"}: #{client_description.call(heater.current_client_id)}"
    end

    tanks.find_each do |interaction|
      tank = Tank.find_by(id: interaction.tank_id)
      puts "  Tank interaction ##{interaction.id} tank=#{tank&.serial_number || interaction.tank_id || "<blank>"}: #{client_description.call(interaction.client_id)}"
    end

    hoses.find_each do |interaction|
      puts "  Hose interaction ##{interaction.id}: #{client_description.call(interaction.client_id)}"
    end

    clients.find_each do |client|
      puts "  Client ##{client.id}: tanks=#{client.number_tanks.inspect}, hoses=#{client.number_hoses.inspect}"
    end

    apply = ENV["APPLY"] == "true" || ENV["APPLY"] == "1"
    unless apply
      puts "Dry-run only. To apply, run: APPLY=true bundle exec rake heat_equipment:season_reset"
      next
    end

    ActiveRecord::Base.transaction do
      heaters.find_each do |heater|
        heater.update!(heater_status_id: unassigned_status.id, current_client_id: nil)
      end

      tanks.update_all(status_id: unassigned_status.id, updated_at: Time.current)
      hoses.update_all(heater_status_id: unassigned_status.id, updated_at: Time.current)
      clients.update_all(number_tanks: 0, number_hoses: 0, updated_at: Time.current)
    end

    puts "Applied season reset: heaters, tank interactions, hose interactions, and client counts updated."
    puts "Equipment and route history records were retained."
  end
end