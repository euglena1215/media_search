require "rubygems"
require "bundler"

Bundler.require
Dotenv.load

require 'open-uri'

class Label
	class << self
		def detect_labels(url)
			Aws.config.update({
 				region: ENV['AWS_REGION'],
  				credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'],ENV['AWS_SECRET_ACCESS_KEY'])
			})

			rekognition = Aws::Rekognition::Client.new(region: Aws.config[:region], credentials: Aws.config[:credentials])

			response_detect_labels = rekognition.detect_labels(
  				image: { bytes: OpenURI.open_uri(url) }
			)

			response_detect_labels.map(&:labels)[0].map(&:name)
		end
	end
end
