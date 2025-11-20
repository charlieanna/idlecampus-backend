import React, { useState } from 'react';

export function Accordion({ type, defaultValue, collapsible, children, className = '' }) {
  const [openValue, setOpenValue] = useState(defaultValue || '');

  const toggleItem = (value) => {
    if (type === 'single') {
      if (collapsible) {
        setOpenValue(openValue === value ? '' : value);
      } else {
        setOpenValue(value);
      }
    }
  };

  return (
    <div className={className}>
      {React.Children.map(children, (child) =>
        React.cloneElement(child, {
          isOpen: openValue === child.props.value,
          onToggle: () => toggleItem(child.props.value),
        })
      )}
    </div>
  );
}

export function AccordionItem({ value, isOpen, onToggle, children, className = '' }) {
  return (
    <div className={className}>
      {React.Children.map(children, (child) =>
        React.cloneElement(child, { isOpen, onToggle })
      )}
    </div>
  );
}

export function AccordionTrigger({ isOpen, onToggle, children, className = '' }) {
  return (
    <button
      onClick={onToggle}
      className={`w-full text-left py-4 flex items-center justify-between ${className}`}
    >
      {children}
      <svg
        className={`w-5 h-5 transition-transform ${isOpen ? 'transform rotate-180' : ''}`}
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
      >
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
      </svg>
    </button>
  );
}

export function AccordionContent({ isOpen, children, className = '' }) {
  return (
    <div
      className={`overflow-hidden transition-all ${
        isOpen ? 'max-h-[2000px] opacity-100' : 'max-h-0 opacity-0'
      } ${className}`}
    >
      {children}
    </div>
  );
}
