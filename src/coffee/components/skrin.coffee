# Module dependencies
A = 				require 'angular'
$ = 				require 'jquery'
config = 			require '../skrin.config.coffee'

container = 		$('[ng-controller=skrinCtrl]')
viewport = 			$('.js-skrin-viewport')
browserWindow = 	$(window)
storage = 			localStorage
pack =				JSON.stringify
unpack =			JSON.parse

windowResolution = ->
	width: browserWindow.outerWidth()
	height: browserWindow.outerHeight()

getScope = ->
	angular.element(container).scope()

saveState = ->
	storage.setItem 'config', pack( getScope().data )

scale = ->
	console.log 'skrin.scale()', getScope().data.scale

	currentScale = (getScope().data.scale/100)
	console.log currentScale
	viewport.css
		'-webkit-transform': 'scale('+currentScale+')'
		'-moz-transform': 'scale('+currentScale+')'
		'-ms-transform': 'scale('+currentScale+')'
		'-o-transform': 'scale('+currentScale+')'
		'transform': 'scale('+currentScale+')'



init = ->
	console.log 'skrin.init()'

	# Merge config with data in localStorage (if exist)
	if storage.getItem('config')
		$.extend config, unpack(storage.getItem('config'))

	skrinApp = angular.module('skrinApp', [])

	skrinApp.controller('skrinCtrl', ($scope, $sce) ->

		$scope.data = config

		console.log 'config', config
		console.log '$scope.data', $scope.data

		index = 0
		$scope.data.resolutionOptions.some( (opt, i) ->
			if (opt.name == $scope.data.resolution.name)
				index = i;
				return true
		)

		# Array index needs to be referenced from data.resolutionOptions
		$scope.data.resolution = $scope.data.resolutionOptions[index]


		$scope.$watch( ->
			saveState()
		)

		$scope.$watch('data.scale', ->
			scale()
		)

		$scope.$watch('data.fitWidth', (newValue, oldValue) ->
			console.log newValue, oldValue

			if getScope().data.fitWidth
				console.log 'and... reflow'
				$scope.reflow()
			# else
				# $scope.data.scale = 100

		)

		$scope.$watch('data.resolution', (newValue, oldValue) ->
			console.log newValue, oldValue
			$scope.data.width = newValue.width
			$scope.data.height = newValue.height

			if getScope().data.fitWidth
				console.log 'and... reflow'
				$scope.reflow()
		)

		$scope.trustSrc = (src) ->
			$sce.trustAsResourceUrl(src)

		$scope.scaleCaption = (percent) ->
			~~percent


		$scope.reflow = ->
			calculatedScale = (windowResolution().width / $scope.data.resolution.width) * 100
			console.log 'calculatedScale', calculatedScale
			$scope.data.scale = calculatedScale

	)








module.exports = init
