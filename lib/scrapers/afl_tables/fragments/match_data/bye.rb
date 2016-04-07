module Scrapers
  module AFLTables
    module Fragments
      module MatchData
        class Bye
          attr_reader :node
          def initialize(node)
            @node = node
            puts "  -> #{team_name} BYE"
          end

          def team_name
            ::Scrapers::InputSanitizer.new(node.search("td")[0].text).execute
          end
        end
      end
    end
  end
end
