class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
    	t.string "name", null: false
    	t.string "district", null: false
    	t.string "location", null: false
    	t.integer "facility_code", null: false
      t.boolean "has_nru"
      t.boolean "has_sfp"

      t.timestamps null: false
    end
    add_index("facilities", "facility_code")
  end
end
