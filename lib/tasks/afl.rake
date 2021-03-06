namespace :afl do
  namespace :scrape do
    desc "Scrape AFLTables website for match data by year"
    task match_data: :environment do
      (1932..1970).each do |year|
        puts "### #{year}"
        Scrapers::AFLTables::MatchDataScraper.new(year).execute
      end
    end

    desc "Scrape AFLTables website for player data by year"
    task player_match_data: :environment do
      Team.all.each do |team|
        (2012..2016).each do |year|
          puts "### #{team.name} #{year}"
          Scrapers::AFLTables::TeamGameByGameScraper.new(team, year).execute
        end
      end
    end


    desc "Scrape AusFootbal website for player info"
    task player_data: :environment do
      # Team.all.each do |team|
        (1971..2016).each do |year|
          puts "### #{year}"
          Scrapers::AustralianFootball::PlayerScraper.new(year).execute
        end
      # end
    end


    desc "Scrape FootyWire website for super coach data"
    task fantasy_data: :environment do
        (2010..2016).each do |year|
          puts "### #{year}"
          Scrapers::FootyWire::FantasyScraper.new(year).execute
        end
    end

  end
end
