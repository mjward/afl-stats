class AddHeightWeightToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :weight, :integer
    add_column :players, :height, :integer
  end
end
