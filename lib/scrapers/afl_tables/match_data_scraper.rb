module Scrapers
  module AFLTables
    class MatchDataScraper < BaseScraper
      attr_reader :year, :output

      def initialize(year)
        @year = year
        @output = { match_data: { year: year, rounds: {} }  }
      end

      def execute
        process_rounds
        write_data_file
      end

      private

      def process_rounds
        (1..22).each do |round|
          puts "Processing Round #{round}..."
          @output[:match_data][:rounds][round] = Fragments::MatchData::Round.new(raw_round_data(round)).to_hash
        end
      end

      def scraped_html
        conn.get("/afl/seas/#{year}.html") .body
      end

      def raw_round_data(round)
        doc = document.xpath("//a[@name='#{round}']/following-sibling::table[2]//table")
        doc.pop
        doc
      end
    end
  end
end
