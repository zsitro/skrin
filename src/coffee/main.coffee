$ = require 'jquery'
require 'angular'

skrin = require './components/skrin.coffee'
isPage = require './components/ispage.coffee'

console.log 'skrin', skrin.version
console.log 'Angular', angular.version.full
console.log 'jQuery', $.fn.jquery

#Things here
if isPage 'index'
	console.log 'index page'
	skrin()
