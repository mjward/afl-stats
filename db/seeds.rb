require_relative "./seeds/afl_team_data"

def update_afl_teams(afl_team_data)
  afl_team_data.each do |data|
    team = Team.where(id: data[:id]).first_or_initialize
    team.update_attributes!(
      name: data[:name],
      code: data[:code],
      nickname: data[:nickname],
    )
  end
end

update_afl_teams(afl_team_data)
