class CreateAnthropometries < ActiveRecord::Migration
  def change
    create_table :anthropometries do |t|
    	t.references :child, null: false
    	t.decimal "height", :limit => 10, null: false
    	t.decimal"weight", :limit => 10, null: false
    	t.integer "z_score", :limit => 3, null: false
    	t.decimal "MUAC", null: false
    	t.string "oedema", null: false, :default => "no_oedema"
    	t.decimal "BMI", null: true

      t.timestamps null: false
    end
    add_index("anthropometries", "child_id")
  end
end
