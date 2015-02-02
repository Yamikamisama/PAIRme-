var user1, user2, currentSession, startTime, endTime, currentInterval,pairingDurationMs, timer, popup, currentView, totalSession;
var sessions = [];
var totalTimeWorking = 0;

function PairingSession(user1, user2){
  this.drive = user1;
  this.navigate = user2;
  this.timeWorked = 0;
  this.timePaused = 0;
}

function TotalSessionInfo(){
  this.totalTime = 0;
  this.activeTime = 0;
  this.pauseTime = 0;
  this.user1DriverTime = 0;
  this.user2DriverTime = 0;
}

TotalSessionInfo.prototype.getTotalTime = function(){
  this.totalTime = this.activeTime + this.pauseTime;
};

function getPopup(){
  var views = chrome.extension.getViews({ type: "popup" });
  popup = views[0];
}

function setTimeInterval(interval){
  currentInterval = interval;
  pairingDurationMs = currentInterval * 60000;
}

function pause(){
  if(timer){
    stopTimer();
  } else {
    console.log("unpause");
    startTimerCount();
  }
}

function endPairingSession(){
   if(currentSession.timeWorked === 0){
    endSession();
  }
  totalSession = new TotalSessionInfo(activeTime, inActiveTime);
  sessions.forEach(function(pairSession){
    totalSession.activeTime += pairSession.timeWorked;
    totalSession.pauseTime += pairSession.timePaused;
    if(user1 === pairSession.driver){
      totalSession.user1DriverTime += pairSession.timeWorked
    } else {
      totalSession.user2DriverTime += pairSession.timeWorked
    }
  });
  totalSession.getTotalTime();
  stopTimer();
  currentView = null;
  sendInfoToDatabase();
}

function startPairing(){
  updateTimerCountdown();
  var date = new Date();
  startTime = date.getTime();
  currentSession = new PairingSession(user1, user2);
  sessions.push(currentSession);
  startTimerCount();
}

function startTimerCount(){
  timer = setTimeout(function(){
    totalTimeWorking ++;
    currentInterval--;
    updateTimerCountdown();
    checkDuration();
    clearTimeout(timer);
    startTimerCount();
  }, 60000);
}

function stopTimer(){
  console.log("timer", timer);
  clearInterval(timer);
  timer = null;
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
  currentSession.timeWorked = currentInterval;
  currentSession.timePaused =  (endTime - startTime - (totalTimeWorking * 60000)) / 60000;
  if(currentSession.timePaused == null || currentSession.timePaused < .1){
    currentSession.timePaused = 0;
  }
  totalTimeWorking = 0;
}

function updateTimerCountdown(){
  popup.document.getElementsByClassName('countdown')[0].innerHTML =currentInterval;
}

function sendInfoToDatabase(){
  $.ajax({
    url: 'http://localhost:9393/session/data',
    type: 'post',
    data: {session: totalSession}
  })
  .done(function(data){
    console.log('hello');
    sessions = [];
    // chrome.tabs.create({url: data['url']})
  });
};
