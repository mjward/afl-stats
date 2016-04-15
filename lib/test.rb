class Test

  def initialise
    @team = team
  end

  def testrun
    mapping.each do |key, value|
      puts key
    end
  end

  private

  def mapping
    {
      "adelaide/1"            => "Adelaide",
      "brisbane/2"            => "Brisbane",
      "carlton/3"             => "Carlton",
      "collingwood/4"         => "Collingwood",
      "essendon/5"            => "Essendon",
      "fitzroy/31 "           => "Fitzroy",
      "fremantle/6"           => "Fremantle",
      "geelong/7"             => "Geelong",
      "gold%2Bcoast/29"       => "Gold Coast",
      "gws/27"                => "Greater Western Sydney",
      "hawthorn/28"           => "Hawthorn",
      "melbourne/8"           => "Melbourne",
      "north%2Bmelbourne/13"  => "North Melbourne",
      "port%2Badelaide/9"     => "Port Adelaide",
      "richmond/10"           => "Richmond",
      "st%2Bkilda/12"         => "St Kilda",
      "sydney/11"             => "Sydney",
      "west%2Bcoast/15"       => "West Coast",
      "western%2Bbulldogs/14" => "Western Bulldogs",
      "university/32"         => "University"
    }
  end
end
