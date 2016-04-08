require_relative "./seeds/afl_team_data"

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

update_afl_teams(afl_team_data)

require_relative "./seeds/afl_venue_data.rb"

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

update_afl_venues(afl_venue_data)
