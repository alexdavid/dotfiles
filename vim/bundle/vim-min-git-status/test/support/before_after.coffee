tmp = require 'tmp-promise'


module.exports = ->

  @Before ->
    @tmpDir = yield tmp.dir unsafeCleanup: yes
    yield @exec 'git init'
    yield @startVim()


  @After ->
    @terminal.destroy()
    @tmpDir.cleanup()
