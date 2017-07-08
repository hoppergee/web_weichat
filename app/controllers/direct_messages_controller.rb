class DirectMessagesController < ApplicationController
	before_action :authenticate_user!
	layout "with_chatroom_list"

	def show
		users = [current_user, User.find(params[:id])]
		@chatroom = Chatroom.direct_message_for_users(users)
		@messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
		@chatroom_user_relationship = current_user.chatroom_user_relationships.find_by(chatroom_id: @chatroom.id)
		render "chatrooms/show"
	end
end