class NotificationsJob < ApplicationJob
  queue_as :default

  def perform(push_tokens, message, data)
    NotificationsService.notify(push_tokens, message, data)
  end
end
