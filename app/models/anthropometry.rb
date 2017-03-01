class Anthropometry < ActiveRecord::Base
#Associations
	belongs_to :child
	#after_save :setID

#///////////////////////////////////////////////////////////////////////////////////////////////////
	#conditions
	scope :no_oedema, lambda { where(:oedema => "no_oedema")}
	scope :oedema_plus, lambda { where(:oedema => "level_one")}
	scope :oedema_2plus, lambda { where(:oedema => "level_two")}
	scope :oedema_3plus, lambda { where(:oedema => "level_three")}

#//////////////////////////////////////////////////////////////////////////////////	////////////////
	as_enum :oedema, [:no_oedema, :level_one, :level_two, :level_three], map: :string, source: :oedema

#///////////////////////////////////////////////////////////////////////////////////////////////////
	def self.BMI
		@weight = self.weight.to_f
		@height = self.height.to_f

		@bmi = @weight / (@height * @height)
		return if @bmi.blank?
	end
end

#please do not un-comment the following code, it is for reference purposes only

#==================================MIGRATION FILE==================================================
#//////////////////////////////////////////////////////////////////////////////////////////////////

# class CreateAnthropometries < ActiveRecord::Migration
#   def change
#     create_table :anthropometries do |t|
#     	t.references :child, null: false
#     	t.decimal "height", :limit => 10, null: false
#     	t.decimal"weight", :limit => 10, null: false
#     	t.integer "z_score", :limit => 3, null: false
#     	t.decimal "MUAC", null: false
#     	t.string "oedema", null: false, :default => "no_oedema"
#     	t.decimal "BMI", null: true

#       t.timestamps null: false
#     end
#     add_index("anthropometries", "child_id")
#   end
# end
