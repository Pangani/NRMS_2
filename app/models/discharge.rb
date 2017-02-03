class Discharge < ActiveRecord::Base
	belongs_to :child
	#around_save :set_child_id
	#Associations
#////////////////////////////////////////////////////////////////////////////////////////////////////////
	as_enum :outcome, [:cured, :died, :defaulted, :nonresponse, :transferred], map: :string, source: :outcome

#////////////////////////////////////////////////////////////////////////////////////////////////////////
	#to separate children by their outcome during discharge
	scope :while_cured, lambda {where(:outcome => "cured")}
	scope :while_dead, lambda {where(:outcome => "died")}
	scope :while_defaulted, lambda {where(:outcome => "defaulted")}
	scope :while_nonresponse, lambda {where(:outcome => "nonresponse")}
	scope :while_transferred, lambda {where(:outcome => "transferred")}


end
