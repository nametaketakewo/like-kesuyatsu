class TasksController < BaseController
  def new
    if current_user
      if current_task
        redirect_to progress_path, notice: '未終了の処理があります。'
      else
        @task = Task.new
      end
    else
      redirect_to root_path, notice: 'ログインしてください。'
    end
  end

  def create
    if task_params['implement'].to_i > 3600
      redirect_to new_task_path
    else
      @task = Task.new(task_params)
      @task.user_id = current_user.uid
      twiconf = {consumer_key: Rails.application.secrets.twitter_consumer_key,
      consumer_secret: Rails.application.secrets.twitter_consumer_secret,
      access_token: current_user.token,
      access_token_secret: current_user.secret }
      if @task.save
        DeleteStarsJob.perform_later(@task, twiconf)
        session[:current_task_id] = @task.id
        redirect_to progress_path
      else
        redirect_to new_task_path
      end
    end
  end

  def show
    redirect_to root_path unless current_user
    @task = current_task
    redirect_to tasklog_path if @task.nil?
  end

  def log
    if current_user
      @tasks = Task.where(user_id: current_user.uid)
    else
      redirect_to root_path
    end
  end

  def destroy
    redirect_to root_path, notice: 'ログインしてください。' if current_user.nil?
    task = current_task
    if task.nil?
      redirect_to tasklog_path, notice: '実行中の処理はありません。'
    else
      task.cancelled = true
      if task.save
        redirect_to tasklog_path, notice: 'キャンセルされました。'
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
