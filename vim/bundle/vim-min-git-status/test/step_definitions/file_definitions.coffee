module.exports = ->

  @Given /^I have an untracked file "([^"]+)"$/, (fileName) ->
    yield @exec "echo 'Initial content for #{fileName}' > #{fileName}"


  @Given /^I have (\d+) untracked files$/, (numFiles) ->
    for i in [0..numFiles]
      yield @exec "echo 'untracked file' > untracked_file_#{i}"


  @When /^I delete "([^"]+)"$/, (fileName) ->
    yield @exec "rm #{fileName}"


  @When /^I modify "([^"]+)"$/, (fileName) ->
    yield @exec "echo 'modify #{fileName}' >> #{fileName}"


  @When /^I rename "([^"]+)" to "([^"]+)"$/, (fileName, newName) ->
    yield @exec "mv #{fileName} #{newName}"
