class CreateAdmissions < ActiveRecord::Migration
  def change
    create_table :admissions do |t|
	   	t.references :child, :null => false
	   	t.string "admission_type", :null => false, :default => "new_admission"
	    t.datetime "date_of_admission", null: false 
	    t.string "admission_criteria", null: false
      t.timestamps null: false
    end
      add_index("admissions", "child_id")
  end
end
