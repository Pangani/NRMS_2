class DropRoutineTreatments < ActiveRecord::Migration
   def up
    drop_table :routine_treatments
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
