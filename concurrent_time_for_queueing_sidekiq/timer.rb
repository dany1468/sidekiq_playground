require 'concurrent/timer_task'

class UpdaterObserver
  def update time, result, ex
    if result
      p("#{time} [AttentiveSidekiq] Finished updating with result #{result}")
    elsif ex.is_a?(Concurrent::TimeoutError)
      p("#{time} [AttentiveSidekiq] Execution timed out")
    else
      p("#{time } [AttentiveSidekiq] Execution failed with error #{ex}\n")
    end
  end
end

class Timer
  def start!
    task = Concurrent::TimerTask.new(options) do
      p 'execute !!'
    end
    task.add_observer(UpdaterObserver.new)
    task.execute
  end

  def options
    {
      execution_interval: 5,
      timeout_interval: 30
    }
  end
end

Timer.new.start!
