class AddOedemaToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :oedema, :string
  end
end
