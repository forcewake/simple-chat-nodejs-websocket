# Cakefile

{exec} = require "child_process"

task "test", "run tests", ->
  exec "NODE_ENV=test 
    mocha 
    --compilers coffee:coffee-script -R spec
    --colors
  ", (err, output) ->
    throw err if err
    console.log output