import React from 'react';
import { createRoot } from 'react-dom/client';
import DockerLearn from '../components/DockerLearn';
import '../stylesheets/tailwind.css';

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('docker-learn-root');
  if (container) {
    const root = createRoot(container);
    root.render(<DockerLearn />);
  }
});
