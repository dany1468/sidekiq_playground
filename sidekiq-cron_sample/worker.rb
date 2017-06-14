require 'sidekiq'
require 'sidekiq-cron'

# If your client is single-threaded, we just need a single connection in our Redis connection pool
Sidekiq.configure_client do |config|
  config.redis = {namespace: 'sidekiq-cron_sample', size: 1}
end

# Sidekiq server is multi-threaded so our Redis connection pool size defaults to concurrency (-c)
Sidekiq.configure_server do |config|
  config.redis = {namespace: 'sidekiq-cron_sample'}
  schedule_file = 'schedule.yml'
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

class Worker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(id)
    logger.info ">>> start #{id}"
    # raise
    logger.info ">>> finish #{id}"
  end
end
