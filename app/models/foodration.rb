class Foodration < ActiveRecord::Base
	
	def self.amount_of_rutf(weight)
		@ration = self.find_by_weight_for_child(weight)

		return if @ration.blank?
		@ration
	end
end

#please do not un-comment the following code, it is for reference purposes only

#==================================FOODRATION MIGRATION FILE=======================================
# /////////////////////////////////////////////////////////////////////////////////////////////////

# class CreateFoodrations < ActiveRecord::Migration
#   def change
#     create_table :foodrations do |t|
#     	t.decimal "weight_for_child"
#     	t.integer "sachets_per_week"
#     	t.decimal "sachets_per_day"
#       t.timestamps null: false
#     end
#   end
# end
