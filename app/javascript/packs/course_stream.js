import React from 'react';
import { createRoot } from 'react-dom/client';
import InteractiveLearningFlow from '../components/InteractiveLearningFlow';

let root = null;

const mountComponent = () => {
  console.log('Attempting to mount InteractiveLearningFlow component...');
  const container = document.getElementById('interactive-learning-container');
  if (container) {
    console.log('Container found:', container);
    try {
      const props = JSON.parse(container.dataset.props);
      console.log('Props parsed:', props);
      
      // Use React 18's createRoot API
      if (!root) {
        root = createRoot(container);
      }
      root.render(<InteractiveLearningFlow {...props} />);
      console.log('Component mounted successfully');
    } catch (error) {
      console.error('Error mounting component:', error);
    }
  } else {
    console.log('Container not found');
  }
};

// Support both regular page loads and Turbolinks navigation
document.addEventListener('DOMContentLoaded', mountComponent);
document.addEventListener('turbolinks:load', mountComponent);
