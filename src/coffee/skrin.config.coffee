
config =
	url: 'about.html'
	scale: 1
	width: 1920
	height: 1600
	fitWidth: true
	fitHeight: false
	resolutionOptions : [
		{
			name: 'iMac 27" (2560×1440)'
			width: 2560
			height: 1440
		}
		{
			name: 'fullHD 16:10 (1920×1200)'
			width: 1920
			height: 1200
		}
		{
			name: 'fullHD 16:9 (1920×1080)'
			width: 1920
			height: 1080
		}
		{
			name: 'Macbook Pro 16:10 (1280×800)'
			width: 1280
			height: 800
		}
		# {
		# 	name: 'Test app on large screen (1024×768)'
		# 	width: 1024
		# 	height: 768
		# }
	]

config.resolution = config.resolutionOptions[3]

module.exports = config
