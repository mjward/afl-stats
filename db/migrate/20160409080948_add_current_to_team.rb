class AddCurrentToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :current, :boolean, false: true
  end
end
