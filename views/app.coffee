$(document).ready ->
  if "WebSocket" of window
    ws = new WebSocket("ws://#{window.location.host}/chat")
    ws.onmessage = (evt) ->
      console.log evt
      $("#msg").prepend "<li>#{evt.data}</li>"

    ws.onclose = ->
      $("#debug").html "<p>socket closed</p>"

    ws.onopen = ->
      $("#debug").html "<p>connected...</p>"

    $("#submit").click ->
      nick = $("#nick").val()
      msg = $("#message").val()
      ws.send "#{nick}: #{msg}"
      false
  else
    alert "Sorry, WebSockets unavailable."
    return
