puts 'initialize sidekiq'
class SidekiqFormatter < Sidekiq::Logging::Pretty
  def call(severity, _time, _program_name, message)
    # message = message.is_a?(Hash) ? message : {message: message.to_s, logger_warning: 'logger value is accepted only Hash. please fix it.'}
    {severity: severity, message: message, sidekiq_context: context}
  end
end

Sidekiq.configure_server do |config|
  # Rails.logger.formatter = SidekiqFormatter.new
  # config.logger = Rails.logger
end

