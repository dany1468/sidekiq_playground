require 'serverengine'
require 'concurrent'

class Fetcher
  attr_reader :task
  def initialize(task, logger)
    @task = task
    @logger = logger
  end

  def perform
    @logger.info "start perform! #{@task}"
    sleep 10

    nil
  end
end

class Observer
  def initialize(logger, task)
    @logger = logger
    @task = task
  end

  def update(time, result, ex)
    if result
      @logger.info("#{time} Finished result #{@task.i}")
    elsif ex.is_a?(Concurrent::TimeoutError)
      @logger.info("#{time} timed out")
    else
      @logger.info("#{time} failed with error #{ex}\n")
    end
  end
end

class Task
  attr_reader :i
  def initialize(i)
    @i = i
  end
end

module MyWorker
  def run
    i = 1
    until @stop
      task = Task.new i
      future = Concurrent::Future.new { Fetcher.new(task, logger).perform }
      future.add_observer(Observer.new(logger, task))
      future.execute
      sleep 1
      logger.info "#{i} Awesome work!"
      i += 1
    end
  end

  def stop
    @stop = true
  end
end

se = ServerEngine.create(nil, MyWorker, {
  daemonize: true,
  log: 'myserver.log',
  pid_path: 'myserver.pid',
})

se.run
