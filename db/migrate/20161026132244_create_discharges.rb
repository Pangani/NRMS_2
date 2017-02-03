class CreateDischarges < ActiveRecord::Migration
  def change
    create_table :discharges do |t|
    	t.references :child, :null => false
    	t.datetime "date_of_discharge", null: false
    	t.string "programme", :limit => 25, :null => false
    	t.text "proposed_treatment"
    	t.text "proposed_diet"
    	t.string "outcome", :limit => 60, :null => false, :default => "cured"
    	t.integer "length_of_stay", null: false 

      #t.timestamps null: false
    end
	    add_index("discharges", "child_id")

  end
end
