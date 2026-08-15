namespace :heaters do
  desc "Mark assigned heaters as unaccounted. Dry-run by default. Set APPLY=true to perform changes."
  task mark_unaccounted: :environment do
    assigned_record = HeaterStatus.find_by(status_name: 'Assigned')
    assigned_id = (ENV['ASSIGNED_ID'] && ENV['ASSIGNED_ID'].to_i) || (assigned_record ? assigned_record.id : 2)

    status_id = (ENV['STATUS_ID'] && ENV['STATUS_ID'].to_i) || 5
    target_status = HeaterStatus.find_by(id: status_id)

    unless target_status
      puts "Required heater status id #{status_id} not found. Ensure it exists."
      exit 1
    end

    scope = Heater.where(heater_status_id: assigned_id)
    puts "Found "+scope.count.to_s+" heaters with status 'Assigned' (id=#{assigned_id}). Will set to status id=#{status_id}."

    if scope.count == 0
      puts "Nothing to do."
      next
    end

    apply = ENV['APPLY'] == 'true' || ENV['APPLY'] == '1'
    reason = ENV['REASON'] || "Marked unaccounted via rake task"

    scope.find_each do |heater|
      client_info = heater.current_client_id ? "client_id=#{heater.current_client_id}" : "no current client"
      puts "Heater #{heater.id} (serial: #{heater.serial_number}) - #{client_info} - will be marked status_id=#{status_id}"

      next unless apply

      Heater.transaction do
        if heater.current_client_id.present?
          puts "  Warning: clearing current client #{heater.current_client_id} without creating a heater interaction record"
        end

        heater.update!(heater_status_id: target_status.id, status_reason: reason, current_client_id: nil)
      end
    end

    if apply
      puts "Applied: all matched heaters updated to status_id=#{status_id}."
    else
      puts "Dry-run complete. To apply changes, run with APPLY=true and optionally set REASON. Example:"
      puts "  APPLY=true REASON='Inventory audit 2026-08-14' bundle exec rake heaters:mark_unaccounted"
    end
  end
end
