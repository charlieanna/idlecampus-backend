/**
 * Resizable Panels using Split.js
 * Progressive enhancement for content/terminal layout
 */

document.addEventListener('DOMContentLoaded', function() {
  // Only initialize if we have the split panels
  const contentPanel = document.getElementById('content-panel');
  const terminalPanel = document.getElementById('terminal-panel');

  if (!contentPanel || !terminalPanel || typeof Split === 'undefined') {
    console.log('Split panels not found or Split.js not loaded');
    return;
  }

  // Initialize Split.js
  const split = Split(['#content-panel', '#terminal-panel'], {
    sizes: getSavedSizes() || [60, 40],
    minSize: [300, 250],
    gutterSize: 8,
    cursor: 'col-resize',
    direction: 'horizontal',

    // Save sizes to localStorage on drag
    onDragEnd: function(sizes) {
      localStorage.setItem('splitPanelSizes', JSON.stringify(sizes));
    },

    // Custom gutter styling
    gutter: function(index, direction) {
      const gutter = document.createElement('div');
      gutter.className = `gutter gutter-${direction}`;

      // Add grip indicator
      const grip = document.createElement('div');
      grip.className = 'gutter-grip';
      grip.innerHTML = `
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="5" r="1" />
          <circle cx="12" cy="12" r="1" />
          <circle cx="12" cy="19" r="1" />
        </svg>
      `;
      gutter.appendChild(grip);

      return gutter;
    }
  });

  // Helper function to get saved sizes from localStorage
  function getSavedSizes() {
    try {
      const saved = localStorage.getItem('splitPanelSizes');
      return saved ? JSON.parse(saved) : null;
    } catch (e) {
      console.error('Error reading saved panel sizes:', e);
      return null;
    }
  }

  // Add resize event listener to adjust terminal on window resize
  let resizeTimeout;
  window.addEventListener('resize', function() {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(function() {
      // Trigger terminal resize if it exists
      const terminalElement = document.querySelector('.xterm');
      if (terminalElement && terminalElement.terminal) {
        terminalElement.terminal.fit();
      }
    }, 250);
  });

  console.log('Resizable panels initialized');
});
