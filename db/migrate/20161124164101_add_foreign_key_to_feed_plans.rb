class AddForeignKeyToFeedPlans < ActiveRecord::Migration
  def change
  	add_foreign_key :feed_plans, :children, on_delete: :cascade
  end
end
