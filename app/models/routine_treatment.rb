class RoutineTreatment < ActiveRecord::Base
	belongs_to :child
	before_validation :set_date

	as_enum :vitamin_A, [:Yes, :No ], map: :string, source: :vitamin_A
	as_enum :folic_acid, [:Yes, :No ], map: :string, source: :folic_acid
	as_enum :albendazole, [:Yes, :No ], map: :string, source: :albendazole
	as_enum :amoxicilic_antibiotic, [:Yes, :No ], map: :string, source: :amoxicilic_antibiotic



	def set_date
		self.date = Time.now.to_date
	end
end
