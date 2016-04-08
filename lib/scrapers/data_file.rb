require 'fileutils'

module Scrapers
  class DataFile

    attr_reader :json, :filename

    def initialize(json, filename)
      @json = json
      @filename = filename
    end

    def write
      FileUtils::mkdir_p("data/#{type}/#{year}")
      File.open("data/#{type}/#{year}/#{filename}", "w") do |file|
        file.write(JSON.pretty_generate(json))
      end
    end

    private

    def type
      json.keys.first
    end

    def year
      json[type][:year]
    end
  end
end
