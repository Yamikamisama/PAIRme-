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
    startPairing();
  });

  $('.pause_button').on('click', function(){
    if(timer){
      window.clearInterval(timer);
      timer = null;
    } else {
      startTimerCount();
    }
  });

  $('.exit_session').on('click', function(){
    if(currentSession.timeWorked === 0){
      endSession();
    }
    var activeTime = 0;
    var inActiveTime = 0;
    sessions.forEach(function(pairSession){
      activeTime += pairSession.timeWorked;
      inActiveTime += pairSession.timePaused;
    })
    sessions.push(TotalSessionInfo(activeTime, inActiveTime));
  })

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

  function startPairing(){
    var date = new Date();
    startTime = date.getTime();
    currentSession = sessions.push(PairingSession(user1, user2));
    startTimerCount();
  }

  function startTimerCount(){
    timer = setInterval(function(){
      totalTimeWorking ++;
      currentInterval --;
      updateTimerCountdown();
      checkDuration();
    }, 60000);
  }

  function stopTimer(){
    window.clearInterval(timer);
  }

  function checkDuration(){
    if(currentInterval === 0){
      endSession();
      alert('Switch it ^');
      startPairing();
    }
  }

  function endSession(){
    var date = new Date();
    endTime = date.getTime();
    currentInterval = pairingDurationMs / 60000;
    currentSession.timeWorked = 20;
    currentSession.timePaused = startTime - endTime - currentInterval;
  }

  function updateTimerCountdown(){
    $('.countdown').val(currentInterval);
  }
});



