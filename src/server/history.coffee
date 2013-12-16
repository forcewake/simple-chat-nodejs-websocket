class History
	constructor: () ->
		@messages = []

	add_message: (message) ->
		@messages.push message
		@messages.slice(-100)

	get_messages: ->
		@messages

module.exports = History