App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
  	if active_chatroom.length > 0
  		if document.hidden
  			if $(".strike").length == 0
  				active_chatroom.append("<div class='strike'><span>Unread Message</span></div>")

  			if Notification.permission == "granted"
  				new Notification(data.username, {body: data.body})
  		else
  			App.last_read.update(data.chatroom_id)

  		if parseInt(current_user_id) != data.message_sender_id
  			message_html = data.message.replace(/<div class="media-right">[\s\S]*?<\/div>/g, '')
  			console.log("别人发的")
  		else
  			message_html_0 = data.message.replace(/<div class="media-left">[\s\S]*?<\/div>/g, '')
  			message_html = message_html_0.replace(/class="media-body"/g, 'class="media-body" style="text-align: right;"')
  			console.log("我自己发的")
  		active_chatroom.append(message_html)
  		$("#chatroom-chats").scrollTop($("#chatroom-chats")[0].scrollHeight);

  	else
  		current_room_link = $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']")
  		current_room_link.css("font-weight", "bold")
  		badge = $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}'] .media .media-left .badge")
  		unread_count = parseInt(badge.text())
  		if unread_count
  			unread_count += 1
  		else
  			unread_count = 1
  		badge.html(unread_count)
  		if unread_count > 9
  			badge.removeClass("single_number")
  			badge.addClass("double_number")
  		else if unread_count > 0
  			badge.addClass("single_number")

			current_room_link.parent().prependTo(current_room_link.parent().parent())
			subtitle = $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}'] .media .media-subtitle")
			subtitle.html(data.last_message_str)

			# sidebar_badge = $("#chatrooms-side-btn .badge")
			# all_unread_count = parseInt(sidebar_badge.text())
			# if all_unread_count
			# 	all_unread_count += 1
			# else
			# 	all_unread_count = 1
			# sidebar_badge.html(all_unread_count)


  send_message: (chatroom_id, message) ->
  	@perform "send_message", {chatroom_id: chatroom_id, content: message}


