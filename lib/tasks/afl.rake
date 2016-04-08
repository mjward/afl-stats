namespace :afltables do
  namespace :scrape do
    desc "Scrape AFLTables website for match data by year"
    task matches: :environment do
      (2015..2016).each do |year|
        puts "### #{year}"
        Scrapers::AFLTables::MatchDataScraper.new(year).execute
      end
    end

    desc "Scrape AFLTables website for player data by year"
    task players: :environment do
      Team.all.each do |team|
        [2016].each do |year|
          puts "### #{team.name} #{year}"
          Scrapers::AFLTables::TeamGameByGameScraper.new(team, year).execute
        end
      end
    end
  end
end
