module Scrapers
  module AFLTables
    module Fragments
      module MatchData
        class AwayTeam
          attr_reader :node
          def initialize(node)
            @node = node
          end

          def name
            ::Scrapers::InputSanitizer.new(node.search("td")[0].text).execute
          end

          def scoreline
            ::Scrapers::InputSanitizer.new(node.search("td")[1].text.split(" ")).execute
          end

          def final_score
            ::Scrapers::InputSanitizer.new(node.search("td")[2].text).execute
          end

          def valid?
            node.search("td").count == 4 # Something unexpected
          end
        end
      end
    end
  end
end
