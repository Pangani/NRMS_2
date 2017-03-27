class AlterColumnTestsAppetiteTest < ActiveRecord::Migration
  	def self.up
	    change_table :tests do |t|
	      t.change :Appetite_test, :string
	    end
  	end
  
  	def self.down
	    change_table :products do |t|
	      t.change :Appetite_test, :boolean
	    end
	end
end
