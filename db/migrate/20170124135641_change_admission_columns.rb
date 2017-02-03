class ChangeAdmissionColumns < ActiveRecord::Migration
  def change
  	change_column :admissions, :child_id, :integer, :null => true
  end
end
