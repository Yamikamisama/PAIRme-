var user1, user2, currentSession, startTime, endTime, currentInterval,pairingDurationMs, timer, popup, currentView;
var sessions = [];
var totalTimeWorking = 0;

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
  this.user1 = user1;
  this.user2 = user2;
}

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
  var activeTime = 0;
  var inActiveTime = 0;
  sessions.forEach(function(pairSession){
    activeTime += pairSession.timeWorked;
    inActiveTime += pairSession.timePaused;
  })
  stopTimer();
  sessions.push(new TotalSessionInfo(activeTime, inActiveTime));
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
    data: {session: sessions}
  })
  .done(function(data){
    console.log('hello');
    sessions = [];
    // chrome.tabs.create({url: data['url']})
  });
};
