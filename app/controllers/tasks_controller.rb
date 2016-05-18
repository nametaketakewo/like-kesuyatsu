class TasksController < BaseController
  before_action :login_required
  def new
    if current_task
      redirect_to progress_path, notice: '未終了の処理があります。'
    else
      @task = Task.new
    end
  end

  def create
    task = Task.new(task_params)
    task.user_id = current_user.uid
    twiconf = {consumer_key: Rails.application.secrets.twitter_consumer_key,
    consumer_secret: Rails.application.secrets.twitter_consumer_secret,
    access_token: current_user.token,
    access_token_secret: current_user.secret }
    if task.save
      DeleteStarsJob.perform_later(task, twiconf)
      redirect_to progress_path
    else
      redirect_to new_task_path
    end
  end

  def progress
    redirect_to logs_path, notice: '未終了の処理はありません。' if current_task.nil?
  end

  def log
    if current_user
      @tasks = Task.where(user_id: current_user.uid)
    else
      redirect_to root_path
    end
  end

  def destroy
    task = current_task
    if task.nil?
      redirect_to logs_path, notice: '実行中の処理はありません。'
    else
      task.cancelled = true
      if task.save
        redirect_to logs_path, notice: 'キャンセルされました。'
      else
        redirect_to root_path, notice: 'エラーが発生しました。'
      end
    end
  end

  private

  def task_params
    params[:task].permit(:implement)
  end
end
