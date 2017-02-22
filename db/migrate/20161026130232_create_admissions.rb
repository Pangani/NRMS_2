class CreateAdmissions < ActiveRecord::Migration
  def change
    create_table :admissions do |t|
	   	t.references :child
	   	t.string "admission_type", :null => false, :default => "new_admission"
	    t.datetime "date_of_admission" 
	    t.string "admission_criteria"
      t.string "referred_by"
      t.timestamps null: false
    end
      add_index("admissions", "child_id")
      add_foreign_key "admissions", "children", on_delete: :cascade
  end
end
