require '../test_helper'

mock_path_file = """
# Some comments
# Some comments
#

/foo/bar/baz # In-line comment

# More comments
/fizz/buzz

"""

describe 'get-paths', ->
  write_mock_file 'path', mock_path_file
  run_command 'get-paths'

  it 'removes line comments', ->
    expect(@command_output).to.not.contain 'Some comments'
    expect(@command_output).to.not.contain 'More comments'

  it 'removes in-line comments', ->
    expect(@command_output).to.not.contain 'In-line comment'

  it 'returns new-line separated paths', ->
    expect(@command_output).to.match ///  ^/foo/bar/baz$  ///m
    expect(@command_output).to.match ///  ^/fizz/buzz$    ///m
