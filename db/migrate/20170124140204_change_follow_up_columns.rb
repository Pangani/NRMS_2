class ChangeFollowUpColumns < ActiveRecord::Migration
  def change
  	change_column :follow_ups, :child_id, :integer, :null => true
  end
end
