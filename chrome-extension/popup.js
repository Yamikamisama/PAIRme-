$(document).ready(function(){
  var backgroundPage = chrome.extension.getBackgroundPage();

  $('button.duration-button').on('click', function(event){
    event.preventDefault();
    if($('input.duration').val() !== "" ){
      backgroundPage.setInterval(parseInt($('input.duration').val()))
    } else {
      alert("Please Enter A Real Number");
    }
  });

  $('button.start-pairing').on('click', function(){
    backgroundPage.startPairing();
  });

  $('.pause-pairing').on('click', function(){
    backgroundPage.pause();
  });

  $('.exit-pairing').on('click', function(){
    backgroundPage.endPairingSession();
  });

  backgroundPage.updateTimerCountdown();
});