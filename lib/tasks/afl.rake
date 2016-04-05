namespace :afltables do
  desc "Scrape AFLTables website for match data by year"
  task scrape: :environment do

    years = [2016, 2015]

    years.each do |year|
      AFLTables::Scraper.new(year).execute
    end
  end
end
