class AddForeignKeyToTests < ActiveRecord::Migration
  def change
  	add_foreign_key :tests, :children, on_delete: :cascade
  end
end
