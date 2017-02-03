class AddHeightToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :height, :integer
  end
end
