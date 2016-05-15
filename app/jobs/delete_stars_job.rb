class DeleteStarsJob < ActiveJob::Base
  queue_as :default

  def send_information(task)
    ActionCable.server.broadcast 'information',
                                 id: task.id,
                                 progress: task.progress,
                                 implement: task.implement,
                                 favorite_empty: task.favorite_empty,
                                 request_many: task.request_many
  end

  def perform(task, twiconf)
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = twiconf[:consumer_key]
      config.consumer_secret = twiconf[:consumer_secret]
      config.access_token = twiconf[:access_token]
      config.access_token_secret = twiconf[:access_token_secret]
    end
    begin
      send_information(task)
      while task.implement > task.progress do
        break if task.reload.cancelled
        amount = task.implement - task.progress > 100 ? 100 : task.implement - task.progress
        tweets = twitter_client.favorites(count: amount)
        if tweets.empty?
          task.favorite_empty = true
          task.save
          break
        else
          twitter_client.unfavorite(tweets)
          task.progress += tweets.length
          task.save
          send_information(task)
        end
      end
    rescue Twitter::Error::TooManyRequests => apierror
      task.request_many = true
      task.save
      #DeleteStarsJob.set(wait: apierror.rate_limit.reset_in.second).perform_later(task, twiconf)
    rescue Twitter::Error::NotFound
      retry
    ensure
      send_information(task)
    end
  end
end
