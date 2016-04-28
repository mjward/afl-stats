require 'cgi'

module Scrapers
  module TooSerious
    class FantasyScraper
      attr_reader :year

      # def initialize(year)
      #   @year = year
      # end

      def execute

          year = 2016
          round = 4

          # Choice of player stats we are after
          # adv vs std
          statsType = "player_stats_advanced"
          # statsType = "stats"


          pagination = (1..10)


          pagination.each do |page|
            # puts page
            doc = Nokogiri::HTML(scraped_html(page, year, round, statsType))

            data = doc.search('.stats-row')

            playerdata = data.search('tr')

            # we will need to get player ids, pcid for later scrapping...
            playerLinkInfo = playerdata.search('td[5] a')[0]['href']
            playerLinkArray = Rack::Utils.parse_nested_query(playerLinkInfo)

            # I think this is the overal player ID. ie Gary Ablett
            pid = playerLinkArray['/forum/player_career.php?id']

            # I think this is the players id, for this season. Think Gary Ablett @ Suns
            # as opposed to Gary Ablett at G.Troit... hence the high numbers
            pcid =  playerLinkArray['pcid']
            pname = playerLinkArray['pname']


            #
            # eg. of url for player info on player per current year
            # "player.php?id=#{pid}&pcid=#{pcid}"
            #

            if statsType == 'stats'
              team        = playerdata.search('td[3] img').map{ |image| image['title'] }
              salary      = playerdata.search('td[6]').text
              total       = playerdata.search('td[7]').text
              game        = playerdata.search('td[8]').text
              movement    = playerdata.search('td[9]').text
              ytd         = playerdata.search('td[10]').text
              points      = playerdata.search('td[11]').text
              be          = playerdata.search('td[12]').text
              ave         = playerdata.search('td[13]').text
              nxtRndOne   = playerdata.search('td[14]').text
              nxtRndTwo   = playerdata.search('td[15]').text
              nxtRndThree = playerdata.search('td[16]').text
              total       = playerdata.search('td[17]').text
              pos         = playerdata.search('td[2]').text

            elsif statsType == 'player_stats_advanced'
              scDtRatio     = playerdata.search('td[6]').text
              kickHbRation  = playerdata.search('td[7]').text
              efficiency    = playerdata.search('td[8]').text
              contPos       = playerdata.search('td[9]').text
              uncontPos     = playerdata.search('td[10]').text
              contMark      = playerdata.search('td[11]').text
              uncontMark    = playerdata.search('td[12]').text
              inFifty       = playerdata.search('td[13]').text
              scoreAssists  = playerdata.search('td[14]').text
              clearances    = playerdata.search('td[15]').text
              clangers      = playerdata.search('td[16]').text
              timeOnGround  = playerdata.search('td[17]').text
            end

            puts "------"

          end
      end

      private

      def conn
        # need to replace team name, and number for url to work...
        Faraday.new(:url => 'http://tooserious.net/forum/') do |builder|
          builder.adapter  :net_http
        end
      end


      def scraped_html(page, year, round, statsType)
        conn.get("stats.php?&comp=SC&team=ADE,BRL,CAR,COL,ESS,FRE,GCS,GEE,GWS,HAW,MEL,NTH,PTA,RIC,STK,SYD,WBD,WCE&pos=DEF,FWD,MID,RUC&salary=0&tsLeagueTeamId=&display_type=stats&sm_type=total&sm_type=total&year=#{year}&round=#{round}&page_num=#{page}&display_type=#{statsType}").body
      end

      def non_breaking_space
        Nokogiri::HTML("&#xA0;").text
      end
    end
  end
end