namespace :clients do
  desc "Mark clients inactive if they haven't had activity in 90+ days"
  task mark_inactive: :environment do
    puts "Starting client inactivity check - #{Time.now}"

    clients = Client.where(status: 'Active')
                    .where.not(last_interaction_date: nil)

    count = 0
    clients.each do |client|
      next if client.last_interaction_date.nil?  # safety guard
      
      days_inactive = (Date.today - client.last_interaction_date.to_date).to_i

      if days_inactive > 90
        client.update(status: 'Inactive', current_camp_id: 0)
        count += 1
        puts "Marked inactive: #{client.first_name} #{client.last_name} (#{days_inactive} days)"
      end
    end

    puts "Complete - #{count} clients marked inactive - #{Time.now}"
  end
end