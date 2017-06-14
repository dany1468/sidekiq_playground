require_relative 'workers/row_worker'
require 'sidekiq/batch'

RowWorker.perform_async(999)

# count = 10
#
# batch = Sidekiq::Batch.new
# batch.description = "Batch description (this is optional)"
# bc_ids = (1..20).map {|i| i.to_s.rjust(11, '0') }
# batch.on(:success, MyCallback, bc_ids: bc_ids, retry: 10)
# batch.jobs do
#   count.times {|i| RowWorker.perform_async(i) }
# end
# puts "Just started Batch #{batch.bid}"
