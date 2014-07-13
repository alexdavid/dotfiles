pty = require 'pty.js'
path = require 'path'
fs = require 'fs'

process.env.HOME = path.join __dirname, 'mock_home'
mock_term_opts =
  cols: 20
  rows: 20
  cwd: process.env.HOME
  env: process.env


GLOBAL.run_command = (command, command_args...) ->
  before (done) ->
    command_path = path.join __dirname, 'mock_home/.config/bin', command
    term = pty.spawn command_path, command_args, mock_term_opts
    @command_output = ''
    term.on 'data', (d) => @command_output += d
    term.on 'close', -> done()


GLOBAL.write_mock_file = (relative_file_path, data) ->
  absolute_file_path = path.join __dirname, 'mock_home/.config', relative_file_path
  before ->
    throw "Error: `#{relative_file_path}` already exists" if fs.existsSync absolute_file_path
    fs.writeFileSync absolute_file_path, data

  after ->
    fs.unlinkSync absolute_file_path
