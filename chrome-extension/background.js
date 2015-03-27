var user1, user2, currentSession, startTime, endTime, currentInterval,pairingDurationMs, timer, popup, currentView, totalSession;
var sessions = [];
var totalTimeWorking = 0;

function PairingSession(driver, nav){
  this.drive = driver;
  this.navigate = nav;
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
    updateTimerCountdown();
    checkDuration();
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
    alert("Time To Switch Roles");
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
    url: 'https://pair-me-up.herokuapp.com/session/data',
    type: 'post',
    data: {session: sessions}
  })
  .done(function(data){
    console.log('hello');
    sessions = [];
    // chrome.tabs.create({url: data['url']})
  });
};

function formatCurrentInterval(){
  var timeLeft = currentInterval;
  var hours = Math.floor(timeLeft / 3600000);
  var minutes = Math.floor((timeLeft % 3600000) / 60000);
  var seconds = Math.floor(((timeLeft % 360000) % 60000) / 1000);
  if(hours > 0){
    return hours + ":" + minutes + ":" + seconds;
  } else {
    if(seconds >= 10){
      return minutes + ":" + seconds;
    } else {
      return minutes + ":0" + seconds;
    }
  }
};

function goToLandingPage(){
  chrome.tabs.create({ url: 'https://pair-me-up.herokuapp.com'});
};
