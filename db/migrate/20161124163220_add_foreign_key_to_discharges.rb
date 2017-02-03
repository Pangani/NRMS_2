class AddForeignKeyToDischarges < ActiveRecord::Migration
  def change
  	add_foreign_key :discharges, :children, :on_delete => :cascade
  end
end
