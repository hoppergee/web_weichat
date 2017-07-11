module ChatroomsHelper
	def render_name_of(chatroom)
		if chatroom.private
			chatroom.users.where.not(id: current_user.id).first.username
		else
			chatroom.name.blank? ? "#{chatroom.users[0..2].map{|u| u.username}.join(',')}..." : chatroom.name
		end
	end

	def render_unread_count_of(chatroom)
		count = current_user.unread_messages_count_in(chatroom)
		if count > 9
			content_tag(:span, "#{count}", class: ["badge","double_number"])
		elsif count > 0
			content_tag(:span, "#{count}", class: ["badge","single_number"])
		else
			content_tag(:span, "", class: ["badge"])
		end
	end

	def render_avatar_of(chatroom)
		if chatroom.private
			other_user_avatar = chatroom.users.where.not(id: current_user.id).first.avatar
			if other_user_avatar.url
				image_tag( other_user_avatar, size:"50x50", class:"media-object img-rounded" )
			else
				image_tag( "DefaultAvatar", size:"50x50", class:"media-object img-rounded" )
			end
		else
			items = ""
			users = chatroom.users
			if users.count > 3
				users[0..8].each do |user|
					items.concat(image_tag( user.avatar_url, class:"group-user-avatar-33"))
				end
			else
				users.each do |user|
					items.concat(image_tag( user.avatar_url, class:"group-user-avatar-50"))
				end
			end
			items.html_safe
		end
	end

	def foo_list items
	  content_tag :ul do
	      items.collect {|item| concat(content_tag(:li, item))}
	  end
	end
end
