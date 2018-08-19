Promise = require 'bluebird'


module.exports = ->

  @When /^I wait a second$/, ->
    yield Promise.delay 1000
