class AddLastReadAtToChatroomUserRelationships < ActiveRecord::Migration[5.0]
  def change
    add_column :chatroom_user_relationships, :last_read_at, :datetime
  end
end
