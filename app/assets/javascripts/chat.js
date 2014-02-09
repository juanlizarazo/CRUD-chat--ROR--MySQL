$(function() {

  setInterval(function(){ check_new_message(); }, 1000 );
  
  $('#message-box').bind('send-message',function(e){
     send_message();
  });
  
  $('#message-box').keyup(function(e){
      if(e.keyCode == 13) {
          $(this).trigger('send-message');
      }
  });
  
  $('#discussion').bind('scroll', function(){
    if( $(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
      $('#new-message').fadeOut();
    }
  });  
});

var scroll_chat = false;

function check_new_message() {
  
  $.post( '/chat/new_message', {authenticity_token: authenticity_token}, function(response) {
    
    if ( parseInt( response ) ) {
      $.get( '/chat/load_messages', function( messages ) {
        
        $('#discussion').append( messages );

        if (scroll_chat) {
          $('#discussion').scrollTop( $('#discussion')[0].scrollHeight );
          scroll_chat = false;
        } else if ( $('#discussion').html().length > 1200 ){
          $('#new-message').fadeIn();
        }
        
      });
    }
    
  });
  
}

function clear_chat() {
  $.post( '/chat/clear_messages', {authenticity_token: authenticity_token}, function() {
    $('#discussion').html(''); 
  });
}

function send_message() {
  var message = $('#message-box').val();
  
  $.post( '/chat/send_message', {message: message, authenticity_token: authenticity_token} ,function( response ) {
    if (response) {
      $('#message-box').val('');
      scroll_chat = true;
    }
  });
}
