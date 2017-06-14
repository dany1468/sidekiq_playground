require 'sidekiq'
require 'sidekiq/batch'
require_relative '../my_callback'

class RowWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  sidekiq_retries_exhausted do |msg, exception|
    puts ">>>>>>>>>> msg:#{msg}"
    puts ">>>>>>>>>> backtrace:#{exception.backtrace}"
    puts ">>>>>>>>>> class:#{exception.class}"
    puts ">>>>>>>>>> message:#{exception.message}"
  end

  def perform(i)
    raise StandardError, 'fuckeing exceoptino'
    sleep 1
    puts ">>> worker performed #{i}"
  end
end
