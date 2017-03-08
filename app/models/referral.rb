class Referral < ActiveRecord::Base
	belongs_to :children
#-----------------------------------------------------------------------------------------------
validates :reason, :confirmed_by, :referred_to, :presence => true

end

#-----------------------	END 	------------------------------------------------------------
#please do not un-comment the following code, it is for reference purposes only

#=======================================MIGRATIION FILE========================================
#//////////////////////////////////////////////////////////////////////////////////////////////

# class CreateReferrals < ActiveRecord::Migration
#   def change
#     create_table :referrals do |t|
#     	t.references :child
#     	t.date "date_referred",null: false
# 	    t.string "reason", null:false
# 	    t.string "confirmed_by",:null => false

# 	    t.timestamps null: false
#     end
#      	add_index("referrals", "child_id")
#       add_foreign_key "referrals", "children", on_delete: :cascade
#   end
# end
