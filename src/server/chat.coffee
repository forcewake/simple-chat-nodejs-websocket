http = require 'http'
WebSocketServer = require('websocket').server
History = require './history.coffee'
Participant = require './participant.coffee'
Message = require './message.coffee'
Participants = require './participants.coffee'

class Chat
	constructor: ->
		@history = new History()
		@participants = new Participants()

	createServer: ->
		@http_server = http.createServer (request, response) ->
			console.log "#{(new Date())} Received request for #{request.url}"
			response.writeHead 404
			do response.end
		@

	setServerPort: (@port) ->
		@http_server?.listen @port, =>
			console.log "#{(new Date())} HTTP server is listening on port #{@port}"
		@

	createWebSocketServer: ->
		@websocket_server = new WebSocketServer
			httpServer: @http_server
		@

	setWebSocketServerRequestProcessing: ->
		@websocket_server.on 'request', (request) =>
			connection = request.accept null, request.origin
			console.log "#{(new Date())} connection from #{request.origin}"

			@participants.add connection

			messages = @history.get_messages()
			
			userName = false

			if messages.length > 0
				connection.sendUTF JSON.stringify
					type: 'history'
					data: messages
			connection.on 'message', (message) =>
				if message.type is 'utf8'
					if userName is false
						userName = message.utf8Data
						console.log "#{(new Date())} User is known as: #{userName}"
					else
						console.log "#{(new Date())} Received Message from #{userName}: #{message.utf8Data}"
						one_message = new Message message.utf8Data, (new Date()), userName

						@history.add_message one_message
						messages = @history.get_messages
						json = JSON.stringify
							type: 'message'
							data: one_message
						@participants.send_all json

module.exports = Chat