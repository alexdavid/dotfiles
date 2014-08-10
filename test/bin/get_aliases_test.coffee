require '../test_helper'

mock_aliases_file = """
# Some comments
# Some comments
#

 foo   =   bar # In-line comment
fizz   =   buzz

"""

describe 'get-aliases', ->
  write_mock_file 'aliases', mock_aliases_file
  run_command 'get-aliases', '--SEPARATOR--'

  it 'removes line comments', ->
    expect(@command_output).to.not.contain 'Some comments'

  it 'removes in-line comments', ->
    expect(@command_output).to.not.contain 'In-line comment'

  it 'returns new-line separated aliases with passed separator', ->
    expect(@command_output).to.match /^foo--SEPARATOR--'bar'$/m
    expect(@command_output).to.match /^fizz--SEPARATOR--'buzz'$/m
