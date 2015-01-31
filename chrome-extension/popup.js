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

  $('button.start-pairing').on('click', function(){
    var date = new Date();
    startTime = date.getTime();
    currentSession = sessions.push(PairingSession(user1, user2));
    startTimerCount();
  });

  function PairingSession(){
    this.drive = user1;
    this.navigate = user2;
    this.timeWorked;
    this.timePaused;
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



