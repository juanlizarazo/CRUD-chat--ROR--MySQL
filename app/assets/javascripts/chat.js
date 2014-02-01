$(function() {
  
  setInterval(function(){ load_messages(); }, 1000 );
  
  $('#message-box').bind('send-message',function(e){
     send_message();
  });
  
  $('#message-box').keyup(function(e){
      if(e.keyCode == 13) {
          $(this).trigger('send-message');
      }
  });
  
});

function load_messages() {
  $('#discussion').load( '/chat/load_messages', function() {
    $(this).scrollTop( $(this)[0].scrollHeight );
  });
}

function send_message() {
  var message = $('#message-box').val();
  
  $.post( '/chat/send_message', {message: message, authenticity_token: authenticity_token} ,function( response ) {
    if (response) {
      load_messages();
      $('#message-box').val('');
    }
  });
}
