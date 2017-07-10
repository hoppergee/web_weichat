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
  		$("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")

  send_message: (chatroom_id, message) ->
  	@perform "send_message", {chatroom_id: chatroom_id, content: message}


