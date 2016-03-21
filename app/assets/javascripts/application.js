// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .


$last_fetch = null;

$pull_chat = function(){
	$.ajax({
		url: '/api/conversations/1/messages?last_fetch=' + $last_fetch,
		success: function(data){
			for(i=0; i<data.messages.length; i++){
			  str = '<div class="media msg "><div class="media-body"><small class="pull-right time"><i class="fa fa-clock-o">&nbsp;</i>'+data.messages[i].time+'</small><h5 class="media-heading">'+data.messages[i].user+'</h5><small class="col-lg-10">'+data.messages[i].body+'</small>';
			  $('div#message-area').append(str);
			}
			if(data.messages.length > 0) {
			  $last_fetch = data.messages[data.messages.length-1].id;
			  var message=$('div#message-area');
	          message.scrollTop(message[0].scrollHeight);
	        }
		}
	});
}


$create_message = function(){
	var body = $('textarea#reply').val();
	$.ajax({
		url: '/api/conversations/1/messages/',
		type: 'POST',
		data: 'message[body]='+ body,
		async: false,
		success: function(data) {
			$('div#message-area').append('<div class="media msg "><div class="media-body"><small class="pull-right time"><i class="fa fa-clock-o">&nbsp;</i>'+data.message.time+'</small><h5 class="media-heading">'+data.message.user+'</h5><small class="col-lg-10">'+data.message.body+'</small>');
			$last_fetch = data.message.id;
			$('textarea#reply').val('');
		},
		error: function(e) {
			alert('Error');
		}
	});
	var message=$('div#message-area');
	message.scrollTop(message[0].scrollHeight);
}