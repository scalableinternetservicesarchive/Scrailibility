window.Poller = {
  poll: (timeout) ->
    if timeout is 0
      Poller.request()
    else
      this.pollTimeout = setTimeout ->
        Poller.request()
      , timeout || 3000
  clear: -> clearTimeout(this.pollTimeout)
  request: ->
    $.get('/conversations/check_new_messages')
}

# jQuery ->
#   Poller.poll()
