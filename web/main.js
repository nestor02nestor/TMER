let is24Hour = true;
let countdownInterval;
let remainingSeconds = 0;

function updateTime() {
    const now = new Date();
    const timeElement = document.getElementById('time');
    const dateElement = document.getElementById('date');
    
    let hours = now.getHours();
    let minutes = now.getMinutes();
    let seconds = now.getSeconds();
    let timeString;
    
    if (!is24Hour) {
        const period = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12 || 12;
        timeString = `${padNumber(hours)}:${padNumber(minutes)}:${padNumber(seconds)} ${period}`;
    } else {
        timeString = `${padNumber(hours)}:${padNumber(minutes)}:${padNumber(seconds)}`;
    }
    
    timeElement.textContent = timeString;
    dateElement.textContent = now.toISOString().split('T')[0];
}

function padNumber(num) {
    return num.toString().padStart(2, '0');
}

function toggleTimeFormat() {
    is24Hour = !is24Hour;
    updateTime();
}

function toggleTheme() {
    document.body.classList.toggle('dark-mode');
}

function startCountdown() {
    const minutes = prompt('Enter minutes for countdown:', '5');
    if (minutes === null || minutes === '') return;
    
    remainingSeconds = parseInt(minutes) * 60;
    updateCountdown();
    document.getElementById('stopBtn').style.display = 'inline';
    
    countdownInterval = setInterval(() => {
        if (remainingSeconds > 0) {
            remainingSeconds--;
            updateCountdown();
        } else {
            stopCountdown();
            alert('Countdown finished!');
        }
    }, 1000);
}

function updateCountdown() {
    const hours = Math.floor(remainingSeconds / 3600);
    const minutes = Math.floor((remainingSeconds % 3600) / 60);
    const seconds = remainingSeconds % 60;
    
    document.getElementById('countdown').textContent = 
        `${padNumber(hours)}:${padNumber(minutes)}:${padNumber(seconds)}`;
}

function stopCountdown() {
    clearInterval(countdownInterval);
    document.getElementById('stopBtn').style.display = 'none';
    document.getElementById('countdown').textContent = '00:00:00';
}

// Update time every second
setInterval(updateTime, 1000);
updateTime(); // Initial update
