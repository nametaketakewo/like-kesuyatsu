class BaseController < ApplicationController
  protect_from_forgery
  helper_method :current_user, :current_task

  private

  def login_required
    redirect_to '/auth/twitter' if !current_user
  end

  def current_user
    @current_user ||= SessionUser.new(session) if session[:user_id]
  end

  def current_task
    return nil if !current_user
    @task = Task.where(user_id: current_user.uid).last
    return nil if @task.nil? || @task.implement <= @task.progress || @task.favorite_empty || @task.request_many || @task.cancelled
    return @task
  end
end
