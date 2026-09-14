namespace :clients do
  desc "Mark clients inactive if they haven't had activity in 90+ days"
  task mark_inactive: :environment do
    Rails.logger.info "Starting client inactivity check - #{Time.now}"

    cutoff_date = 90.days.ago
    count = Client.where(status: 'Active')
                  .where('last_interaction_date < ?', cutoff_date)
                  .update_all(status: 'Inactive', current_camp_id: 0)

    Rails.logger.info "Complete - #{count} clients marked inactive - #{Time.now}"
  end
end