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
end
