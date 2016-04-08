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

      def write_data_file(filename_identifier)
        Scrapers::DataFile.new(output, filename_identifier).write
      end

    end
  end
end
