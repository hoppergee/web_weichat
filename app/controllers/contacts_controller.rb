class ContactsController < ApplicationController
	before_action :authenticate_user!
	layout "with_contact_list"

	def index

	end

	def show
		@friend = User.find(params[:id])
	end

	def new
		
	end

	def edit
		
	end
end
