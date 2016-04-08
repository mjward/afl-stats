module Scrapers
  module AFLTables
    module Fragments
      module PlayerData
        class PlayerMetric
          attr_reader :node, :metric
          def initialize(node, metric)
            @node = node
            @metric = metric
          end

          def player_name
            name = ::Scrapers::InputSanitizer.new(node.search("td")[0].text).execute
            name = name.split(",").map(&:strip)
            "#{name[1]} #{name[0]}"
          end

          def rounds
            round_columns.each.with_index.inject({}) do |result,(value,index)|
              metric_hash = {}
              metric_hash[metric] = value.text
              result[(index+1).to_s] = metric_hash
              result
            end
          end

          def to_hash
            hash = {}
            hash[player_name] = { rounds: rounds }
            hash
          end

          private

          def round_columns
            round_columns = node.search("td").drop(1)
            round_columns.pop
            round_columns
          end
        end
      end
    end
  end
end
