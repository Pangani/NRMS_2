class Followup < ActiveRecord::Base
	belongs_to :child
	before_validation :set_last_update
	# after_save :touch_child
	
#////////////////////////////////////////////////////////////////////////////////////
	validates :weight, :height, :MUAC, :z_score, :clinician, :presence => true
	validates_length_of :height, :maximum => 200
	validates_numericality_of :weight, :height, :MUAC

#////////////////////////////////////////////////////////////////////////////////////
	scope :latest_update_first, lambda{ order("follow_ups.updated_at ASC")}
	
#///////////////////////////////////////////////////////////////////////////////////
	as_enum :appetite_test, [:Yes, :No], map: :string, source: :appetite_test 
	as_enum :clinical_status, [:clinically_well, :not_well], map: :string, source: :clinical_status

#///////////////////////////////////////////////////////////////////////////////////

	def weight_gain(child)
		@last_weight = child.follow_ups.find_by_updated_at(Date.today - 7.days) rescue child.anthropometry.weight 

		@f_weight = (self.weight.to_f - @last_weight.to_f) / @last_weight.to_f
		@gain = @f_weight * 100 #In percentage

		return if @gain.blank?
		@gain
	end

#------------------------------------------------------------------------------------
	# ALARM TRIGGER 
	# If a child looses weight or remains static for 2 consecutive weeks,
	# 	-review for any medical complications and refer to medical services if need to
	# 	-refer directly to NRU having also considered other NRU referral criteria
#------------------------------------------------------------------------------------
private
	def set_last_update
		self.last_update = Time.now.to_date
	end
end

#please do not un-comment the following code, it is for reference purposes only

# ================================MIGRATION FILE====================================
# //////////////////////////////////////////////////////////////////////////////////

	# class CreateFollowUps < ActiveRecord::Migration
	#   def change
	#     create_table :follow_ups do |t|
	#     	t.references :child, :null => false
	#     	t.date "last_update", :null => false
	#     	t.decimal "weight", null: false
	#     	t.decimal "MUAC", null: false
	#     	t.integer "z_score", :null => false
	#     	t.decimal "BMI"
	#     	t.string "clinician", :null => false
	#     	t.text "remark", :limit => 100, :null => true
	#         t.string "appetite_test", null: false, :default => true
	#         t.string "clinical_status", :null => false

	#       t.timestamps null: false
	#     end
	#        add_index("follow_ups", "child_id")
	#   end
	# end
