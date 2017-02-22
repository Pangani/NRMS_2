class CreateDischarges < ActiveRecord::Migration
  def change
    create_table :discharges do |t|
    	t.references :child
    	t.datetime "date_of_discharge"
    	t.string "programme", :limit => 25, :null => false
    	t.text "proposed_treatment"
    	t.text "proposed_diet"
    	t.string "outcome", :limit => 60, :null => false, :default => "cured"
    	t.integer "length_of_stay"

      #t.timestamps null: false
    end
	    add_index("discharges", "child_id")
      add_foreign_key "discharges", "children", on_delete: :cascade
  end
end
