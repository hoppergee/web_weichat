class ChatroomUserRelationshipsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_chatroom

	def create
		@chatroom_user_relationship = @chatroom.chatroom_user_relationships.where(user: current_user).first_or_create
		@chatroom_user_relationship.update(last_read_at: Time.zone.now)
		redirect_to @chatroom
	end

	def destroy
		@chatroom_user_relationship = @chatroom.chatroom_users.where(user: current_user).destroy_all
		redirect_to chatrooms_path
	end

	private

		def find_chatroom
			@chatroom = Chatroom.find(params[:chatroom_id])
		end
end
