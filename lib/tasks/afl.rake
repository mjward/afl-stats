namespace :afltables do
  desc "Scrape AFLTables website for match data by year"
  task scrape: :environment do
    (2015..2016).each do |year|
      puts "### #{year}"
      Scrapers::AFLTables::MatchDataScraper.new(year).execute
    end
  end
end
