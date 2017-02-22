class CreateFeedplans < ActiveRecord::Migration
  def change
    create_table :feedplans do |t|
    	t.references :child
    	t.decimal "admission_weight"
    	t.decimal "today_weight"
    	t.date "date"
    	t.string "type_of_food"
    	t.string "food_package"
    	t.integer "amount_offered"
    	t.string "amount_left"
    	t.integer "estimated_amount_vomited"
    	t.integer "watery_diarrhoea"

      t.timestamps null: false
  	end
       add_index("feedplans", "child_id")
       add_foreign_key "feedplans", "children", on_delete: :cascade
  end
end
