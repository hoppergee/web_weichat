class ContactsController < ApplicationController
	before_action :authenticate_user!
	layout "with_contact_list"

	def index
		if params[:q] && params[:q].values.reject(&:blank?).any?
			@q = User.all.ransack(params[:q])
			@finded_friends = @q.result - [current_user]
		else
			@q = current_user.friends.ransack(:id_eq => -1)
			@finded_friends = @q.result - [current_user]
		end
	end

	def show
		@friend = User.find(params[:id])
		unless current_user.is_friend_of?(@friend)
			redirect_to contacts_path
		end
	end

	def new
		
	end

	def edit
		
	end

	def request_friendship
		friend = User.find(params[:id])
		current_user.request_friendship_with(friend)
		redirect_to :back
	end

	def defriend_request
		friend = User.find(params[:id])
		current_user.defriend_with(friend)
		redirect_to :back
	end

	def accept_friendship
		friend = User.find(params[:id])
		current_user.accept_friendship_with(friend)
		redirect_to :back
	end

	def search_friends
		q = User.ransack(username_or_email_cont: params[:query_str])
		@friends = q.result - [current_user]
	end

end
