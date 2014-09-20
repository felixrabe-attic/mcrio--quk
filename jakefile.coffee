path = require 'path'
fs = require 'fs'
coffee = require 'coffee-script'

task 'default', ['build']

task 'build', ['clean'], ->  # src/**/*.coffee => lib/**/*.js
  for coffeeFile in coffeeFileList()
    jsFile = convertCoffeeToJsPath coffeeFile
    jake.mkdirP path.dirname jsFile
    compileCoffeeScript coffeeFile, jsFile

task 'clean', ->
  jake.rmRf 'lib'

coffeeFileList = ->
  list = new jake.FileList()
  list.include 'src/**/*.coffee'
  list.toArray()

convertCoffeeToJsPath = (coffeeFile) ->
  reldir = path.relative 'src', path.dirname coffeeFile
  jsDir = path.join 'lib', reldir
  jsBase = path.basename(coffeeFile).slice(0, -7) + '.js'
  path.join jsDir, jsBase

compileCoffeeScript = (inFilename, outFilename) ->
  console.log inFilename, '=>', outFilename
  coffeeSrc = fs.readFileSync inFilename, 'utf8'
  jsSrc = coffee.compile coffeeSrc, bare: true
  fs.writeFileSync outFilename, jsSrc, 'utf8'
