import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
// CSS loaded via CDN in react.html.erb (Tailwind + Bootstrap)

// Initialize React app
document.addEventListener('DOMContentLoaded', () => {
  const rootElement = document.getElementById('react-learning-root');

  if (!rootElement) {
    console.error('React learning root element not found!');
    return;
  }

  // Get track from data attribute (docker or kubernetes)
  const track = (rootElement.getAttribute('data-track') as 'docker' | 'kubernetes') || 'docker';

  // Create React root and render
  const root = createRoot(rootElement);
  root.render(
    <React.StrictMode>
      <App track={track} />
    </React.StrictMode>
  );

  console.log(`✅ React Learning App initialized for track: ${track}`);
});
