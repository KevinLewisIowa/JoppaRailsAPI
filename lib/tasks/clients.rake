namespace :clients do
  desc "Mark outreach clients inactive if they haven't had activity in 30+ days"
  task mark_inactive: :environment do
    Rails.logger.info "Starting client inactivity check - #{Time.now}"

    cutoff_date = 30.days.ago
    count = Client.where(status: 'Active')
                  .where('(is_aftercare IS NULL OR is_aftercare = FALSE)')
                  .where('(current_camp_id IS NULL OR current_camp_id <> ?)', 449)
                  .where('last_interaction_date < ?', cutoff_date)
                  .update_all(status: 'Inactive', current_camp_id: 0)

    Rails.logger.info "Complete - #{count} clients marked inactive - #{Time.now}"
  end
end