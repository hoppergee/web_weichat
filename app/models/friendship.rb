class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, :class_name => 'User'

	def self.accept_one_side(user, friend)
		request = find_by_user_id_and_friend_id(user, friend)
		request.status = 'accepted'
		request.save
	end

	def is_accepted?
		status == "accepted"
	end

	def is_requested?
		status == "requested"
	end

	def is_pending?
		status == "pending"
	end
end
