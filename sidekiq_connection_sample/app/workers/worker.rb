class Worker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  sidekiq_retries_exhausted do |msg|
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Sidekiq job is dead'
  end

  def perform(id)
    logger.info ">>> start #{id}"
    puts "#{id} #{Book.where(title: 'test').count}"
    logger.info ">>> finish #{id}"
    raise 'timing' if id % 100 == 0
  rescue => e
    logger.info "#{id} #{e.message}"
    raise
  end
end
