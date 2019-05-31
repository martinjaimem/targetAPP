class FacebookService
  def initialize(access_token)
    @access_token = access_token
  end

  def profile
    client.get_object(
      'me',
      fields: 'first_name, last_name'
    )
  end

  private

  def client
    Koala::Facebook::API.new(@access_token)
  end
end
