module Scrapers
  module AFLTables
    class BaseScraper

      private

      def conn
        Faraday.new(:url => configatron.afltables.url) do |builder|
          builder.adapter  :net_http
        end
      end

      def scraped_html
        conn.get("/afl/seas/#{year}.html") .body
      end

      def document
        Nokogiri::HTML(scraped_html)
      end

      def non_breaking_space
        Nokogiri::HTML("&#xA0;").text
      end

      def process_input(data)
        if data.is_a?(Array)
          data = data.map { |e| clean_input(e) }.reject(&:empty?)
        else
          data = clean_input(data)
        end
        data.nil? || data.empty? ? nil : data
      end

      def clean_input(data)
        data.gsub(non_breaking_space, "").gsub(/\A[[:space:]]+|[[:space:]]+\z/, '').strip
      end

      def write_data_file
        Scrapers::DataFile.new(output).write
      end

    end
  end
end
