// Continuous Learning Pack
import '../continuous_learning';

// Initialize when page loads
function ensureTop() {
  try {
    if ('scrollRestoration' in history) {
      history.scrollRestoration = 'manual';
    }
    
    // Ensure terminal input doesn't get focus on page load (do this first)
    const terminalInput = document.getElementById('terminalDirectInput') || document.getElementById('labCommand');
    if (terminalInput) {
      terminalInput.blur();
      // Prevent focus from scrolling the page
      terminalInput.addEventListener('focus', function(e) {
        // Only prevent scroll on initial page load, not user-initiated focus
        if (!window.pageLoadComplete) {
          e.preventDefault();
          this.blur();
        }
      }, { once: true });
    }
    
    // Scroll terminal to top on page load/reload (but don't scroll page to it)
    const terminal = document.getElementById('labTerminal');
    if (terminal) {
      terminal.scrollTop = 0;
    }
    
    // Scroll page to very top - do this after blurring inputs
    window.scrollTo(0, 0);
    
    // Prevent any focus events from scrolling during page load
    const preventFocusScroll = (e) => {
      if (!window.pageLoadComplete && (e.target.id === 'terminalDirectInput' || e.target.id === 'labCommand')) {
        window.scrollTo(0, 0);
      }
    };
    document.addEventListener('focusin', preventFocusScroll, true);
    
    // Mark page load as complete after a short delay
    setTimeout(() => {
      window.pageLoadComplete = true;
      document.removeEventListener('focusin', preventFocusScroll, true);
    }, 1000);
  } catch (e) {}
}

function initContinuousLearning() {
  if (typeof window.ContinuousLearning !== 'undefined') {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;
    window.ContinuousLearning.init({
      csrfToken: csrfToken,
      mode: document.getElementById('learning-content')?.dataset.mode || 'teaching'
    });
  }
}

document.addEventListener('DOMContentLoaded', () => {
  window.pageLoadComplete = false;
  ensureTop();
  // Delay init slightly to ensure ensureTop runs first
  setTimeout(() => {
    initContinuousLearning();
  }, 50);
});

document.addEventListener('turbolinks:load', () => {
  window.pageLoadComplete = false;
  ensureTop();
  // Delay init slightly to ensure ensureTop runs first
  setTimeout(() => {
    initContinuousLearning();
  }, 50);
});
