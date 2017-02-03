class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
    	t.references :child, :null => false
    	t.string "referred_by", :limit => 10, null: false
    	t.boolean "Appetite_test", :null => false
    	t.string "breastfeeding", :limit => 5, null: false
    	t.string "complementery_food", :limit => 5, :null => false
    	t.boolean "vomiting", :limit => 10, :null => false
	    t.boolean "alert", null: false
	    t.string "stools", :limit => 10, :null => false
	    t.string "yes_appetite", :null => 20, :default => "good"
	    t.text "prev_medical_history", :limit => 60
	    t.string "clinician_name", :limit => 30, :null => false

      #t.timestamps null: false
    end
	   add_index("tests", "child_id")
  end	
end
