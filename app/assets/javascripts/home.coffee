# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', 'a#send-message', (e) ->
	body = $('textarea#reply').val()
	$.ajax
		url: '/api/conversations/1/messages/'
		type: 'POST'
		data: "message": {"body": body}
		async: false
		success: (data) ->
			$('div#message-area').append data
			$('textarea#reply').val('')
		error: (e) ->
			alert 'Error'
	false