class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.binary :icon
      t.string :icon_content_type

      t.timestamps null: false
    end
  end
end
