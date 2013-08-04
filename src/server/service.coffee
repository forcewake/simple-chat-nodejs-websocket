Chat = require './chat.coffee'

port = 1337

chat = new Chat()
.createServer()
.setServerPort(port)
.createWebSocketServer()
.setWebSocketServerRequestProcessing()