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
			$('div#message-area').append('<div class="media msg "><div class="media-body"><small class="pull-right time"><i class="fa fa-clock-o"></i>'+data.message.time+'</small><h5 class="media-heading">'+data.message.user+'</h5><small class="col-lg-10">'+data.message.body+'</small>');
			$('textarea#reply').val('')
		error: (e) ->
			alert 'Error'
	false

$(document).on 'page:change', (e) ->
  setInterval (->
    $pull_chat()
    return
  ), 1000