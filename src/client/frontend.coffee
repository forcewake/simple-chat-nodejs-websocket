$ ->
  content = $("#content")
  input = $("#input")
  status = $("#status")
  myName = false
  connection = new WebSocket("ws://127.0.0.1:1337")

  connection.onopen = ->
    input.removeAttr "disabled"
    status.text "Choose name:"

  connection.onerror = (error) ->
    content.html $("<p>",
      text: "Sorry, but there's some problem with your " + "connection or the server is down."
    )

  connection.onmessage = (message) ->
    try
      json = JSON.parse(message.data)
    catch e
      console.log "This doesn't look like a valid JSON: ", message.data
      return
    if json.type is "history"
      i = 0
      while i < json.data.length
        addMessage json.data[i].author, json.data[i].text, new Date(json.data[i].time)
        i++
    else if json.type is "message"
      input.removeAttr "disabled"
      addMessage json.data.author, json.data.text, new Date(json.data.time)
    else
      console.log "Hmm..., I've never seen JSON like this: ", json

  input.keydown (e) ->
    if e.keyCode is 13
      msg = $(@).val()
      return unless msg
      connection.send msg
      $(@).val ""
      input.attr "disabled", "disabled"
      myName = msg  if myName is false
      status.text myName + ": "
      input.removeAttr("disabled").focus()

  setInterval ->
    if connection.readyState isnt 1
      status.text 'Error'
      input.attr("disabled", "disabled").val 'Unable to comminucate with the WebSocket server.'
  , 3000

  addMessage = (author, message, dt) ->
    content.prepend "<p><span>" + author + "</span> @ " + +((if dt.getHours() < 10 then "0" + dt.getHours() else dt.getHours())) + ":" + ((if dt.getMinutes() < 10 then "0" + dt.getMinutes() else dt.getMinutes())) + ": " + message + "</p>"
