Chai = require 'chai'
Chai.should()

Message = require '../server/message.coffee'

describe 'Message', ->
	message = null

	it 'should have a text property', ->
		text = 'text'

		message = new Message(text)

		message.text.should.not.be.a('object');
		message.text.should.not.be.empty
		message.text.should.have.length 4
		message.text.should.be.equal text
	
	it 'should have a time property', ->
		text = 'text'
		time = (new Date())

		message = new Message(text, time)

		message.time.should.not.be.a('object');
		message.time.should.be.equal time

	it 'should have a author property', ->
		text = 'text'
		time = (new Date())
		author = 'author'

		message = new Message(text, time, author)

		message.author.should.not.be.a('object');
		message.author.should.not.be.empty
		message.author.should.have.length 6
		message.author.should.be.equal author

	it 'should have a getter for text property', ->
		text = 'text'

		message = new Message(text)

		message.get_text().should.not.be.a('object');
		message.get_text().should.not.be.empty
		message.get_text().should.have.length 4
		message.get_text().should.be.equal text

	it 'should have a getter for time property', ->
		text = 'text'
		time = (new Date())

		message = new Message(text, time)

		message.get_time().should.not.be.a('object');
		message.get_time().should.be.equal time

	it 'should have a getter for author property', ->
		text = 'text'
		time = (new Date())
		author = 'author'

		message = new Message(text, time, author)

		message.get_author().should.not.be.a('object');
		message.get_author().should.not.be.empty
		message.get_author().should.have.length 6
		message.get_author().should.be.equal author