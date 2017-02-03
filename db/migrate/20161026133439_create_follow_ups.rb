class CreateFollowUps < ActiveRecord::Migration
  def change
    create_table :follow_ups do |t|
    	t.references :child, :null => false
    	t.date "last_update", :null => false
    	t.decimal "weight", null: false
    	t.decimal "MUAC", null: false
    	t.integer "z_score", :null => false
    	t.decimal "BMI"
    	t.string "clinician", :null => false
    	t.text "remark", :limit => 100, :null => true
        t.string "appetite_test", null: false, :default => true
        t.string "clinical_status", :null => false

      t.timestamps null: false
    end
       add_index("follow_ups", "child_id")
  end
end
