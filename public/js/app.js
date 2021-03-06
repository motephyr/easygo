      function debug(str)
      {
        $("#debug").append("<p>" + str + "</p>");
      };

      $(document).ready(function()
      {
        if (!("WebSocket" in window))
        {
          alert("Sorry, WebSockets unavailable.");
          return;
        }

        var ws = new WebSocket("ws://localhost:9000/chat");
        ws.onmessage = function(evt) { 
          $("#msg").append("<p>" + evt.data + "</p>");
          $("#wrap").scrollTop( $(document).height()+100 ); 
        };
        ws.onclose = function() { debug("socket closed"); };
        ws.onopen = function() { debug("connected..."); };

        $('#submit').click(function()
        {
          var nick = $('#nick').val();
          var msg = $('#message').val();

          ws.send(nick + ": " + msg);
          return false;
        });
      });