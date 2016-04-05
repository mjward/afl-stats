class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :nickname, null: false
      t.timestamps null: false
    end
  end
end
