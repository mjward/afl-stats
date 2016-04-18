module Scrapers
  module FootyWire
    class FantasyScraper
      attr_reader :year

      def initialize(year)
        @year = year
      end

      def execute
        puts "Fantasy Scrape"
        puts "#{year}"

          (1..22).each do |round|

          doc = Nokogiri::HTML(scraped_html(round))

          data = doc.search('div table tr[2] td[2] table')
          playerinfo = data.search('table tr')

          playerinfo.each do |playerdata|
            playername    =  playerdata.search('td[2]').text
            playerteam    =  playerdata.search('td[3]').text
            price         =  playerdata.search('td[5]').text
            round         = round
            score         = playerdata.search('td[6]').text

            puts "The player #{playername} scored #{score} in round #{round}"
          end

        end
        # json[:team_player_data][:teams][team_name] = team
        # Scrapers::DataFile.new(json, "#{team_name.downcase.gsub(" ","_")}.json").write

        # end
      end

      private

      def conn
        # need to replace team name, and number for url to work...
        Faraday.new(:url => 'http://www.footywire.com/afl/footy/') do |builder|
          builder.adapter  :net_http
        end
      end


      def scraped_html(round)
        conn.get("supercoach_round?year=2010&round=#{round}&p=&s=T").body
      end


      def non_breaking_space
        Nokogiri::HTML("&#xA0;").text
      end
    end
  end
end