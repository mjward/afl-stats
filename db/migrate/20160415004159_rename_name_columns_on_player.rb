class RenameNameColumnsOnPlayer < ActiveRecord::Migration
  def change
    rename_column :players, :firstname, :first_name
    rename_column :players, :lastname, :last_name
  end
end
