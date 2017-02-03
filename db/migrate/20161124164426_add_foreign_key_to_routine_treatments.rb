class AddForeignKeyToRoutineTreatments < ActiveRecord::Migration
  def change
  	add_foreign_key :routine_treatments, :children, on_delete: :cascade
  end
end
