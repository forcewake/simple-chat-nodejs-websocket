class Participants
	constructor: ->
		@participants = []

	add: (participant) ->
		@participants.push participant

	send_all: (message) ->
		for client in @participants
			client.sendUTF(message)

module.exports = Participants