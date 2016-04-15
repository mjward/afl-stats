class AddJumperToTeamPlayers < ActiveRecord::Migration
  def change
    add_column :team_players, :jumper, :integer
  end
end
