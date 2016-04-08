module Scrapers
  module AFLTables
    module Fragments
      module PlayerData
        class MetricTable
          attr_reader :node
          def initialize(node)
            @node = node
            puts "  -> #{metric}"
          end

          def players
            player_rows.inject({}) do |result, row|
              result.deep_merge(Fragments::PlayerData::PlayerMetric.new(row, metric).to_hash)
            end
          end

          def to_hash
            {
              players: players
            }
          end

          private

          def player_rows
            node.search("tbody/tr")
          end

          def metric
            node.search("thead/tr/th").first.text
          end
        end
      end
    end
  end
end
