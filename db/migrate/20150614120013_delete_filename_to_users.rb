class DeleteFilenameToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :Filename
  end
end
