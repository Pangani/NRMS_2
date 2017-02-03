class ChangeAnthropometryColumns < ActiveRecord::Migration
  def change
  	change_column :anthropometries, :child_id, :integer, :null => true
  end
end
