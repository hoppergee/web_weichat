module ChatroomsHelper
	def render_name_of(chatroom)
		if chatroom.private
			chatroom.users.where.not(id: current_user.id).first.username
		else
			chatroom.name.blank? ? "#{chatroom.users[0..2].map{|u| u.username}.join(',')}..." : chatroom.name
		end
	end
end
