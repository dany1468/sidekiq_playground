class MyCallback
  def on_success(status, options)
    Sidekiq.logger.info('on_success >>>>>>>>>>>>>>..')
    raise 'fucking exception'
    File.write('/Users/sansan_dan/git/sidekiq_batch/ids.txt', options['bc_ids'].join("\n"))
    File.write('/Users/sansan_dan/git/sidekiq_batch/status.txt', status.data)
  end
end
