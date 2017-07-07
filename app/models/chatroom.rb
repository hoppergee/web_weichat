class Chatroom < ApplicationRecord
	has_many :chatroom_user_relationships
	has_many :users, through: :chatroom_user_relationships
	has_many :messages

	scope :public_channels, ->{ where(private: false) }
	scope :direct_messages, ->{ where(private: true) }

	def self.direct_message_for_users(users)
		user_ids = users.map(&:id).sort
		name = "DM:#{user_ids.join(":")}"

		if chatroom = direct_messages.where(name: name).first
			chatroom
		else
			chatroom = new(name: name, private: true)
			chatroom.users = users
			chatroom.save
			chatroom
		end
	end
end
