module Scrapers
  module AFLTables
    module Fragments
      module MatchData
        class Summary
          attr_reader :node
          def initialize(node)
            @node = node
          end

          def date
            match_summary[0]
          end

          def time
            match_summary[1]
          end

          def attendance
            match_summary[2]
          end

          def venue
            match_summary[3]
          end

          def match_start_time
            DateTime.parse("#{date} #{time}").utc
          rescue
          end

          private

          def match_summary
            @parse_match_summary ||= node.text.scan(summary_regex).flatten
          end

          def summary_regex
            /(\w{3}\s{1}\d{2}-\w{3}-\d{4})(?:\s)(\d{1,2}:\d{1,2}\s\w{2})?(?:\s\(\d{1,2}:\d{1,2}\s\w{2}\))?\s?(?:Att:)?(\d+,\d+)?\s?(?:Venue:\s)([a-zA-Z. ]*)?/
          end
        end
      end
    end
  end
end
