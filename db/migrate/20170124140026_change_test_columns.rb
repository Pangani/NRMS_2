class ChangeTestColumns < ActiveRecord::Migration
  def change
  	change_column :tests, :child_id, :integer, :null => true
  end
end
