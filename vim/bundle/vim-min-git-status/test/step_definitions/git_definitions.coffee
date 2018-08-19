module.exports = ->

  @Given /^I commit changes to "([^"]+)" in "([^"]+)" branch$/, (fileName, branchName) ->
    yield @exec "git checkout #{branchName}"
    yield @exec "echo 'modify #{fileName} in #{branchName}' >> #{fileName}"
    yield @exec "git add #{fileName}"
    yield @exec "git commit -m 'Modify #{fileName}'"
    yield @exec "git checkout -"


  @Given /^I delete "([^"]+)" in "([^"]+)" branch$/, (fileName, branchName) ->
    yield @exec "git checkout #{branchName}"
    yield @exec "git rm #{fileName}"
    yield @exec "git commit -m 'Remove #{fileName}'"
    yield @exec "git checkout -"


  @Given /^I have a committed file "([^"]+)"$/, (fileName) ->
    yield @exec "echo 'Initial content for #{fileName}' > #{fileName}"
    yield @exec "git add #{fileName}"
    yield @exec "git commit -m 'Add #{fileName}'"


  @Given /^I have a "([^"]+)" branch$/, (branchName) ->
    yield @exec "git branch #{branchName}"


  @When /^I add "([^"]+)" to the index$/, (fileName) ->
    yield @exec "git add #{fileName}"


  @When /^I merge "([^"]+)" into "([^"]+)"$/, (fromBranch, toBranch) ->
    yield @exec "git checkout #{toBranch}"
    yield @exec "git merge #{fromBranch}", allowError: yes


  @When /^I remove "([^"]+)" from the index$/, (fileName) ->
    yield @exec "git rm #{fileName}"
