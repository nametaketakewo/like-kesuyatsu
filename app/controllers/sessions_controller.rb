class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    session[:user_id] = auth['uid']
    session[:user_name] = auth['info']['nickname']
    session[:name] = auth['info']['name']
    session[:oauth_token] = auth['credentials']['token']
    session[:oauth_token_secret] = auth['credentials']['secret']
    session[:task_id] = nil
    redirect_to new_task_path, notice: 'ログインしました。'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
