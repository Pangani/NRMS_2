class AddForeignKeyToFollowUps < ActiveRecord::Migration
  def change
  	add_foreign_key :follow_ups, :children, on_delete: :cascade
  end
end
