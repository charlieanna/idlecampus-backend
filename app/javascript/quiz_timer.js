// Quiz Timer Component
// Handles countdown timer for timed quizzes (e.g., Mastery Challenge)

class QuizTimer {
  constructor(timeLimitSeconds, options = {}) {
    this.timeRemaining = timeLimitSeconds;
    this.timeLimitSeconds = timeLimitSeconds;
    this.isRunning = false;
    this.intervalId = null;

    // Callbacks
    this.onTick = options.onTick || (() => {});
    this.onWarning = options.onWarning || (() => {});
    this.onExpired = options.onExpired || (() => {});

    // Warning threshold (default: 60 seconds)
    this.warningThreshold = options.warningThreshold || 60;
    this.warningTriggered = false;

    // Track start time for elapsed calculation
    this.startTime = null;
  }

  start() {
    if (this.isRunning) return;

    this.isRunning = true;
    this.startTime = Date.now();

    // Update immediately
    this.tick();

    // Start interval
    this.intervalId = setInterval(() => this.tick(), 1000);

    console.log(`⏱️ Quiz timer started: ${this.formatTime(this.timeRemaining)}`);
  }

  tick() {
    if (!this.isRunning) return;

    this.timeRemaining--;

    // Trigger warning at threshold
    if (!this.warningTriggered && this.timeRemaining <= this.warningThreshold) {
      this.warningTriggered = true;
      this.onWarning(this.timeRemaining);
    }

    // Update display
    this.onTick(this.timeRemaining);

    // Check if expired
    if (this.timeRemaining <= 0) {
      this.expire();
    }
  }

  pause() {
    if (!this.isRunning) return;

    this.isRunning = false;
    if (this.intervalId) {
      clearInterval(this.intervalId);
      this.intervalId = null;
    }

    console.log('⏸️ Quiz timer paused');
  }

  resume() {
    if (this.isRunning) return;

    this.isRunning = true;
    this.intervalId = setInterval(() => this.tick(), 1000);

    console.log('▶️ Quiz timer resumed');
  }

  stop() {
    this.pause();
    console.log('⏹️ Quiz timer stopped');
  }

  expire() {
    this.stop();
    this.timeRemaining = 0;
    this.onExpired();
    console.log('⏰ Quiz timer expired!');
  }

  getElapsedTime() {
    if (!this.startTime) return 0;
    return Math.floor((Date.now() - this.startTime) / 1000);
  }

  getElapsedPercentage() {
    return ((this.timeLimitSeconds - this.timeRemaining) / this.timeLimitSeconds) * 100;
  }

  formatTime(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  }

  isWarningState() {
    return this.timeRemaining <= this.warningThreshold;
  }

  isCriticalState() {
    return this.timeRemaining <= 30;
  }
}

// DOM Integration
document.addEventListener('DOMContentLoaded', function() {
  const timerElement = document.getElementById('quiz-timer');
  if (!timerElement) return;

  const timeLimitSeconds = parseInt(timerElement.dataset.timeLimit, 10);
  if (!timeLimitSeconds || timeLimitSeconds <= 0) return;

  const timerDisplay = document.getElementById('timer-display');
  const timerProgress = document.getElementById('timer-progress');
  const quizForm = document.querySelector('form.quiz-form');

  // Initialize timer
  const timer = new QuizTimer(timeLimitSeconds, {
    onTick: (timeRemaining) => {
      // Update display
      if (timerDisplay) {
        timerDisplay.textContent = timer.formatTime(timeRemaining);
      }

      // Update progress bar
      if (timerProgress) {
        const percentage = timer.getElapsedPercentage();
        timerProgress.style.width = `${percentage}%`;

        // Change color based on state
        if (timer.isCriticalState()) {
          timerProgress.classList.add('critical');
          timerProgress.classList.remove('warning');
        } else if (timer.isWarningState()) {
          timerProgress.classList.add('warning');
          timerProgress.classList.remove('critical');
        }
      }

      // Add pulsing animation when critical
      if (timer.isCriticalState()) {
        timerElement.classList.add('critical');
      } else if (timer.isWarningState()) {
        timerElement.classList.add('warning');
        timerElement.classList.remove('critical');
      }
    },

    onWarning: (timeRemaining) => {
      // Show warning notification
      showTimerNotification('⚠️ 1 minute remaining!', 'warning');
    },

    onExpired: () => {
      // Show expired notification
      showTimerNotification('⏰ Time\'s up! Submitting quiz...', 'error');

      // Auto-submit form after 2 seconds
      setTimeout(() => {
        if (quizForm) {
          quizForm.submit();
        }
      }, 2000);
    }
  });

  // Start timer automatically
  timer.start();

  // Store timer instance globally for debugging
  window.quizTimer = timer;

  // Pause timer when page is hidden (user switches tab)
  document.addEventListener('visibilitychange', () => {
    if (document.hidden) {
      timer.pause();
    } else {
      timer.resume();
    }
  });

  // Helper: Show timer notification
  function showTimerNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `timer-notification ${type}`;
    notification.textContent = message;
    notification.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      padding: 15px 25px;
      background: ${type === 'error' ? '#dc3545' : type === 'warning' ? '#ffc107' : '#17a2b8'};
      color: white;
      border-radius: 8px;
      font-weight: 600;
      z-index: 10000;
      animation: slideInRight 0.3s ease-out;
    `;

    document.body.appendChild(notification);

    // Remove after 3 seconds
    setTimeout(() => {
      notification.style.animation = 'fadeOut 0.3s ease-out';
      setTimeout(() => notification.remove(), 300);
    }, 3000);
  }
});

// Export for use in other modules
if (typeof module !== 'undefined' && module.exports) {
  module.exports = QuizTimer;
}
