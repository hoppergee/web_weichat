class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, :class_name => 'User'

	def self.accept_one_side(user, friend)
		request = find_by_user_id_and_friend_id(user, friend)
		request.status = 'accepted'
		request.save
	end
end
