require 'fileutils'

module Scrapers
  class DataFile

    attr_reader :json

    def initialize(json)
      @json = json
    end

    def write
      FileUtils::mkdir_p("data/#{type}")
      File.open("data/#{type}/#{year}.json", "w") do |f|
        f.write(JSON.pretty_generate(json))
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
