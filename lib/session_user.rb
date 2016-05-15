class SessionUser
  def initialize(session)
    @uid = session[:user_id].to_i
    @name = session[:name]
    @user_name = session[:user_name]
    @token = session[:oauth_token]
    @secret = session[:oauth_token_secret]
  end
  attr_reader :uid, :name, :user_name, :token, :secret
end
