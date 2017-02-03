class CreateUserObservers < ActiveRecord::Migration
  def change
    create_table :user_observers do |t|

      t.timestamps null: false
    end
  end
end
