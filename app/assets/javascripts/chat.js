$(function() {
  load_messages();
  
  $('#message-box').bind('send-message',function(e){
     send_message();
  });
  
  $('#message-box').keyup(function(e){
      if(e.keyCode == 13) {
          $(this).trigger('send-message');
      }
  });
  
});

setInterval(function(){load_messages();},1000);

function load_messages() {
  console.log('ma');
  $('#discussion').load( '/chat/load_messages', function() {
    $(this).scrollTop( $(this)[0].scrollHeight );
  });
  
}

function send_message() {
  
  var sent_to = 1; // Temp value, it will be changed when session is ready
  var message = $('#message-box').val();
  
  $.post( '/chat/send_message', {sent_to: sent_to, message: message, authenticity_token: authenticity_token} ,function( response ) {
    if (response) {
      load_messages();
      $('#message-box').val('');
    }
  });
  
}
