import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
import DSAApp from './DSAApp';
// CSS loaded via CDN in react.html.erb (Tailwind + Bootstrap)

// Initialize React app
document.addEventListener('DOMContentLoaded', () => {
  // Check for DSA-specific root element first
  const dsaRootElement = document.getElementById('dsa-learning-root');
  if (dsaRootElement) {
    const courseSlug = dsaRootElement.getAttribute('data-course-slug') || 'data-structures-algorithms';
    const root = createRoot(dsaRootElement);
    root.render(
      <React.StrictMode>
        <DSAApp courseSlug={courseSlug} />
      </React.StrictMode>
    );
    console.log(`✅ DSA Learning App initialized for course: ${courseSlug}`);
    return;
  }

  // Fall back to generic learning root
  const rootElement = document.getElementById('react-learning-root');

  if (!rootElement) {
    console.error('React learning root element not found!');
    return;
  }

  // Get track from data attribute (docker, kubernetes, or dsa)
  const track = rootElement.getAttribute('data-track') as 'docker' | 'kubernetes' | 'dsa';

  // If track is DSA, use the DSA app
  if (track === 'dsa') {
    const root = createRoot(rootElement);
    root.render(
      <React.StrictMode>
        <DSAApp />
      </React.StrictMode>
    );
    console.log(`✅ DSA Learning App initialized`);
    return;
  }

  // Create React root and render for Docker/Kubernetes
  const root = createRoot(rootElement);
  root.render(
    <React.StrictMode>
      <App track={track || 'docker'} />
    </React.StrictMode>
  );

  console.log(`✅ React Learning App initialized for track: ${track}`);
});

// Export components for use in other contexts
export { default as App } from './App';
export { default as DSAApp } from './DSAApp';
export { default as DSASidebar } from './components/DSASidebar';
export * from './types';
