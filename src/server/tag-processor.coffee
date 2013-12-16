class TagProcessor
    constructor: ->
        @tagsToReplace =
        '&': '&amp;'
        '<': '&lt;'
        '>': '&gt;'

    escapeHtml: (str) ->
        str.replace /[&<>]/g, (tag) =>
            @tagsToReplace[tag] or tag

module.exports = TagProcessor