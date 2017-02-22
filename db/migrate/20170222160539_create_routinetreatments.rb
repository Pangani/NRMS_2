class CreateRoutinetreatments < ActiveRecord::Migration
  def change
    create_table :routinetreatments do |t|
	      t.references :child
	      t.date "date", :null => false
	      t.string "vitamin_A"
	      t.string "folic_acid", :limit => 20
	      t.string "amoxicilin_antibiotic", :limit => 20
	      t.string "fansidar"
	      t.string "albendazole", :limit => 40
	      t.timestamps null: false
	end
	    add_index("routinetreatments", "child_id")
	    add_foreign_key "routinetreatments", "children", on_delete: :cascade
  end
end
