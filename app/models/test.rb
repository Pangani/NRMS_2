class Test < ActiveRecord::Base
	belongs_to :child
	#after_save :setID

#////////////////////////////////////////////////////////////////////////////////////////////
	as_enum :stools, [:three, :four, :five], map: :string, source: :stools
	as_enum :yes_appetite, [:very_good, :good, :poor, :very_poor], map: :string, source: :yes_appetite
	as_enum :referred_by, [:Own, :NRU, :otherOTP], :map => :string, source: :referred_by
	as_enum :complementery_food, [:Yes, :None], :map => :string, source: :complementery_food
	as_enum :breastfeeding, [:Yes, :No], :map => :string, source: :breastfeeding
	as_enum :vomiting, [:Yes, :No], :map => :string, source: :vomiting

#///////////////////////////////////////////////////////////////////////////////////////////
	scope :appetite_pass, lambda {where(:Appetite_test => true)}
	scope :appetite_fail, lambda {where(:Appetite_test => false)}

#//////////////////////////////////////////////////////////////////////////////////////////

	def setID
		@child = Child.last
		@test = Test.find_by_child_id(@child.id)

		for t in @test
			@child.tests << t
		end
	end
end

