class AddUrlToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :afltables_url, :string
  end
end
