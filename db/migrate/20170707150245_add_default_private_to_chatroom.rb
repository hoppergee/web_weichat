class AddDefaultPrivateToChatroom < ActiveRecord::Migration[5.0]
  def change
  	change_column :chatrooms, :private, :boolean, :default => false
  end
end
