class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
  	ActionCable.server.broadcast "chatroom:#{message.chatroom.id}", {
  		message: MessagesController.render( partial: "messages/new_message", locals: {message: message}),
  		message_sender_id: message.user.id,
  		username: message.user.username,
  		content: message.content,
  		chatroom_id: message.chatroom.id,
      last_message_str: "#{message.content[0..7]}..."
  	}
  end
end
