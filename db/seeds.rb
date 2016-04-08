require_relative "./seeds/afl_team_data"
require_relative "./seeds/afl_venue_data"
require_relative "./seeds/afl_match_data"

def update_afl_teams(afl_team_data)
  afl_team_data.each do |data|
    team = Team.where(id: data[:id]).first_or_initialize
    team.update_attributes!(
      name: data[:name],
      code: data[:code],
      nickname: data[:nickname],
      afltables_url: data[:afltables_url],
    )
  end
end
puts 'Seeding AFL teams…'
update_afl_teams(afl_team_data)

def update_afl_venues(afl_venue_data)
  afl_venue_data.each do |data|
    venue = Venue.where(id: data[:id]).first_or_initialize
    venue.update_attributes!(
      name: data[:name],
      state: data[:state],
      country: data[:country]
    )
  end
end
puts 'Seeding AFL venues…'
update_afl_venues(afl_venue_data)

def update_match_data(afl_venue_data)

  teams = Team.all.inject({}) do |result,team|
    result[team.name] = team
    result
  end

  venues = Venue.all.inject({}) do |result,venue|
    result[venue.name] = venue
    result
  end

  afl_venue_data.each do |data|
    year = data["match_data"]["year"]
    rounds = data["match_data"]["rounds"]

    rounds.each do |round, round_data|
      round_data["matches"].each do |match|

        home_team_name = match["home_team"]["name"]
        ap home_team_name
        away_team_name = match["away_team"]["name"]
        ap away_team_name
        venue = match["venue"]

        home_team = teams[home_team_name]
        away_team = teams[away_team_name]

        start_match_datetime = match["datetime"]
        attendance = match["attendance"]
        venue_name = match["venue"]
        ap venue_name
        venue = venues[venue_name]

        home_final_score = match["home_team"]["final_score"]
        away_final_score = match["away_team"]["final_score"]

        match = Match.where(year: year, round: round).first_or_initialize
        match.home_team = home_team
        match.away_team = away_team
        match.started_at = start_match_datetime
        match.venue = venue
        match.venue_name = venue.name
        match.attendance = attendance
        match.home_team_name = home_team.name
        match.away_team_name = away_team.name
        match.home_score = home_final_score
        match.away_score = away_final_score
        match.save!
      end
    end
  end
end
puts 'Seeding AFL matches…'
update_match_data(afl_match_data)
