module AFLTables
  class DataFile

    attr_reader :json

    def initialize(json)
      @json = json
    end

    def write
      File.open("data/#{year}-#{round}.json", "w") do |f|
        f.write(JSON.pretty_generate(json))
      end
    end

    private

    def year
      json[:year]
    end

    def round
      json[:round]
    end

  end
end
