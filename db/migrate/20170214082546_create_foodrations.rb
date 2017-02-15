class CreateFoodrations < ActiveRecord::Migration
  def change
    create_table :foodrations do |t|
    	t.decimal "weight_for_child", :precision => 3, :scale => 1
    	t.integer "sachets_per_week"
    	t.decimal "sachets_per_day", :precision => 3, :scale => 2
      t.timestamps null: false
    end
  end
end
