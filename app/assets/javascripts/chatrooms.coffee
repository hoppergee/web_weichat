
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




# $(document).on("turbolinks:load", function(){
# 	$("#search-friends-field").on('keypress', function(evt){
# 		if (evt.keyCode == 13) {
			
# 			var url = $(this).attr("url");

# 			$.ajax({
# 				url: url,
# 				method: "GET",
# 				dataType: "script",
# 				data: {
# 					query_str: $(this).val()
# 				}
# 			})
# 		}
# 	})
# })

