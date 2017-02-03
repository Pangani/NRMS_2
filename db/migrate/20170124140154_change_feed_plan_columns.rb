class ChangeFeedPlanColumns < ActiveRecord::Migration
  def change
  	change_column :feed_plans, :child_id, :integer, :null => true
  end
end
