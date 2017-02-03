class ChangeRoutineTreatmentColumns < ActiveRecord::Migration
  def change
  	change_column :routine_treatments, :child_id, :integer, :null => true
  end
end
