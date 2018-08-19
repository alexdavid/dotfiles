module.exports = ->

  @Given /^my terminal is (\d+) rows high$/, (rows) ->
    yield @resize {rows}


  @When /^I run :([^ ]+)(?: again)?/, (vimCommand) ->
    @terminal.write ":#{vimCommand}\n"
    yield @waitForTerminal()


  @When /^I type "([^"]+)" to .+$/, (key) ->
    @terminal.write key
    yield @waitForTerminal()


  @Then /^I see$/, (block) ->
    if @termBuffer.toString().indexOf(block) is -1
      throw Error "Terminal:\n#{@termBuffer.toString()}\n\nExpected:\n#{block}"


  @Then /^I don't see Gministatus$/, ->
    if @termBuffer.toString().indexOf('.git/mini-status') isnt -1
      throw Error "Expected Gministatus to be closed but saw:\n#{@termBuffer.toString()}"


  @Then /^Gministatus only takes up (\d+) lines$/, (expectedLines) ->
    @terminal.write ":echo 'LINES:' . winheight(0) . ';;'\n"
    yield @waitForTerminal()
    [match, actualLines] = @termBuffer.toString().match(/LINES:(\d+);/) ? []
    throw Error "Expected to see LINES: but saw: #{@termBuffer.toString()}" unless match?
    throw Error "Expected Gministatus to have #{expectedLines} but was #{actualLines}" unless actualLines is expectedLines
