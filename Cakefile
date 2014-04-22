exec = require 'executive'

task 'build', 'compile src/*.coffee to lib/*.js', ->
  exec './node_modules/.bin/coffee -bc -m -o lib/ src/'
  exec './node_modules/.bin/coffee -bc -m -o .test/ test/'

task 'watch', 'watch for changes and recompile project', ->
  exec './node_modules/.bin/coffee -bc -m -w -o lib/ src/'
  exec './node_modules/.bin/coffee -bc -m -w -o .test/ test/'

task 'gh-pages', 'Publish docs to gh-pages', ->
  brief = require 'brief'
  brief.update()

task 'test', 'Run tests', ->
  exec "NODE_ENV=test node_modules/.bin/mocha
        --colors
        --reporter spec
        --timeout 5000
        --compilers coffee:coffee-script/register
        --require postmortem/register
        #{grep}
        #{test}"

task 'publish', 'publish current version to NPM', ->
  exec [
    './node_modules/.bin/coffee -bc -o lib/ src/'
    'git push'
    'npm publish'
  ]
