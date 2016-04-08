module Scrapers
  module AFLTables
    class TeamGameByGameScraper < BaseScraper
      attr_reader :team, :year, :output

      def initialize(team, year)
        @team = team
        @year = year
        @output = { player_data: { year: year, players: {} }  }
      end

      def execute
        process_players
        write_data_file("#{team.name.downcase.gsub(" ", "_")}.json")
      end

      private

      def process_players
        puts "Processing #{team.name}..."
        result = raw_breakdown_data.inject({}) do |result,node|
          result.deep_merge(Fragments::PlayerData::MetricTable.new(node).to_hash)
        end
        @output[:player_data][team.name.downcase] = result
      end

      def scraped_html
        conn.get("/afl/stats/teams/adelaide/#{year}_gbg.html").body
      end

      def raw_breakdown_data
        @raw_breakdown_data ||= document.css("div.simpleTabsContent table")
      end
    end
  end
end
