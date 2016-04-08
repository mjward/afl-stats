class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
        t.integer   :year
    	t.string    :round
        t.datetime  :started_at
        t.string 	:home_team_name
    	t.integer	:home_team_id
    	t.string	:away_team_name
    	t.integer	:away_team_id
    	t.string	:venue_name
    	t.integer	:venue_id
    	t.string	:home_q1
		t.string	:away_q1
		t.string	:home_q2
		t.string	:away_q2
		t.string	:home_q3
		t.string	:away_q3
    	t.string	:home_q4
		t.string	:away_q4
    	t.integer	:home_score
        t.integer   :away_score
    	t.integer	:attendance
    	t.timestamps null: false
    end
  end
end
