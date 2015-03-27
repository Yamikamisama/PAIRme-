$(document).ready(function(){
  var backgroundPage = chrome.extension.getBackgroundPage();

  $('.signup-link').on('click', function(e){
    e.preventDefault();
    backgroundPage.goToLandingPage();
  });

  $('#pair-me-icon').on('click', function(e){
    e.preventDefault();
    $.ajax({
      url: "https://pair-me-up.herokuapp.com/session",
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
      $('input').val('')
      $('countdown').val('0');
    })
    .fail(function(data){
      $('.auth-error').html("Authentication Failed Please Try Again");
      setTimeOut(function(){$('.auth-error').empty();},5000);
    });
  });

  $('.start-pairing').on('click', function(){
    var time_duration = $('input.duration').val();
    if(time_duration !== "" && !isNaN(parseInt(time_duration))){
      backgroundPage.setTimeInterval(parseInt(time_duration));
      backgroundPage.startPairing();
      backgroundPage.currentView='.running-session';
      setPopupView();
    } else {
      $('.interval-error').append("The Number You Entered Is Not Valid");
      setTimeout(function(){$('.interval-error').empty();},5000);
    }
  });

  $('.pause-pairing').on('click', function(){
    if(backgroundPage.pause()){
      $('#pause-button').hide();
      $('#resume-button').show();
    }else{
      $('#resume-button').hide();
      $('#pause-button').show();
    }

  });

  $('.exit-pairing').on('click', function(e){
    e.preventDefault();
    backgroundPage.endPairingSession();
    $('.running-session').hide();
    $('.sign-in').show();
    $('input').val('');
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