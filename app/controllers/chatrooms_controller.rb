class ChatroomsController < ApplicationController
	before_action :find_chatroom, only: [:show, :edit, :update, :destroy]

	def index
		@chatrooms = Chatroom.public_channels
	end

	def show
		@messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
		@chatroom_user_relationship = current_user.chatroom_user_relationships.find_by(chatroom: @chatroom)
	end

	def new
		@chatroom = Chatroom.new
	end

	def edit
		
	end

	def create
		@chatroom = Chatroom.new(chatroom_params)

		respond_to do |format|
			if @chatroom.save
				@chatroom.chatroom_user_relationships.where(user: current_user).first_or_create
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
