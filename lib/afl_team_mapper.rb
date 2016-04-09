class AFLTeamMapper
  attr_reader :team_name
  def initialize(team_name)
    @team_name = team_name
  end

  def execute
    mapping.keys.include?(team_name) ? mapping[team_name] : team_name
  end

  private

  def mapping
    {
      "Brisbane Bears" => "Brisbane",
      "Brisbane Lions" => "Brisbane",
      "Kangaroos" => "North Melbourne",
      "Footscray" => "Western Bulldogs",
    }
  end
end
