desc 'Reset Counters'
task :reset_counters => :environment do
  Harvest.all do |harvest|
    harvest.reset_counter(harvest.id :credits)
  end
end
