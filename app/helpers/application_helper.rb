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

	def render_user_avatar_of(user , size, class_name)
		avatar_url = user.avatar.url
		if avatar_url
			image_tag avatar_url, size: "#{size}", class:"#{class_name}"
		else
			image_tag "DefaultAvatar", size: "#{size}", class:"#{class_name}"
		end
	end
end
