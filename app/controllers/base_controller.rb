class BaseController < ApplicationController
  protect_from_forgery
  helper_method :current_user

  def login_required
    if @current_user = current_user
    else
      redirect_to root_path
    end
  end

  private

  def current_user
    @current_user ||= SessionUser.new(session) if session[:user_id]
  end

  def current_task
    return nil unless current_user
    @task = Task.where(user_id: current_user.uid).last
    return nil if @task.nil? || @task.implement <= @task.progress || @task.favorite_empty || @task.request_many || @task.cancelled
    return @task
    nil
  end
end
