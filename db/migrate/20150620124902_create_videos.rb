class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.binary :video_data

      t.timestamps null: false
    end
  end
end
