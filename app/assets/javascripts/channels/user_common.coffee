App.user_common = App.cable.subscriptions.create "UserCommonChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	if data.all_unread_count
  		sidebar_chatroom_badge = $("#chatrooms-side-btn .badge")
  		sidebar_chatroom_badge.html(data.all_unread_count)

  		chatroom_list = $(".chatroom-list ul")
  		current_room_link = $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']")
  		console.log(current_room_link)
  		if chatroom_list.length != 0
  			if current_room_link.length == 0
  				console.log("没找到current_room_link")
  				$('.chatroom-list ul').load(document.URL +  ' .chatroom-list ul');
  		else
  			console.log("没找到chatroomlit")


  	if data.untreated_friendships_count
  		sidebar_contact_badge = $("#contacts-side-btn .badge")
  		sidebar_contact_badge.html(data.untreated_friendships_count)
  		$("#friends-request-list").load(document.URL + ' #friends-request-list')
  		$("#friends-request-list").toggle();

  	if data.accepted
  		$("#friend-list-container ul").load(document.URL + ' #friend-list-container ul')


