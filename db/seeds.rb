require_relative "./seeds/afl_team_data"
require_relative "./seeds/afl_venue_data"
require_relative "./seeds/afl_match_data"
require_relative "./seeds/afl_player_data"

def update_afl_teams(afl_team_data)
  afl_team_data.each do |data|
    team = Team.where(id: data[:id]).first_or_initialize
    team.update_attributes!(
      name: data[:name],
      code: data[:code],
      nickname: data[:nickname],
      current: data[:current],
      afltables_url: data[:afltables_url],
    )
  end
end
puts
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
        print "."
        home_team_name = AFLTeamMapper.new(match["home_team"]["name"]).execute
        away_team_name = AFLTeamMapper.new(match["away_team"]["name"]).execute
        venue = match["venue"]

        home_team = teams[home_team_name]
        away_team = teams[away_team_name]

        start_match_datetime = match["datetime"]
        attendance = match["attendance"].nil? ? nil : match["attendance"].gsub(",", "")

        venue_name = match["venue"]
        venue = venues[venue_name]

        home_scoreline = match["home_team"]["scoreline"]
        away_scoreline = match["away_team"]["scoreline"]
        if !home_scoreline.nil?
          home_q1 = home_scoreline[0]
          home_q2 = home_scoreline[1]
          home_q3 = home_scoreline[2]
          home_q4 = home_scoreline[3]
        end

        if !away_scoreline.nil?
          away_q1 = away_scoreline[0]
          away_q2 = away_scoreline[1]
          away_q3 = away_scoreline[2]
          away_q4 = away_scoreline[3]
        end

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
        match.home_q1 = home_q1
        match.home_q2 = home_q2
        match.home_q3 = home_q3
        match.home_q4 = home_q4
        match.away_q1 = away_q1
        match.away_q2 = away_q2
        match.away_q3 = away_q3
        match.away_q4 = away_q4
        match.home_score = home_final_score
        match.away_score = away_final_score
        match.save!
      end
    end
  end
end
puts 'Seeding AFL matches…'
update_match_data(afl_match_data)

def date_parse(date)
    DateTime.parse(player["dob"])
rescue
end



def update_player_data(afl_player_data)

  teams = Team.all.inject({}) do |result,team|
    result[team.name] = team
    result
  end

  afl_player_data.each do |data|

    year = data["team_player_data"]["year"]

    team_name = data["team_player_data"]["teams"].keys.first
    mapped_team_name = AFLTeamMapper.new(team_name).execute

    team = teams[mapped_team_name]

    print "#{year} #{team.name}"

    data["team_player_data"]["teams"][team_name].each do |player|
      print "."

      if player["dob"] != "—"
        dob = player["dob"]
      end

      if player["weight"] != "—"
        weight = player["weight"]
      end

      if player["height"] != "—"
        height = player["height"]
      end

      if player["jumper"] != "—"
        jumper = player["jumper"]
      end


      newplayer        = Player.where(first_name: player["firstname"], last_name: player["lastname"], dob: date_parse(dob)).first_or_initialize
      newplayer.height = height.try(:gsub, "cm", "")
      newplayer.weight = weight.try(:gsub, "kg", "")
      newplayer.dob    = dob
      newplayer.save!

      team_player         = TeamPlayer.where(player: newplayer, team: team, year: year).first_or_initialize
      team_player.year    = year
      team_player.jumper  = jumper


      team_player.save!
    end
    puts
  end
end
puts 'Seeding AFL players…'
update_player_data(afl_player_data)


