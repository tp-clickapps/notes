# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', 'a#send-message', (e) ->
	$create_message()
	false

$(document).on 'page:change', (e) ->
  setInterval (->
    $pull_chat()
    return
  ), 20000