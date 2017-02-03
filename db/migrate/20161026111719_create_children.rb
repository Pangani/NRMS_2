class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
    	t.string "reg_number", :null => false, :unique => true
		t.string "first_name", :limit => 25, :null => false
	    t.string "last_name", :limit => 25, :null => false
	    t.string "guardian_name", :limit => 60, :null => false
	    t.string "twin_child", :null => false, :default => "no"
	    t.date "dob", :null => false
	    t.string "sex", :null => false
	    t.string "district", :null => false
	    t.string "trad_authority", :null => false
	    t.string "village", :limit => 50, :null => false
	    t.string "HIV_serostatus", null: false, :default => false
	    t.string "maternal_HIV_serostatus", :null => false, :default => "NR"
	    t.boolean "on_ART", null: false, :default => false    	

      t.timestamps null: false
    end
  end
end
