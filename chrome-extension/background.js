var user1, user2, currentSession, startTime, endTime, currentInterval,pairingDurationMs, timer, popup, currentView, totalSession;
var sessions = [];
var totalTimeWorking = 0;

function PairingSession(user1, user2){
  this.drive = user1;
  this.navigate = user2;
  this.timeWorked = 0;
  this.timePaused = 0;
}

function getPopup(){
  var views = chrome.extension.getViews({ type: "popup" });
  popup = views[0];
}

function setTimeInterval(interval){
  currentInterval = interval * 60000;
  pairingDurationMs = currentInterval * 60000;
}

function pause(){
  if(timer){
    stopTimer();
    return true;
  } else {
    startTimerCount();
    return false;
  }
}

function endPairingSession(){
   if(currentSession.timeWorked === 0){
    endSession();
  }
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
    totalTimeWorking += 1000;
    currentInterval -= 1000;
    checkDuration();
    updateTimerCountdown();
    clearTimeout(timer);
    startTimerCount();
  }, 1000);
}

function stopTimer(){
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
  currentSession.timeWorked = (pairingDurationMs / 60000) - currentInterval;
  currentInterval = pairingDurationMs / 60000;
  currentSession.timePaused =  (endTime - startTime - (totalTimeWorking)) / 60000;
  if(currentSession.timePaused == null || currentSession.timePaused <= .5 ){
    currentSession.timePaused = 0;
  };
  totalTimeWorking = 0;
}

function updateTimerCountdown(){
  popup.document.getElementsByClassName('countdown')[0].innerHTML = formatCurrentInterval();
}

function sendInfoToDatabase(){
  console.log('session', sessions);
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
