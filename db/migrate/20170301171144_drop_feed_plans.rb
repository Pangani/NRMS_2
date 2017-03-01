class DropFeedPlans < ActiveRecord::Migration
   def up
    drop_table :feed_plans
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
