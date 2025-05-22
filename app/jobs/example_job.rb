class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "ジョブを実行中: #{args.inspect}"
  end
end
