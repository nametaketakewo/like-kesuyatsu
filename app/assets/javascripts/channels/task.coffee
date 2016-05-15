App.task = App.cable.subscriptions.create "TaskChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    @renderInformation(data) if task_id == data.id

  renderInformation: (data) ->
    percentage = Math.floor(data.progress / data.implement * 100) + '%'
    $('.percentage').html(percentage).css('width', percentage).css('color', 'red')

    if data.progress == data.implement
      states = '処理は正常に終了しました。'
    else if data.cancelled
      states = '処理は中断されました。'
    else if data.favorite_empty
      states = 'いいねは空になりました。'
    else if data.request_many
      states = 'APIが制限されました。'
    else
      states = '処理中です...'

    $('#caution').html(states)

  progress: ->

