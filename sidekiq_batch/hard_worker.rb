require 'sidekiq'
# require 'sidekiq-cron'
require 'sidekiq/scheduler'

class HardWorker
  include Sidekiq::Worker
  def perform(count)
    puts "test #{count}"
  end
end

# Sidekiq::Cron::Job.create(name: 'Hard worker - every 5min', cron: '* * * * * *', class: 'HardWorker', args: ['bob', 5])
Sidekiq.set_schedule('dog', { 'every' => ['1s'], 'class' => 'HardWorker', 'args': 1 })
