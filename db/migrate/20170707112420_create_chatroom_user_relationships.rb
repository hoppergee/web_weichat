class CreateChatroomUserRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :chatroom_user_relationships do |t|
      t.references :chatroom, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
