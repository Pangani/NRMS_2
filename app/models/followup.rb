class Followup < ActiveRecord::Base
	belongs_to :child
	before_validation :set_last_update
	# after_save :touch_child
	
#////////////////////////////////////////////////////////////////////////////////////
	validates :weight, presence: true
	validates :height, presence: true
	validates :MUAC, presence: true
	validates :z_score, presence: true
	validates :clinician, presence: true
	validates :clinical_status, :presence => true

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
