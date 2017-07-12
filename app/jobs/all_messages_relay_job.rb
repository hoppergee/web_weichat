class AllMessagesRelayJob < ApplicationJob
  queue_as :default

  def perform(user, chatroom)
  	chatroom.users.reject{|u| u.id == user.id}.each do |other_user|
	  	ActionCable.server.broadcast "user_#{other_user.id}_channel", {
	  		all_unread_count: other_user.all_unread_messages_count,
	  		chatroom_id: chatroom.id
	  	}
  	end
  end
end
