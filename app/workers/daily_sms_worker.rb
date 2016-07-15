class DailySMSWorker
  include Sidekiq::Worker

  def perform(subscription)
  end
end
