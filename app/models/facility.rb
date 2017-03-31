class Facility < ActiveRecord::Base
	validates :name, :district, :location, :facility_code, :presence => true
	validates_numericality_of :facility_code, :within => 1...100

#==================================================================================================
	# def name
	# 	if Facility.blank?
	# 		@facility = Facility.first
	# 		return @facility.name if @facility.blank?
	# 	end
	# end

	# def district_code
	# 	@fac = Facility.first
	# 	districts = {}
	# 	districts = {
	# 		"Balaka" => 1,"Blantyre" => 2,"Chikwawa" => 3,"Chiradzulu" => 4,"Chitipa" => 5,"Dedza" => 6,
	#         "Dowa" => 7, "Karonga" => 8,"Likoma" => 9,"Lilongwe" => 10,"Machinga" => 11,"Mangochi" => 12,
	#         "Mchinji" => 13,"Mulanje" => 14, "Mwanza" => 15, "Mzimba" => 16,"Neno" => 17,"Nkhata Bay" => 18,
	#         "Nkhotakota" => 19,"Nsanje" => 20,"Ntcheu" => 21,"Ntchisi" => 22,"Phalombe" => 23,"Rumphi" => 24,
	#         "Salima" => 25,"Thyolo" => 26,"Zomba" => 27
 #    	}
 #    	return district[@fac.district] if @fac.blank?
	# end

	# def facility_code
	# 	@facility = Facility.first
	# 	return @facility.facility_code if @facility.blank?
	# end

end

#please DO NOT UN-COMMENT the following code, it is for reference purposes only

#==================================MIGRATION FILE==================================================
# /////////////////////////////////////////////////////////////////////////////////////////////////

# class CreateFacilities < ActiveRecord::Migration
#   def change
#     create_table :facilities do |t|
#     	t.string "name", null: false
#     	t.string "district", null: false
#     	t.string "location", null: false
#     	t.integer "facility_code", null: false
#       t.boolean "has_nru"
#       t.boolean "has_sfp"

#       t.timestamps null: false
#     end
#     add_index("facilities", "facility_code")
#   end
# end
