class Anthropometry < ActiveRecord::Base
#Associations
	belongs_to :child
	after_save :setID

#//////////////////////////////////////////////////////////////////////////////////
	#conditions
	scope :no_oedema, lambda { where(:oedema => "no_oedema")}
	scope :oedema_plus, lambda { where(:oedema => "level_one")}
	scope :oedema_2plus, lambda { where(:oedema => "level_two")}
	scope :oedema_3plus, lambda { where(:oedema => "level_three")}

#//////////////////////////////////////////////////////////////////////////////////	
	as_enum :oedema, [:no_oedema, :level_one, :level_two, :level_three], map: :string, source: :oedema

#//////////////////////////////////////////////////////////////////////////////////
	def setID
		@child = Child.last
		@child.anthropometry = Anthropometry.find_by_id(@child.id)
	end

end

