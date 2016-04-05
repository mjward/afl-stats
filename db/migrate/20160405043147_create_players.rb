class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :firstname
      t.string :lastname
      t.datetime :dob
      t.timestamps null: false
    end
  end
end
