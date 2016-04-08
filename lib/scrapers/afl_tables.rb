module Scrapers
  module AFLTables
    def player_stat_metrics
      {
        "GM" => "Games played",
        "KI" => "Kicks",
        "MK" => "Marks",
        "HB" => "Handballs",
        "DI" => "Disposals",
        "DA" => "Disposal average",
        "GL" => "Goals",
        "BH" => "Behinds",
        "HO" => "Hit outs",
        "TK" => "Tackles",
        "RB" => "Rebound 50s",
        "IF" => "Inside 50s",
        "CL" => "Clearances",
        "CG" => "Clangers",
        "FF" => "Free kicks for",
        "FA" => "Free kicks against",
        "BR" => "Brownlow votes",
        "CP" => "Contested possessions",
        "UP" => "Uncontested possessions",
        "CM" => "Contested marks",
        "MI" => "Marks inside 50",
        "1%" => "One percenters",
        "BO" => "Bounces",
        "GA" => "Goal assist",
        "%P" => "Percentage of game played",
      }
    end
    module_function :player_stat_metrics
  end
end
