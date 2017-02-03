class AddForeignKeyToAdmissions < ActiveRecord::Migration
  def change
  	add_foreign_key :admissions, :children, on_delete: :cascade
  end
end
