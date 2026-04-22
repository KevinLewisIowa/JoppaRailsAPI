namespace :clients do
  desc "Mark clients as inactive if past the inactivity limit"
  task mark_inactive: :environment do
    inactivity_limit = 90 # days
    today = Date.today

    Client.where(status: 'Active').find_each do |client|
      last_interaction = client.last_interaction_date
      days_inactive = (today - last_interaction.to_date).to_i

      if days_inactive > inactivity_limit
        client.update(
          status: 'Inactive',
          current_camp_id: 0
        )
        Rails.logger.info "Marked #{client.first_name} #{client.last_name} as Inactive"
      end
    end

    Rails.logger.info "Inactivity update task completed"
  end
end