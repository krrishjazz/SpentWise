class SendMailJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :default

  def perform()
    # Do something later
    OrderMailer.new_order_email_accept.deliver_now!
  end
end
