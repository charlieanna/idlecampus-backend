// Continuous Learning Module - No user navigation, only system-driven progression

window.ContinuousLearning = (function() {
  let config = {};
  let currentMode = 'teaching';
  let sessionActive = true;
  let currentTrack = 'docker'; // Default track
  
  function init(options) {
    config = options;
    currentMode = options.mode;
    currentTrack = options.track || 'docker';
    
    attachEventListeners();
    startSessionTimer();
    
    // Setup interactive terminal if present on page load
    setupInteractiveTerminal();
    
    console.log('Continuous Learning initialized in mode:', currentMode);
  }
  
  function setupInteractiveTerminal() {
    const inputEl = document.getElementById('terminalDirectInput') || document.getElementById('labCommand');
    const terminal = document.getElementById('labTerminal');
    if (!inputEl) return; // No terminal on this page

    // Scroll terminal to top on page load/reload
    if (terminal) {
      terminal.scrollTop = 0;
    }

    // Enter submits
    inputEl.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        if (inputEl.id === 'terminalDirectInput') {
          executeLabCommandFromTerminal();
        } else {
          // Legacy fallback
          handleAction('lab_command');
        }
      }
    });

    // Click terminal to focus (do not auto-focus on load)
    if (terminal) {
      terminal.addEventListener('click', function() {
        // Only allow focus after page load is complete
        if (window.pageLoadComplete !== false) {
          // Use preventScroll option if available to prevent page scrolling
          if (inputEl.focus && typeof inputEl.focus === 'function') {
            try {
              inputEl.focus({ preventScroll: true });
            } catch (e) {
              // Fallback for browsers that don't support preventScroll
              const scrollY = window.scrollY;
              inputEl.focus();
              if (scrollY !== window.scrollY) {
                window.scrollTo(0, scrollY);
              }
            }
          } else {
            inputEl.focus();
          }
        }
      });
    }
    
    // Explicitly blur input on page load
    if (inputEl) {
      inputEl.blur();
    }
  }
  
  function attachEventListeners() {
    // Universal action handler
    document.addEventListener('click', function(e) {
      if (e.target.dataset.action) {
        e.preventDefault();
        handleAction(e.target.dataset.action);
      }
    });
  }
  
  function handleAction(action) {
    console.log('Handling action:', action);
    
    let data = {
      response_type: action,
      authenticity_token: config.csrfToken
    };
    
    // Collect response data based on action
    switch(action) {
      case 'test_answer':
        const response = document.getElementById('userResponse')?.value;
        if (!response) {
          showFeedback('Please enter an answer', 'error');
          return;
        }
        data.response = response;
        break;
        
      case 'lab_command':
        const command = document.getElementById('labCommand')?.value;
        if (!command) {
          showFeedback('Please enter a command', 'error');
          return;
        }
        data.response = command;
        break;
        
      case 'understanding_confirmed':
        // No additional data needed
        break;
        
      case 'request_hint':
        // No additional data needed
        break;
    }
    
    // Disable button to prevent double-submission
    const button = document.querySelector(`[data-action="${action}"]`);
    if (button) {
      button.disabled = true;
      button.textContent = 'Processing...';
    }
    
    // Send to server
    sendResponse(data);
  }
  
  function sendResponse(data, retryCount = 0) {
    const respondUrl = currentTrack === 'kubernetes' ? '/kubernetes/learn/respond' : '/docker/learn/respond';
    const maxRetries = 3;
    
    fetch(respondUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': config.csrfToken
      },
      body: JSON.stringify(data)
    })
    .then(response => {
      if (!response.ok) {
        // If server error (500) and we have retries left, retry automatically
        if (response.status >= 500 && retryCount < maxRetries) {
          console.warn(`Server error ${response.status}, retrying (${retryCount + 1}/${maxRetries})...`);
          // Exponential backoff: 500ms, 1s, 2s
          const delay = 500 * Math.pow(2, retryCount);
          setTimeout(() => {
            sendResponse(data, retryCount + 1);
          }, delay);
          return null;
        }
        throw new Error(`Server error: ${response.status}`);
      }
      return response.json();
    })
    .then(result => {
      if (result) {
        handleServerResponse(result);
      }
    })
    .catch(error => {
      console.error('Error:', error);
      if (retryCount < maxRetries) {
        console.warn(`Network error, retrying (${retryCount + 1}/${maxRetries})...`);
        const delay = 500 * Math.pow(2, retryCount);
        setTimeout(() => {
          sendResponse(data, retryCount + 1);
        }, delay);
      } else {
        showFeedback('Unable to connect. Please check your connection and try again.', 'error');
        resetButtons();
      }
    });
  }
  
  function handleServerResponse(result) {
    console.log('Server response:', result);

    // Check for session completion
    if (result.session_complete) {
      const completeUrl = currentTrack === 'kubernetes' ? '/kubernetes/learn/complete' : '/docker/learn/complete';
      window.location.href = result.redirect_url || completeUrl;
      return;
    }

    // Show lab interface if practice mode
    if (result.show_lab) {
      showLabInterface(result.exercise, result.lab_session_id);
      updateSessionStats(result.session_stats);
      return;
    }

    // Handle reload page request (advance to next micro)
    if (result.reload_page) {
      setTimeout(() => {
        const learnUrl = currentTrack === 'kubernetes' ? '/kubernetes/learn' : '/docker/learn';
        window.location.href = learnUrl;
      }, 500);
      return;
    }

    // Update session stats if provided
    if (result.session_stats) {
      updateSessionStats(result.session_stats);
    }

    // Handle progression to next content
    if (result.next_content || result.advance_to_next) {
      // If correct, show success modal with Next button (don't show feedback - modal shows "Great Job!")
      if (result.correct) {
        showSuccessModal();
      } else {
        // For non-correct but advancing scenarios, show feedback then auto-advance
        if (result.feedback) {
          showFeedback(result.feedback, 'error');
        }
        setTimeout(() => {
          const learnUrl = currentTrack === 'kubernetes' ? '/kubernetes/learn' : '/docker/learn';
          window.location.href = learnUrl;
        }, 1000);
      }
    } else {
      // Show feedback for non-advancing scenarios
      if (result.feedback) {
        showFeedback(result.feedback, result.correct ? 'success' : 'error');
      }
      // Re-enable buttons if not advancing
      resetButtons();
    }
  }
  
  function showLabInterface(exercise, labSessionId) {
    // Store lab session ID
    config.labSessionId = labSessionId;
    
    // Replace content area with lab terminal
    const contentArea = document.querySelector('.content-inner');
    if (!contentArea) return;
    
    contentArea.innerHTML = `
      <div class="lab-exercise">
        <div class="content-header">
          <div class="mode-badge lab-badge">
            <span class="badge-icon">🔧</span>
            <span class="badge-text">Hands-On Lab</span>
          </div>
        </div>
        
        <h2 class="lab-title">Practice Exercise</h2>
        
        <div class="problem-box">
          <div class="problem-icon">🎯</div>
          <div class="problem-content">
            <h4>Your Task</h4>
            <p>${exercise.problem}</p>
          </div>
        </div>
        
        ${exercise.why_this_flag ? `
          <div class="why-section">
            <div class="why-icon">🤔</div>
            <div class="why-content">
              <h4>Why This Matters</h4>
              <p>${exercise.why_this_flag}</p>
            </div>
          </div>
        ` : ''}
        
        ${exercise.real_world_use ? `
          <div class="real-world-section">
            <div class="rw-icon">💼</div>
            <div class="rw-content">
              <h4>Real-World Use</h4>
              <p>${exercise.real_world_use}</p>
            </div>
          </div>
        ` : ''}
        
        <div class="reference-commands">
          <div class="reference-header">
            <span class="ref-icon">📚</span>
            <h4>Reference Commands</h4>
            <button class="toggle-ref" onclick="this.closest('.reference-commands').classList.toggle('collapsed')">−</button>
          </div>
          <div class="reference-body">
            <div class="ref-hint">Click any command to copy it</div>
            <div class="ref-commands-grid" id="referenceCommands"></div>
          </div>
        </div>
        
        <div class="terminal-section">
          <div class="terminal-header">
            <div class="terminal-controls">
              <span class="terminal-dot red"></span>
              <span class="terminal-dot yellow"></span>
              <span class="terminal-dot green"></span>
            </div>
            <div class="terminal-title">Docker Lab Terminal - Click to type directly</div>
          </div>
          
          <div class="terminal-body interactive-terminal" id="labTerminal" tabindex="0">
            <div class="terminal-output" id="terminalOutput">
              <div class="terminal-welcome">
                <span style="color: #4CAF50;">●</span> Lab environment ready! 
                Type commands directly here or use the input below.
              </div>
            </div>
            <div class="terminal-input-line" id="terminalInputLine">
              <span class="terminal-prompt">root@docker:~$</span>
              <input type="text" 
                     class="terminal-inline-input" 
                     id="terminalDirectInput"
                     autocomplete="off"
                     spellcheck="false">
              <span class="terminal-cursor">_</span>
            </div>
          </div>
        </div>
        
        <div id="labFeedback" class="lab-feedback"></div>
        
        <div class="hints-section" id="hintsSection" style="display: none;">
          <h4>💡 Hint</h4>
          <p id="hintText"></p>
        </div>
        
        <div class="lab-navigation">
          <button class="skip-btn" onclick="window.location.href='/${currentTrack}/learn'">
            ← Skip & Continue
          </button>
          <button class="restart-btn" onclick="if(confirm('Restart your learning session?')) { window.location.href='/${currentTrack}/learn/restart' }">
            🔄 Restart From Beginning
          </button>
        </div>
      </div>
    `;
    
    // Attach event listeners
    attachLabEventListeners();
  }
  
  function attachLabEventListeners() {
    const directInput = document.getElementById('terminalDirectInput');
    const terminal = document.getElementById('labTerminal');
    
    // Populate reference commands
    populateReferenceCommands();
    
    // Direct terminal input (only method now)
    if (directInput) {
      directInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
          executeLabCommandFromTerminal();
        }
      });
      // Do not auto-focus on page load - let user start reading the lesson
    }
    
    // Click on terminal to focus direct input
    if (terminal && directInput) {
      terminal.addEventListener('click', function() {
        directInput.focus();
      });
    }
  }
  
  function populateReferenceCommands() {
    const refGrid = document.getElementById('referenceCommands');
    if (!refGrid) return;
    
    // Get reference commands based on what the user is currently learning
    // For now, show only docker run variations since that's what they're practicing
    const referenceCommands = [
      { cmd: 'docker run nginx', desc: 'Basic form - run nginx' },
      { cmd: 'docker run redis', desc: 'Run redis container' },
      { cmd: 'docker run ubuntu', desc: 'Run ubuntu container' }
    ];
    
    refGrid.innerHTML = referenceCommands.map(ref => `
      <div class="ref-command-card" onclick="copyRefCommand('${ref.cmd}')">
        <code>${ref.cmd}</code>
        <span class="ref-desc">${ref.desc}</span>
      </div>
    `).join('');
  }
  
  window.copyRefCommand = function(cmd) {
    navigator.clipboard.writeText(cmd).then(() => {
      const card = event.target.closest('.ref-command-card');
      const originalBg = card.style.background;
      card.style.background = '#4CAF50';
      card.style.color = 'white';
      setTimeout(() => {
        card.style.background = originalBg;
        card.style.color = '';
      }, 500);
    });
  };
  
  function executeLabCommandFromTerminal() {
    const directInput = document.getElementById('terminalDirectInput') || document.getElementById('labCommand');
    const command = (directInput?.value || '').trim();

    if (!command) return;

    // Show the command in terminal history (like real terminal)
    addToTerminal('command', command);

    // Clear the input immediately
    directInput.value = '';

    // Execute the command
    executeCommand(command);
  }
  
  function showExecutingAnimation() {
    const output = document.getElementById('terminalOutput');
    if (!output) return;
    
    const executingLine = document.createElement('div');
    executingLine.className = 'terminal-executing';
    executingLine.innerHTML = '<span class="executing-dots">Executing<span class="dot">.</span><span class="dot">.</span><span class="dot">.</span></span>';
    executingLine.id = 'executingIndicator';
    output.appendChild(executingLine);
  }
  
  function removeExecutingAnimation() {
    const indicator = document.getElementById('executingIndicator');
    if (indicator) {
      indicator.style.opacity = '0';
      setTimeout(() => indicator.remove(), 300);
    }
  }
  
  function executeCommand(command, retryCount = 0) {
    const maxRetries = 3;
    
    // Disable terminal input while executing
    const directInput = document.getElementById('terminalDirectInput') || document.getElementById('labCommand');
    if (directInput) {
      directInput.disabled = true;
      directInput.placeholder = retryCount > 0 ? `Retrying (${retryCount}/${maxRetries})...` : 'Executing...';
    }
    
    // Send to server
    const executeUrl = currentTrack === 'kubernetes' ? '/kubernetes/learn/execute' : '/docker/learn/execute';
    fetch(executeUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': config.csrfToken
      },
      body: JSON.stringify({ command: command })
    })
    .then(response => {
      if (!response.ok) {
        // If server error (500) and we have retries left, retry automatically
        if (response.status >= 500 && retryCount < maxRetries) {
          console.warn(`Server error ${response.status}, retrying command (${retryCount + 1}/${maxRetries})...`);
          const delay = 500 * Math.pow(2, retryCount);
          setTimeout(() => {
            executeCommand(command, retryCount + 1);
          }, delay);
          return null;
        }
        throw new Error(`Server error: ${response.status}`);
      }
      return response.json();
    })
    .then(result => {
      if (!result) return; // Retry in progress
      
      console.log('Lab command result:', result);
      
      // Remove executing animation
      removeExecutingAnimation();
      
      // Show command output in terminal (for both correct and incorrect)
      if (result.output || result.error) {
        addToTerminal('output', result.output || result.error || 'No output');
      }

      // Show success feedback below terminal for correct answers
      if (result.correct && result.feedback) {
        showFeedbackWithAnimation(result.feedback, true);
      }
      
      // Show hint if incorrect
      if (!result.correct && result.hint) {
        showHint(result.hint);
      }
      
      // If correct, show success modal with Next button
      if (result.advance_to_next) {
        updateSessionStats(result.session_stats);
        showSuccessAnimation();
        showSuccessModal();
      } else {
        // Re-enable terminal input for retry with shake animation
        const directInput = document.getElementById('terminalDirectInput');
        if (directInput) {
          directInput.disabled = false;
          directInput.placeholder = '';
          directInput.focus();
          // Shake the terminal to indicate retry
          shakeTerminal();
        }
      }
    })
    .catch(error => {
      console.error('Error:', error);
      removeExecutingAnimation();
      
      if (retryCount < maxRetries) {
        console.warn(`Network error, retrying command (${retryCount + 1}/${maxRetries})...`);
        const delay = 500 * Math.pow(2, retryCount);
        setTimeout(() => {
          executeCommand(command, retryCount + 1);
        }, delay);
      } else {
        showFeedback('Unable to connect after multiple attempts. Please check your connection.', 'error');
        
        // Re-enable terminal input
        const directInput = document.getElementById('terminalDirectInput');
        if (directInput) {
          directInput.disabled = false;
          directInput.placeholder = '';
          directInput.focus();
        }
      }
    });
  }
  
  function addToTerminal(type, text) {
    const output = document.getElementById('terminalOutput');
    if (!output) return;
    
    const line = document.createElement('div');
    line.style.opacity = '0';
    line.style.transform = 'translateX(-10px)';
    
    if (type === 'command') {
      line.className = 'terminal-command terminal-slide-in';
      line.innerHTML = `<span class="prompt">root@docker:~$</span> <span class="cmd">${text}</span>`;
    } else {
      line.className = 'terminal-output terminal-slide-in';
      line.textContent = text;
    }
    
    output.appendChild(line);
    
    // Trigger animation
    setTimeout(() => {
      line.style.transition = 'opacity 0.4s ease, transform 0.4s ease';
      line.style.opacity = '1';
      line.style.transform = 'translateX(0)';
    }, 10);
    
    // Scroll to bottom with smooth animation
    const terminal = document.getElementById('labTerminal');
    if (terminal) {
      terminal.scrollTo({
        top: terminal.scrollHeight,
        behavior: 'smooth'
      });
    }
  }

  function clearTerminalOutput() {
    const output = document.getElementById('terminalOutput');
    if (output) {
      output.innerHTML = '';
    }

    // Also clear feedback area to avoid duplicate messages
    const feedbackArea = document.getElementById('labFeedback');
    if (feedbackArea) {
      feedbackArea.innerHTML = '';
    }
  }

  function showFeedbackWithAnimation(message, isCorrect) {
    const feedbackArea = document.getElementById('labFeedback');
    if (!feedbackArea) return;
    
    const type = isCorrect ? 'success' : 'error';
    const icon = isCorrect ? '🎉' : '🤔';
    
    feedbackArea.innerHTML = `
      <div class="feedback-message feedback-${type} feedback-bounce">
        <span class="feedback-icon">${icon}</span>
        <span class="feedback-text">${message}</span>
      </div>
    `;
  }
  
  function showSuccessAnimation() {
    const terminal = document.getElementById('labTerminal');
    if (terminal) {
      terminal.classList.add('success-glow');
      setTimeout(() => {
        terminal.classList.remove('success-glow');
      }, 2000);
    }
  }
  
  function shakeTerminal() {
    const terminal = document.getElementById('labTerminal');
    if (terminal) {
      terminal.classList.add('shake-animation');
      setTimeout(() => {
        terminal.classList.remove('shake-animation');
      }, 500);
    }
  }
  
  function showFeedback(message, type) {
    const feedbackArea = document.getElementById('feedbackArea') || 
                        document.getElementById('labFeedback');
    
    if (feedbackArea) {
      feedbackArea.innerHTML = `
        <div class="feedback-message feedback-${type}">
          ${message}
        </div>
      `;
    }
  }
  
  function showHint(hint) {
    const hintArea = document.getElementById('hintArea');
    const hintsSection = document.getElementById('hintsSection');
    const hintText = document.getElementById('hintText');
    
    if (hintArea) {
      hintArea.innerHTML = `
        <div class="hint-box">
          ${hint}
        </div>
      `;
    }
    
    if (hintsSection && hintText) {
      hintText.textContent = hint;
      hintsSection.style.display = 'block';
    }
  }
  
  function updateSessionStats(stats) {
    // Update progress bar
    const progressFill = document.querySelector('.progress-bar-fill');
    if (progressFill && stats.items_completed) {
      const progress = Math.min(100, (stats.items_completed / 25) * 100);
      progressFill.style.width = progress + '%';
    }
    
    // Update stat cards
    const accuracyValue = document.querySelector('.accuracy-card .stat-value');
    if (accuracyValue && stats.accuracy !== undefined) {
      accuracyValue.textContent = stats.accuracy + '%';
    }
    
    const streakValue = document.querySelector('.streak-card .stat-value');
    if (streakValue && stats.streak !== undefined) {
      streakValue.textContent = stats.streak;
    }
  }
  
  function transitionToNextContent(nextContent) {
    console.log('Transitioning to:', nextContent.mode);
    
    // Smooth fade transition
    const contentArea = document.getElementById('dynamicContent');
    
    contentArea.style.opacity = '0';
    contentArea.style.transition = 'opacity 0.3s ease';
    
    setTimeout(() => {
      // Update content
      renderContent(nextContent);
      
      // Fade back in
      contentArea.style.opacity = '1';
      
      // Update mode
      currentMode = nextContent.mode;
      document.getElementById('learningContainer').dataset.mode = currentMode;
      
      // Focus appropriate input
      setTimeout(() => {
        const input = document.querySelector('.response-input');
        if (input) input.focus();
      }, 100);
    }, 300);
  }
  
  function renderContent(content) {
    const contentArea = document.getElementById('dynamicContent');
    
    let html = '';
    
    switch(content.mode) {
      case 'teaching':
        html = renderTeachingContent(content);
        break;
      case 'testing':
        html = renderTestingContent(content);
        break;
      case 'lab':
        html = renderLabContent(content);
        break;
      default:
        html = '<p>Loading...</p>';
    }
    
    contentArea.innerHTML = html;
    
    // Reattach any needed event listeners
    attachContentEventListeners();
  }
  
  function renderTeachingContent(content) {
    const c = content.content;
    const m = content.metadata;
    
    let html = `
      <div class="teaching-content">
        <h3>📚 ${c.title}</h3>
    `;
    
    if (m.is_stealth_review && m.stealth_disguise) {
      html += `<p class="lead">${m.stealth_disguise}</p>`;
    } else {
      html += `<div class="explanation">${c.explanation}</div>`;
    }
    
    if (c.examples && c.examples.length > 0) {
      html += '<h5>Examples:</h5>';
      c.examples.forEach(example => {
        html += `<div class="command-highlight"><code>${example}</code></div>`;
      });
    }
    
    if (c.command_to_learn) {
      html += `
        <div class="key-concept">
          <h5>Command to Remember:</h5>
          <div class="command-highlight">
            <code>${c.command_to_learn}</code>
          </div>
        </div>
      `;
    }
    
    html += `
      <button class="action-button" data-action="understanding_confirmed">
        I understand, let's practice
      </button>
    </div>`;
    
    return html;
  }
  
  function renderTestingContent(content) {
    const c = content.content;
    
    return `
      <div class="testing-content">
        <h4>🧪 Practice Time</h4>
        <p>${c.title || c.description || 'Type the command:'}</p>
        
        <input type="text" 
               class="response-input" 
               id="userResponse" 
               placeholder="Enter your answer..."
               autocomplete="off">
        
        <div id="feedbackArea"></div>
        
        <div style="display: flex; align-items: center;">
          <button class="action-button" data-action="test_answer">
            Submit Answer
          </button>
          <span class="hint-link" data-action="request_hint">
            💡 Need a hint?
          </span>
        </div>
        
        <div id="hintArea"></div>
      </div>
    `;
  }
  
  function renderLabContent(content) {
    const c = content.content;
    
    let html = `
      <div class="lab-content">
        <h3>🔧 ${c.title}</h3>
        <p>${c.scenario}</p>
    `;
    
    if (c.objectives && c.objectives.length > 0) {
      html += '<h5>Your Mission:</h5><ol>';
      c.objectives.forEach(obj => {
        html += `<li>${obj}</li>`;
      });
      html += '</ol>';
    }
    
    html += `
      <div class="lab-terminal" id="labTerminal">
        <div class="command-line">
          <span class="prompt">$</span> <span id="terminalCursor">_</span>
        </div>
      </div>
      
      <input type="text" 
             class="response-input" 
             id="labCommand" 
             placeholder="Enter Docker command...">
      
      <button class="action-button" data-action="lab_command">
        Execute Command
      </button>
      
      <div id="labFeedback"></div>
    </div>`;
    
    return html;
  }
  
  function attachContentEventListeners() {
    // Enter key handlers
    const responseInput = document.getElementById('userResponse');
    if (responseInput) {
      responseInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
          handleAction('test_answer');
        }
      });
    }
    
    const labInput = document.getElementById('labCommand');
    if (labInput) {
      labInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
          handleAction('lab_command');
        }
      });
    }
  }
  
  function resetButtons() {
    document.querySelectorAll('.action-button').forEach(btn => {
      btn.disabled = false;
      // Reset text based on action
      if (btn.dataset.action === 'test_answer') {
        btn.textContent = 'Submit Answer';
      } else if (btn.dataset.action === 'understanding_confirmed') {
        btn.textContent = "I understand, let's practice";
      }
    });
  }
  
  function startSessionTimer() {
    // Update duration every minute
    setInterval(() => {
      if (sessionActive) {
        const durationElement = document.getElementById('sessionDuration');
        if (durationElement) {
          const current = parseInt(durationElement.textContent) || 0;
          durationElement.textContent = (current + 1) + ' min';
        }
      }
    }, 60000);
  }
  
  function showSessionSummary(summary) {
    sessionActive = false;
    
    const summaryStats = document.getElementById('summaryStats');
    if (summaryStats) {
      summaryStats.innerHTML = `
        <div class="stat-box">
          <div class="stat-value">${summary.items_completed}</div>
          <div class="stat-label">Items Completed</div>
        </div>
        <div class="stat-box">
          <div class="stat-value">${summary.accuracy}%</div>
          <div class="stat-label">Accuracy</div>
        </div>
        <div class="stat-box">
          <div class="stat-value">${summary.mastery_gain}%</div>
          <div class="stat-label">Mastery Gained</div>
        </div>
        <div class="stat-box">
          <div class="stat-value">${summary.duration_minutes}min</div>
          <div class="stat-label">Time Spent</div>
        </div>
      `;
    }
    
    const overlay = document.getElementById('sessionComplete');
    if (overlay) {
      overlay.classList.add('active');
    }
  }
  
  function showSuccessModal() {
    // Remove any existing modal
    const existingModal = document.getElementById('successModal');
    if (existingModal) {
      existingModal.remove();
    }

    // Get current chapter info from page
    const chapterNameEl = document.querySelector('.chapter-item.current .chapter-name');
    const currentChapter = chapterNameEl ? chapterNameEl.textContent : 'this chapter';

    // Get mastery score if available
    const masteryScoreEl = document.querySelector('.chapter-item.current .mastery-score');
    const masteryScore = masteryScoreEl ? masteryScoreEl.textContent : '';

    // Find next chapter
    const currentChapterItem = document.querySelector('.chapter-item.current');
    const nextChapterItem = currentChapterItem ? currentChapterItem.closest('.journey-step').nextElementSibling?.querySelector('.chapter-item') : null;
    const nextChapterName = nextChapterItem ? nextChapterItem.querySelector('.chapter-name')?.textContent : 'the next chapter';

    // Create modal HTML with enhanced information
    const modalHTML = `
      <div id="successModal" class="success-modal-overlay">
        <div class="success-confetti"></div>
        <div class="success-modal">
          <div class="success-animation">
            <div class="success-checkmark">
              <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
                <path class="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
              </svg>
            </div>
          </div>
          <h2 class="success-title">🎉 Great Job!</h2>
          <p class="success-message">You've mastered <strong>${currentChapter}</strong>!</p>
          ${masteryScore ? `<div class="mastery-boost">Your mastery: <span class="boost-value">${masteryScore}</span></div>` : ''}
          <div class="next-preview">
            <div class="next-preview-label">Up Next:</div>
            <div class="next-preview-chapter">${nextChapterName}</div>
          </div>
          <div class="success-actions">
            <button class="next-chapter-btn" onclick="ContinuousLearning.advanceToNext()">
              Continue Learning →
            </button>
          </div>
        </div>
      </div>
    `;

    // Add to body
    document.body.insertAdjacentHTML('beforeend', modalHTML);

    // Trigger confetti animation
    createConfetti();

    // Trigger modal animation with staggered elements
    setTimeout(() => {
      const modal = document.getElementById('successModal');
      if (modal) {
        modal.classList.add('active');

        // Stagger animations for child elements
        setTimeout(() => {
          const checkmark = modal.querySelector('.success-checkmark');
          if (checkmark) checkmark.classList.add('animate');
        }, 200);

        setTimeout(() => {
          const title = modal.querySelector('.success-title');
          if (title) title.classList.add('fade-in-up');
        }, 400);

        setTimeout(() => {
          const message = modal.querySelector('.success-message');
          if (message) message.classList.add('fade-in-up');
        }, 600);

        setTimeout(() => {
          const boost = modal.querySelector('.mastery-boost');
          if (boost) boost.classList.add('fade-in-up');
        }, 800);

        setTimeout(() => {
          const preview = modal.querySelector('.next-preview');
          if (preview) preview.classList.add('fade-in-up');
        }, 1000);

        setTimeout(() => {
          const actions = modal.querySelector('.success-actions');
          if (actions) actions.classList.add('fade-in-up');
        }, 1200);
      }
    }, 10);
  }

  function createConfetti() {
    const confettiContainer = document.querySelector('.success-confetti');
    if (!confettiContainer) return;

    const colors = ['#667eea', '#764ba2', '#51cf66', '#fab005', '#ff6b6b', '#00d4ff'];
    const confettiCount = 50;

    for (let i = 0; i < confettiCount; i++) {
      const confetti = document.createElement('div');
      confetti.className = 'confetti-piece';
      confetti.style.left = Math.random() * 100 + '%';
      confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
      confetti.style.animationDelay = Math.random() * 3 + 's';
      confetti.style.animationDuration = (Math.random() * 3 + 2) + 's';
      confettiContainer.appendChild(confetti);
    }
  }

  function closeSuccessModal() {
    const modal = document.getElementById('successModal');
    if (modal) {
      modal.classList.remove('active');
      setTimeout(() => {
        modal.remove();
      }, 300);
    }
  }

  function advanceToNext() {
    closeSuccessModal();
    const learnUrl = currentTrack === 'kubernetes' ? '/kubernetes/learn' : '/docker/learn';
    window.location.href = learnUrl;
  }

  // Public API
  return {
    init: init,
    handleAction: handleAction,
    showFeedback: showFeedback,
    executeTerminalCommand: executeLabCommandFromTerminal,
    advanceToNext: advanceToNext,
    closeSuccessModal: closeSuccessModal
  };
})();
