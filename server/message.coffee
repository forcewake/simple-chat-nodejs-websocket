class Message
	constructor: (text, time, author) ->
		@text = text
		@time = time
		@author = author

	get: ->
		"#{@time} #{@user_name}: #{@text}"

	get_time: ->
		@time

	get_text: ->
		@text

	get_author: ->
		@author

module.exports = Message 