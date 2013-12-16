(function() {


  $(function() {
    var addMessage, connection, content, input, myName, status;
    content = $("#content");
    input = $("#input");
    status = $("#status");
    myName = false;
    connection = new WebSocket("ws://127.0.0.1:1337");
    connection.onopen = function() {
      input.removeAttr("disabled");
      return status.text("Choose name:");
    };
    connection.onerror = function(error) {
      return content.html($("<p>", {
        text: "Sorry, but there's some problem with your " + "connection or the server is down."
      }));
    };
    connection.onmessage = function(message) {
      var e, i, json, _results;
      try {
        json = JSON.parse(message.data);
      } catch (_error) {
        e = _error;
        console.log("This doesn't look like a valid JSON: ", message.data);
        return;
      }
      if (json.type === "history") {
        i = 0;
        _results = [];
        while (i < json.data.length) {
          addMessage(json.data[i].author, json.data[i].text, new Date(json.data[i].time));
          _results.push(i++);
        }
        return _results;
      } else if (json.type === "message") {
        input.removeAttr("disabled");
        return addMessage(json.data.author, json.data.text, new Date(json.data.time));
      } else {
        return console.log("Hmm..., I've never seen JSON like this: ", json);
      }
    };
    input.keydown(function(e) {
      var msg;
      if (e.keyCode === 13) {
        msg = $(this).val();
        if (!msg) {
          return;
        }
        connection.send(msg);
        $(this).val("");
        input.attr("disabled", "disabled");
        if (myName === false) {
          myName = msg;
        }
        status.text(myName + ": ");
        return input.removeAttr("disabled").focus();
      }
    });
    setInterval(function() {
      if (connection.readyState !== 1) {
        status.text('Error');
        return input.attr("disabled", "disabled").val('Unable to comminucate with the WebSocket server.');
      }
    }, 3000);
    return addMessage = function(author, message, dt) {
      return content.prepend("<p><span>" + author + "</span> @ " + +(dt.getHours() < 10 ? "0" + dt.getHours() : dt.getHours()) + ":" + (dt.getMinutes() < 10 ? "0" + dt.getMinutes() : dt.getMinutes()) + ": " + message + "</p>");
    };
  });

}).call(this);
