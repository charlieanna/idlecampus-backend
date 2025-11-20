import React from 'react';

const SimpleMarkdown = ({ content }) => {
  if (!content) return null;

  // Simple markdown parser for basic formatting
  const parseMarkdown = (text) => {
    const lines = text.split('\n');
    const elements = [];
    let currentParagraph = [];
    let inCodeBlock = false;
    let codeLines = [];
    let codeLanguage = '';

    lines.forEach((line, index) => {
      // Code blocks
      if (line.startsWith('```')) {
        if (!inCodeBlock) {
          // Start code block
          if (currentParagraph.length > 0) {
            elements.push({ type: 'p', content: currentParagraph.join(' '), key: `p-${index}` });
            currentParagraph = [];
          }
          inCodeBlock = true;
          codeLanguage = line.slice(3).trim();
          codeLines = [];
        } else {
          // End code block
          elements.push({ type: 'code', content: codeLines.join('\n'), language: codeLanguage, key: `code-${index}` });
          inCodeBlock = false;
          codeLines = [];
        }
        return;
      }

      if (inCodeBlock) {
        codeLines.push(line);
        return;
      }

      // Headers
      if (line.startsWith('# ')) {
        if (currentParagraph.length > 0) {
          elements.push({ type: 'p', content: currentParagraph.join(' '), key: `p-${index}` });
          currentParagraph = [];
        }
        elements.push({ type: 'h1', content: line.slice(2), key: `h1-${index}` });
      } else if (line.startsWith('## ')) {
        if (currentParagraph.length > 0) {
          elements.push({ type: 'p', content: currentParagraph.join(' '), key: `p-${index}` });
          currentParagraph = [];
        }
        elements.push({ type: 'h2', content: line.slice(3), key: `h2-${index}` });
      } else if (line.startsWith('### ')) {
        if (currentParagraph.length > 0) {
          elements.push({ type: 'p', content: currentParagraph.join(' '), key: `p-${index}` });
          currentParagraph = [];
        }
        elements.push({ type: 'h3', content: line.slice(4), key: `h3-${index}` });
      }
      // List items
      else if (line.match(/^[\d]+\.\s/)) {
        if (currentParagraph.length > 0) {
          elements.push({ type: 'p', content: currentParagraph.join(' '), key: `p-${index}` });
          currentParagraph = [];
        }
        elements.push({ type: 'li', content: line.replace(/^[\d]+\.\s/, ''), key: `li-${index}` });
      }
      // Empty line - end paragraph
      else if (line.trim() === '') {
        if (currentParagraph.length > 0) {
          elements.push({ type: 'p', content: currentParagraph.join(' '), key: `p-${index}` });
          currentParagraph = [];
        }
      }
      // Regular text - add to current paragraph
      else {
        currentParagraph.push(line);
      }
    });

    // Add final paragraph if exists
    if (currentParagraph.length > 0) {
      elements.push({ type: 'p', content: currentParagraph.join(' '), key: `p-end` });
    }

    return elements;
  };

  const formatInlineMarkdown = (text) => {
    // Bold **text**
    text = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
    // Italic *text*
    text = text.replace(/\*(.*?)\*/g, '<em>$1</em>');
    // Inline code `text`
    text = text.replace(/`([^`]+)`/g, '<code class="bg-gray-200 px-1.5 py-0.5 rounded text-sm font-mono text-gray-800">$1</code>');
    return text;
  };

  const elements = parseMarkdown(content);

  return (
    <div className="space-y-4">
      {elements.map((element) => {
        const formattedContent = formatInlineMarkdown(element.content);
        
        switch (element.type) {
          case 'h1':
            return (
              <h1 key={element.key} className="text-3xl font-bold text-gray-900 mb-4 mt-6">
                <span dangerouslySetInnerHTML={{ __html: formattedContent }} />
              </h1>
            );
          case 'h2':
            return (
              <h2 key={element.key} className="text-2xl font-semibold text-gray-800 mb-3 mt-5">
                <span dangerouslySetInnerHTML={{ __html: formattedContent }} />
              </h2>
            );
          case 'h3':
            return (
              <h3 key={element.key} className="text-xl font-semibold text-gray-800 mb-2 mt-4">
                <span dangerouslySetInnerHTML={{ __html: formattedContent }} />
              </h3>
            );
          case 'p':
            return (
              <p key={element.key} className="text-gray-700 leading-relaxed text-lg">
                <span dangerouslySetInnerHTML={{ __html: formattedContent }} />
              </p>
            );
          case 'li':
            return (
              <li key={element.key} className="ml-6 text-gray-700 leading-relaxed list-decimal">
                <span dangerouslySetInnerHTML={{ __html: formattedContent }} />
              </li>
            );
          case 'code':
            return (
              <pre key={element.key} className="bg-gray-900 text-gray-100 p-4 rounded-lg overflow-x-auto my-4">
                <code className="text-sm">{element.content}</code>
              </pre>
            );
          default:
            return null;
        }
      })}
    </div>
  );
};

export default SimpleMarkdown;


