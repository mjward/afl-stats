module AFLTables
  class Scraper

    attr_reader :year

    def initialize(year)
      @year = year
    end

    def execute
      puts "### #{year}"

      (1..22).each do |round|

        puts "Processing Round #{round}..."

        doc = Nokogiri::HTML(scraped_html)
        round_data = doc.xpath("//a[@name='#{round}']/following-sibling::table[2]//table")

        ladder_table = round_data.pop

        json = { year: year, round: round, matches: [], byes: [] }

        round_data.each do |match|
          home_team_data = match.search("tr")[0]
          away_team_data = match.search("tr")[1]

          next if home_team_data.search("td").count == 1

          home_team = home_team_data.search("td")[0].text
          home_team_scoreline = home_team_data.search("td")[1].text.gsub(non_breaking_space, "").split(" ")

          home_final_score = if home_team_scoreline[0] === "Bye"
            "Bye"
          else
            home_team_data.search("td")[2].text
          end

          venue = if home_team_scoreline[0] === "Bye"
            "Bye"
          else
            home_team_data.search("td[4]/a").first.text
          end

          if away_team_data
            away_team           = away_team_data.search("td")[0].text
            away_team_scoreline = away_team_data.search("td")[1].text.gsub(non_breaking_space, "").split(" ")
            away_final_score    = away_team_data.search("td")[2].text
          end

          if home_final_score === 'Bye'
            puts "  -> #{home_team} BYE"
          else
            puts "  -> #{home_team} vs #{away_team} @ #{venue}"
          end

          if home_team_data && away_team_data
            json[:matches] << {
              home_team: {
                name: home_team,
                scoreline: home_team_scoreline,
                final_score: home_final_score,
              },
              away_team: {
                name: away_team,
                scoreline: away_team_scoreline,
                final_score: away_final_score,
              },
              venue: venue,
            }
          else
            json[:byes] << home_team
          end
        end

        DataFile.new(json).write

      end
    end

    private

    def conn
      Faraday.new(:url => 'http://afltables.com') do |builder|
        builder.adapter  :net_http
      end
    end

    def scraped_html
      conn.get("/afl/seas/#{year}.html") .body
    end

    def non_breaking_space
      Nokogiri::HTML("&#xA0;").text
    end
  end
end
