class CreateFeedPlans < ActiveRecord::Migration
  def change
    create_table :feed_plans do |t|
    	t.references :child, null: false
    	t.decimal "admission_weight", :null => false
    	t.decimal "today_weight", null: false
    	t.date "date", :null => false
    	t.string "type_of_food", :null => false
    	t.string "food_package", :null => false
    	t.integer "amount_offered", :null => false
    	t.string "amount_left", :null => false
    	t.integer "estimated_amount_vomited"
    	t.integer "watery_diarrhoea"

      #t.timestamps null: false
    
     

      t.timestamps null: false
  	end
       add_index("feed_plans", "child_id")
  end

end
