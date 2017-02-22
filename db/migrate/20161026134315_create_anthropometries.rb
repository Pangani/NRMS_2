class CreateAnthropometries < ActiveRecord::Migration
  def change
    create_table :anthropometries do |t|
    	t.references :child
    	t.decimal "height", :limit => 10
    	t.decimal"weight", :limit => 10
    	t.integer "z_score", :limit => 3
    	t.decimal "MUAC", null: false
    	t.string "oedema", null: false, :default => "no_oedema"
    	t.decimal "BMI", null: true

      t.timestamps null: false
    end
    add_index("anthropometries", "child_id")
    add_foreign_key "anthropometries", "children", on_delete: :cascade
  end
end
