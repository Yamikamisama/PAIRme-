$(document).ready(function(){
  var user1, user2, currentSession, startTime, endTime, currentInterval, totalTimeWorking, pairingDurationMs, timer;
  var sessions = [];


  $('button.duration-button').on('click', function(event){
    event.preventDefault();
    if($('input.duration').val() !== "" ){
      currentInterval = parseInt($('input.duration').val());
      pairingDurationMs = currentInterval * 60000;
    } else {
      alert("Please Enter A Real Number");
    }
  });

  $('.pause_button').on('click', function(){

  })

  $('button.start-pairing').on('click', function(){
    var date = new Date();
    startTime = date.getTime();
    currentSession = sessions.push(PairingSession(user1, user2));
    startTimerCount();
  });

  $('.pause_button').on('click', function(){
    if(timer){
      window.clearInterval(timer);
      timer = null;
    } else {
      startTimerCount();
    }
  });

  function PairingSession(user1, user2){
    this.drive = user1;
    this.navigate = user2;
    this.timeWorked = 0;
    this.timePaused = 0;
  }

  function TotalSessionInfo(activeTime, pauseTime){
    this.totalTime = pauseTime + activeTime;
    this.activeTime = activeTime;
    this.pauseTime = pauseTime;

  }

  function startTimerCount(){
    timer = setInterval(function(){
      totalTimeWorking ++;
      currentInterval --;
      updateTimerCountdown();
      checkDuration();
    }, 60000);
  }

  function calculatePauseTime(){
    pause_time = endTime - startTime - totalTimeWorking;
    currentSession.timePaused = pause_time;
  }

  function stopTimer(){
    window.clearInterval(timer);
  }

  function checkDuration(){
    if(currentInterval === 0){
      currentInterval = pairingDurationMs / 60000;
      alert('Switch it ^');
    }
  }

  function updateTimerCountdown(){
    $('.countdown').val(currentInterval);
  }
});



