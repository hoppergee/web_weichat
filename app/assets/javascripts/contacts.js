$(document).on("turbolinks:load", function(){
	$("#search-friends-field").on('keypress', function(evt){
		if (evt.keyCode == 13) {
			
			var url = $(this).attr("url");

			$.ajax({
				url: url,
				method: "GET",
				dataType: "script",
				data: {
					query_str: $(this).val()
				}
			})
		}
	})
})