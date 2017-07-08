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

	def image_when_current_in_chatrooms
		if params[:controller] == "chatrooms"
			image_tag "Tabbar-Chat-Selected", size: "22x20"
		else
			image_tag "Tabbar-Chat", size: "22x20"
		end
	end

	def image_when_current_in_contacts
		if params[:controller] == "contacts"
			image_tag "Tabbar-Contacts-Selected", size: "22x20"
		else
			image_tag "Tabbar-Contacts", size: "22x20"
		end
	end
end
