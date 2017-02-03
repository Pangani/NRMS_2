class FeedPlan < ActiveRecord::Base
	belongs_to :child
	before_validation :setDate

#///////////////////////////////////////////////////////////////////////////////////
	as_enum :food_package, [:sachet, :bottle ], map: :string, source: :food_package	

#///////////////////////////////////////////////////////////////////////////////////

	# def addAdmissionWeight(id)
	# 	@child = Child.find_by_id(id)
	# 	self.admission_weight = 
	# end

	def setDate
		self.date = Time.now.to_date
	end
end
