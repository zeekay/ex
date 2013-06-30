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
  exec './node_modules/.bin/mocha .test/ --compilers coffee:coffee-script -R spec --require test/_helper.js -t 5000 -c'

task 'publish', 'publish current version to NPM', ->
  exec [
    './node_modules/.bin/coffee -bc -o lib/ src/'
    'git push'
    'npm publish'
  ]
