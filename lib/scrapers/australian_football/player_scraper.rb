module Scrapers
  module AustralianFootball
    class PlayerScraper
      attr_reader :year

      def initialize(year)
        @year = year
      end

      def execute



        puts "Running"
        puts "#{year}"

        mapping.each do |team_name, slug|
          json = {
            team_player_data: {
              year: year,
              teams: {}
            }
          }

          puts " --> #{team_name}"

          team = []

          doc = Nokogiri::HTML(scraped_html(slug))

          data = doc.css('.stats_body')

          playerdata = data.search(".former")

          playerdata.each do |player|


            #names are lastname, firstname. Need to split this bitch out!
            fullname  = player.search(".player_name_td").text
            namearray = fullname.split(",").map(&:strip)

            jumper    = player.search(".j_td").text
            firstname = Scrapers::InputSanitizer.new(namearray[1]).execute
            lastname  = Scrapers::InputSanitizer.new(namearray[0]).execute
            dbname    = "#{namearray[1]} #{namearray[0]}"
            dob       = player.search(".dob_td").text
            height    = player.search(".height_td").text
            weight    = player.search(".weight_td").text


            #puts "#{jumper} #{dbname} | DOB: #{dob} Height: #{height} Weight #{weight} "

            team << { firstname: firstname, lastname: lastname,  jumper: jumper, dob: dob, height: height, weight: weight }
          end

        json[:team_player_data][:teams][team_name] = team
        Scrapers::DataFile.new(json, "#{team_name.downcase.gsub(" ","_")}.json").write

        end
      end

      private

      def conn
        # need to replace team name, and number for url to work...
        Faraday.new(:url => 'http://australianfootball.com/clubs/every_player/') do |builder|
          builder.adapter  :net_http
        end
      end

      # South Melbourne

      def mapping
          {
          "Adelaide"               =>  "adelaide/1",
          "Brisbane"               =>  "brisbane/2",
          "Carlton"                =>  "carlton/3",
          "Collingwood"            =>  "collingwood/4",
          "Essendon"               =>  "essendon/5",
          "Fitzroy"                =>  "fitzroy/31",
          "Fremantle"              =>  "fremantle/6",
          "Geelong"                =>  "geelong/7",
          "Gold Coast"             =>  "gold%2Bcoast/29",
          "Greater Western Sydney"  =>  "gws/27",
          "Hawthorn"                =>  "hawthorn/28",
          "Melbourne"               =>  "melbourne/8",
          "North Melbourne"         =>  "north%2Bmelbourne/13",
          "Port Adelaide"           =>  "port%2Badelaide/9",
          "Richmond"                =>  "richmond/10",
          "St Kilda"                =>  "st%2Bkilda/12",
          "Sydney"                  =>  "sydney/11",
          "West Coast"              =>  "west%2Bcoast/15",
          "Western Bulldogs"        =>  "western%2Bbulldogs/14",
          "University"              =>  "university/32"
        }
      end

      def scraped_html(team)
        conn.get("#{team}/season_from/#{year}/season_to/#{year}/league/138/competition/1/division/all/ground/all/round_type/all/limit/500/filter/show") .body
      end


      def non_breaking_space
        Nokogiri::HTML("&#xA0;").text
      end
    end
  end
end