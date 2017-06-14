class Worker
  include Sidekiq::Worker

  def perform(bc_id, message)
    puts ("perform! #{bc_id} #{message} fuck_id:#{@fuck_id} context:#{@performing_context.inspect}")
    #logger.info("sidekiq perform! #{bc_id} #{message}")
  end
end
