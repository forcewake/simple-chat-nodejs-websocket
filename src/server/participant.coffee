class Participant
	constructor: (connection, name) ->
		@connection = connection
		@time = (new Date()).getTime()
		@name = name

	get_name: ->
		@name

module.exports = Participant