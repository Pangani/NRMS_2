class CreateFollowups < ActiveRecord::Migration
  def change
    create_table :followups do |t|
    	t.references :child
    	t.date "last_update", :null => false
      	t.decimal "height"
    	t.decimal "weight"
      	t.string "oedema"
    	t.decimal "MUAC"
    	t.integer "z_score"
    	t.decimal "BMI"
    	t.string "clinician"
    	t.text "remark", :limit => 100, :null => true
      	t.string "appetite_test", :default => true
      	t.string "clinical_status"

      t.timestamps null: false
    end
       add_index("followups", "child_id")
       add_foreign_key "followups", "children", on_delete: :cascade
  end
end
