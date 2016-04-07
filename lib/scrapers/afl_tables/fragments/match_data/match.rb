module Scrapers
  module AFLTables
    module Fragments
      module MatchData
        class Match
          attr_reader :node
          def initialize(node)
            @node = node
            puts "  -> #{home_team.name} vs #{away_team.name} @ #{summary.venue}"
          end

          def home_team
            HomeTeam.new(node.search("tr")[0])
          end

          def away_team
            AwayTeam.new(node.search("tr")[1])
          end

          def summary
            Summary.new(home_team.search("td[4]"))
          end

          def to_hash
            {
              datetime:   summary.match_start_time,
              attendance: summary.attendance,
              venue:      summary.venue,
              home_team: {
                name:         home_team.name,
                scoreline:    home_team.scoreline,
                final_score:  home_team.final_score,
              },
              away_team: {
                name:         away_team.name,
                scoreline:    away_team.scoreline,
                final_score:  away_team.final_score,
              }
            }
          end
        end
      end
    end
  end
end
