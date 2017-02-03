class CreateRoutineTreatments < ActiveRecord::Migration
  def change
    create_table :routine_treatments do |t|
    	t.references :child, null: false
    	t.date "date", :null => false
    	t.string "vitamin_A", :null => false
    	t.string "folic_acid", :limit => 20
    	t.string "amoxicilin_antibiotic", :limit => 20
    	t.string "albendazole", :limit => 40
      t.timestamps null: false
    end
    add_index("routine_treatments", "child_id")
  end
end
