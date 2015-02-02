$(document).ready(function(){
  var backgroundPage = chrome.extension.getBackgroundPage();

  $('#pair-me-icon').on('click', function(e){
    e.preventDefault();
    $.ajax({
      url: "http://localhost:9393/session",
      type: "post",
      data: $('#pair_login').serialize(),
      dataType: 'json'
    })
    .done(function(data){
      backgroundPage.currentView = '.duration-form';
      backgroundPage.user1 = data['user1'];
      backgroundPage.user2 = data['user2'];
      $('.sign-in').hide();
      $('.duration-form').show();
    })
    .fail(function(data){
      $('.sign-in').prepend("<p style='color:white;font-size:1em'><b>Authentication Failed Please Try Again</b></p>");
    });
  });

  $('button.start-pairing').on('click', function(){
    if($('input.duration').val() !== "" ){
      backgroundPage.setTimeInterval(parseInt($('input.duration').val()));
      backgroundPage.startPairing();
    } else {
      alert("Please Enter A Real Number");
    }
    backgroundPage.currentView='.running-session';
    setPopupView();
  });

  $('.pause-pairing').on('click', function(){
    backgroundPage.pause();
  });

  $('.exit-pairing').on('click', function(){
    backgroundPage.endPairingSession();
  });
  backgroundPage.getPopup();
  backgroundPage.updateTimerCountdown();

  function setPopupView(){
    var currentView = backgroundPage.currentView;
    if(currentView){
      $('.sign-in').hide();
      $('.duration-form').hide();
      $('.running-session').hide();
      $(currentView).show();
    }
  }

  setPopupView();
});