class AddVideoIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :video_id, :int
  end
end
