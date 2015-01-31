$(document).ready(function(){
  var pairing_duration_ms;

  $('button.duration-button').on('click', function(event){
    event.preventDefault();

    if($('input.duration').val() !== "" ){
      pairing_duration_ms = parseInt( $('input.duration').val() ) * 6000;
    } else {
      alert("Please Enter A Number");
    }
  });

  $('button.start-pairing').on('click', function(){
    setTimeout(function(){
      alert('Time to Switch It ^');
    }, pairing_duration_ms);
  });
});