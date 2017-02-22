class Feedplan < ActiveRecord::Base
	belongs_to :child
	before_validation :setDate

#///////////////////////////////////////////////////////////////////////////////////
	as_enum :food_package, [:sachet, :bottle ], map: :string, source: :food_package	

#///////////////////////////////////////////////////////////////////////////////////

	def setDate
		self.date = Time.now.to_date
	end

	def total_amount
		
	end
end

#please do not un-comment the following code, it is for reference purposes only

#====================================MIGRATION FILE===================================
#/////////////////////////////////////////////////////////////////////////////////////

	# class CreateFeedPlans < ActiveRecord::Migration
	#   def change
	#     create_table :feed_plans do |t|
	#     	t.references :child, null: false
	#     	t.decimal "admission_weight", :null => false
	#     	t.decimal "today_weight", null: false
	#     	t.date "date", :null => false
	#     	t.string "type_of_food", :null => false
	#     	t.string "food_package", :null => false
	#     	t.integer "amount_offered", :null => false
	#     	t.string "amount_left", :null => false
	#     	t.integer "estimated_amount_vomited"
	#     	t.integer "watery_diarrhoea"	    
	     
	#       t.timestamps null: false
	
	#   	end
	#        add_index("feed_plans", "child_id")
	#   end
	# end


