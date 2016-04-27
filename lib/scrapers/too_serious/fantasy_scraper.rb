module Scrapers
  module TooSerious
    class FantasyScraper
      attr_reader :year

      # def initialize(year)
      #   @year = year
      # end

      def execute

          # (1..10).each do |page|
            # puts page
            doc = Nokogiri::HTML(scraped_html())

            data = doc.search('.stats-row')

            playerdata = data.search('tr td[5] a').map { |link| link['href'] }
            team = data.search('tr td[3] img').map{ |image| image['title'] }
            puts playerdata

            # playerlink
            # this will be the href to the individual players data we need,
            # the default href is to player_carrer. If we follow this href, we then
            # need to select the current year. We can short cut that by gsub'ing the url..

            # playerlink = playerdata.to_s.gsub("player_career.php","player.php")
            # puts playerlink

            # puts team
            puts "------"

          # end
      end

      private

      def conn
        # need to replace team name, and number for url to work...
        Faraday.new(:url => 'http://tooserious.net/forum/stats.php?&comp=SC&team=ADE,BRL,CAR,COL,ESS,FRE,GCS,GEE,GWS,HAW,MEL,NTH,PTA,RIC,STK,SYD,WBD,WCE&pos=DEF,FWD,MID,RUC&salary=0&tsLeagueTeamId=') do |builder|
          builder.adapter  :net_http
        end
      end


      def scraped_html()
        # display_type=player_stats_advanced
        # display_type=stats
        # sm_type=total
        # sm_type=ave
        conn.get("&page_num=3&display_type=stats&sm_type=total&year=2016&round=4").body
      end

      def non_breaking_space
        Nokogiri::HTML("&#xA0;").text
      end
    end
  end
end