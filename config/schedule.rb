# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
every 1.hour do
  runner 'BattleResultsImportJob.perform_later'
end

every 1.day, at: '3:00' do
  runner 'Tanks::MasteryBorderCalculationJob.perform_later'
  runner 'Tanks::ExperienceCoefficientsCalculationJob.perform_later'
end
