
handleVisiblityChange = ->
	$strike = $(".strike")
	if $strike.length > 0
		chatroom_id = $("[data-behavior='messages']").data("chatroom-id")
		App.last_read.update(chatroom_id)
		$strike.remove()
		badge = $("[data-behavior='chatroom-link'][data-chatroom-id='#{chatroom_id}'] .media .media-left .badge")
		badge.html("")
		badge.removeClass("single_number")
		badge.removeClass("double_number")
		$("#chatrooms-side-btn").load(document.URL + ' #chatrooms-side-btn')

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


$(document).on "turbolinks:load", ->
	$("#search-chatrooms-field").on 'keypress', (e) ->
		if e && e.keyCode == 13
			url = $(this).attr "url"
			console.log(url)
			$.ajax 
				url: url
				type: "GET"
				dataType: "script"
				data:
					query_str: $(this).val()



