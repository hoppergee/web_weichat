
handleVisiblityChange = ->
	$strike = $(".strike")
	if $strike.length > 0
		chatroom_id = $("[data-behavior='messages']").data("chatroom-id")
		App.last_read.update(chatroom_id)
		$strike.remove()

$(document).on 'turbolinks:load', ->
	$(document).on "click", handleVisiblityChange

$(document).on "turbolinks:load", ->
	$("#new_message").on "keypress", (e) ->
		if e && e.keyCode == 13
			e.preventDefault()
			
			chatroom_id = $("[data-behavior='messages']").data("chatroom-id")
			content		= $("#message_content")

			App.chatrooms.send_message(chatroom_id, content.val())

			content.val("")

