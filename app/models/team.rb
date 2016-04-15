class Team < ActiveRecord::Base
  has_many :player

  has_and_belongs_to_many :team_players
end
