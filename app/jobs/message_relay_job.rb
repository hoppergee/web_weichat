class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
  	ActionCable.server.broadcast "chatroom:#{message.chatroom.id}", {
  		username: message.user.username,
  		content: message.content,
  		chatroom_id: message.chatroom.id
  	}
  end
end
