spawn = require('child_process').spawn
colors = require 'colors'
pipe = (p)->
  p.stdout.on 'data', (d)->
    console.log d.toString()
  p.stderr.on 'data', (d)->
    console.log d.toString()
task 'dev', 'compile coffee and put into correct dirs', ->
  s = spawn 'coffee', ['-o', 'lib/',  '-cw', 'src/']
  pipe s

# mocha test
test = (callback, env = process.env) ->
  try
    cmd = __dirname + '/node_modules/.bin/mocha'
    process.env.NODE_PATH = process.cwd() + '/Resources'
    spec = spawn cmd, ['--compilers','coffee:coffee-script','--colors','--require','should', '-R', 'landing', '--timeout', '3000']
    pipe spec
    spec.on 'exit', (status) -> callback?() if status is 0
  catch err
    console.log err.message.red
    console.log 'Mocha is not installed - try npm install mocha -g'.red

task 'test', 'mocha',->
  test ->
    console.log 'complete'
