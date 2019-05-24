class NotificationsService
  def self.notify(push_tokens, message, data)
    params = {
      app_id: ENV['APP_ID'],
      contents: {
        en: message
      },
      data: data,
      include_player_ids: push_tokens
    }
    begin
      OneSignal::Notification.create(params: params)
    rescue OneSignal::OneSignalError => e
      Rails.logger.info(e)
    end
  end
end
