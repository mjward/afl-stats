class MatchPlayerStats < ActiveRecord::Migration
  def change
     create_table :match_player_stats do |t|
      t.integer :player_id
      t.integer :match_id
      t.integer :disposals
      t.integer :kicks
      t.integer :marks
      t.integer :handballs
      t.integer :goals
      t.integer :behinds
      t.integer :hit_outs
      t.integer :tackles
      t.integer :rebounds
      t.integer :inside_50s
      t.integer :clearances
      t.integer :clangers
      t.integer :frees
      t.integer :frees_against
      t.integer :contested_possessions
      t.integer :uncontested_possessions
      t.integer :contested_marks
      t.integer :marks_inside_50
      t.integer :one_percenters
      t.integer :bounces
      t.integer :goal_assists
      t.integer :percent_played
      t.timestamps null: false
    end
  end
end


