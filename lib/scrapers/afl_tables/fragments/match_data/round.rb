module Scrapers
  module AFLTables
    module Fragments
      module MatchData
        class Round
          attr_reader :node_set

          STANDARD_MATCH_COLUMNS = 8
          BYE_COLUMNS = 2

          def initialize(node_set)
            @node_set = node_set
          end

          def matches
            node_set.select { |match_node| match_node.search("tr/td").count == STANDARD_MATCH_COLUMNS }.map do |match_node|
              Fragments::MatchData::Match.new(match_node)
            end
          end

          def byes
            node_set.select { |match_node| match_node.search("tr/td").count == BYE_COLUMNS }.map do |match_node|
              Fragments::MatchData::Bye.new(match_node)
            end
          end

          def to_hash
            {
              matches: matches.map(&:to_hash),
              byes: byes.map(&:team_name),
            }
          end
        end
      end
    end
  end
end
