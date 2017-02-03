class FollowUp < ActiveRecord::Base
	belongs_to :child
	before_validation :set_last_update
	after_save :touch_child

#////////////////////////////////////////////////////////////////////////////////////
	scope :latest_update_first, lambda{ order("follow_ups.updated_at ASC")}
	
#///////////////////////////////////////////////////////////////////////////////////
	as_enum :appetite_test, [:Yes, :No], map: :string, source: :appetite_test 
	as_enum :clinical_status, [:clinically_well, :not_well], map: :string, source: :clinical_status

#///////////////////////////////////////////////////////////////////////////////////
private
	def set_last_update
		self.last_update = Time.now.to_date
	end

	def touch_child
		child.touch
	end

	
end
