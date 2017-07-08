module ApplicationHelper
	def active_if_current_in_chatrooms
		if params[:controller] == "chatrooms"
			"active"
		end
	end

	def active_if_current_in_contacts
		if params[:controller] == "contacts"
			"active"
		end
	end
end
