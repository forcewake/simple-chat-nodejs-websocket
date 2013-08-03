Chai = require 'chai'
Chai.should()

History = require '../server/history.coffee'

describe 'History', ->
	history = null

	it 'should have a array container', ->
		history = new History
		history.messages.should.to.be.an 'array'

	it 'should have an empty container for messages', ->
		history = new History
		history.messages.should.to.be.empty

	it 'should be able to accept new messages', ->
		history = new History
		message = 
			text: 'message'

		history.add_message message
		history.messages.should.have.length 1
		history.messages[0].text.should.to.be.equal 'message'

	it 'should be able to return all messages', ->
		history = new History
		message_1 = 
			text: 'message_1'
		message_2 = 
			text: 'message_2'
		history.add_message message_1
		history.add_message message_2
		history.get_messages().length.should.to.be.equal 2
		history.get_messages().should.contain message_1
		history.get_messages().should.contain message_2