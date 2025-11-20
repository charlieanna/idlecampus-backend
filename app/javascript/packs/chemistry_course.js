import React from 'react';
import ReactDOM from 'react-dom/client';
import ChemistryCourseViewer from '../components/ChemistryCourseViewer';

document.addEventListener('DOMContentLoaded', () => {
  const mountPoint = document.getElementById('chemistry-course-root');

  if (mountPoint) {
    const courseSlug = mountPoint.dataset.courseSlug || 'iit-jee-inorganic-chemistry';

    const root = ReactDOM.createRoot(mountPoint);
    root.render(<ChemistryCourseViewer courseSlug={courseSlug} />);
  }
});
