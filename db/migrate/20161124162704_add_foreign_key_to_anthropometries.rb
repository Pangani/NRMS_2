class AddForeignKeyToAnthropometries < ActiveRecord::Migration
  def change
  	  	add_foreign_key :anthropometries, :children, on_delete: :cascade
  end
end
