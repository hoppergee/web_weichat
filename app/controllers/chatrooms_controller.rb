class ChatroomsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_chatroom, only: [:show, :edit, :update, :destroy]
	layout "with_chatroom_list"

	def index
		@chatrooms = current_user.chatrooms.order(updated_at: :desc)
		@last_chatroom = current_user.chatrooms.last
		redirect_to @last_chatroom
	end

	def show
		@messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
		@chatroom_user_relationship = current_user.chatroom_user_relationships.find_by(chatroom: @chatroom)
	end

	def new
		@chatroom = Chatroom.new
		@cahtroom = @chatroom.chatroom_user_relationships.build
	end

	def edit
		
	end

	def create
		friend_ids = params["friend_ids"]
		unless friend_ids
			render :new
		end

		@chatroom = Chatroom.new(chatroom_params)

		respond_to do |format|
			if @chatroom.save
				@chatroom.chatroom_user_relationships.where(user: current_user).first_or_create
				if friend_ids.size == 1
					@chatroom.chatroom_user_relationships.where(user_id: friend_ids.first).first_or_create
					@chatroom.private = true
				else
					friend_ids.each do |friend_id|
						@chatroom.chatroom_user_relationships.where(user: friend_id).first_or_create
					end
				end

				format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.'}
				format.json { render :show, status: :created, location: @chatroom }
			else
				format.html { render :new }
				format.json { render json: @chatroom.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@chatroom.destroy
		respond_to do |format|
			format.html { redirect_to chatroom_url, notice: "Chatrrom was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private

		def find_chatroom
			@chatroom = Chatroom.find(params[:id])
		end

		def chatroom_params
			params.require(:chatroom).permit(:name)
		end
end
