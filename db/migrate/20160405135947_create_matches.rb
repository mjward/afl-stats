class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
    	t.string 	:home_team_name
    	t.integar	:home_team_id
    	t.string	:away_team_name
    	t.integar	:away_team_id
    	t.string	:venue_name
    	t.integar	:venue_id
    	t.datetime	:time
    	t.string	:round
    	t.string	:home_q1
		t.string	:away_q1
		t.string	:home_q2
		t.string	:away_q2
		t.string	:home_q3
		t.string	:away_q3
    	t.string	:home_q4
		t.string	:away_q4
    	t.integar	:home_score
    	t.integar	:away_score
    	t.timestamps null: false
    end
  end
end
