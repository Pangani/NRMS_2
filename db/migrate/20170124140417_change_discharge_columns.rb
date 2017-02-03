class ChangeDischargeColumns < ActiveRecord::Migration
  def change
  	change_column :discharges, :child_id, :integer, :null => true
  end
end
