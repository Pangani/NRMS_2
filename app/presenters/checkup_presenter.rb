class CheckupPresenter
	delegate_to :child_id, :today_weight, :type_of_food, :food_package, :amount_offered, :amount_left, :estimated_amount_vomited, :watery_diarrhoea,
				:prefix => 'feed_plan', :writer => true
	
	delegate_to :child_id, :weight, :MUAC, :z_score, :BMI, :clinician, :remark, :appetite_test, :clinical_status, 
				:prefix => 'follow_up', :writer => true

	def follow_up
		@follow_up ||= Followup.new
	end

	def feed_plan
		@feed_plan ||= Feedplan.new
	end

	def save
		@follow_up.save && @feed_plan.save
	end
end
