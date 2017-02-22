class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
    	t.references :child
    	t.boolean "Appetite_test"
    	t.string "breastfeeding", :limit => 5
    	t.string "complementery_food", :limit => 5
    	t.boolean "vomiting", :limit => 10
	    t.boolean "alert"
	    t.string "stools", :limit => 10, :null => false
	    t.string "yes_appetite", :default => "good"
	    t.text "prev_medical_history", :limit => 60
	    t.string "clinician_name", :limit => 30

      #t.timestamps null: false
    end
	   add_index("tests", "child_id")
     add_foreign_key "tests", "children", on_delete: :cascade
  end	
end
