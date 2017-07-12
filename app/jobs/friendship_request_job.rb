class FriendshipRequestJob < ApplicationJob
  queue_as :default

  def perform(friend, accepted=false)
  	if accepted
  		ActionCable.server.broadcast "user_#{friend.id}_channel", {
  			accepted: true
  		}
  	else
	  	ActionCable.server.broadcast "user_#{friend.id}_channel", {
	  		untreated_friendships_count: friend.untreated_friendships_count
	  	}
  	end
  end
end
