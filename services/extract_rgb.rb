require "rubygems"
require "bundler"

Bundler.require

require "open-uri"
require "FileUtils"

require "rmagick"

include Magick

class ExtractRgb
  class << self
    def extract(filename, url)
      filepath = export_image(filename, url)

      colors = ImageList.new(filepath)[0].export_pixels.map { |pix| pix/257 }.each_slice(3).to_a
      File.delete(filepath) if File.exist?(filepath)
      colors.transpose.map { |color| color.sum / color.size }
    end

    private

      def export_image(filename, url)
        dirname = "tmp/"
        filepath = dirname + filename
        FileUtils.mkdir_p(dirname) unless FileTest.exist?(dirname)
        open(filepath, 'wb') do |output|
          open(url) do |data|
            output.write(data.read)
          end
        end
        filepath
      end
  end
end
