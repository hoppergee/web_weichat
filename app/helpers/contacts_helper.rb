module ContactsHelper
	def render_friendship_status_with(user)
		friendship = current_user.friendship_with(user)
		unless friendship
			return link_to "申请添加好友", request_friendship_contact_path(id: user.id), method: :post, class: "btn btn-info btn-xs"
		end

		case friendship.status
		when "requested"
			link_to "同意成为好友", accept_friendship_contact_path(id: user.id), method: :post, class: "btn btn-success btn-xs"
		when "pending"
			"等待对方同意"
		when "accepted"
			"你们已经是好友"
		else
			raise "friendship的status有问题"
		end

	end

	def render_untreated_friendships_count_of(user)
		count = user.untreated_friendships_count
		if count > 0
			content_tag(:span, "#{count}", class: ["badge", "little_number"])
		else
			content_tag(:span, "", class: ["badge", "little_number"])
		end
	end
end
