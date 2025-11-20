import React, { useEffect, useRef, useState } from 'react';
import { Terminal as XTerminal } from 'xterm';
import { FitAddon } from 'xterm-addon-fit';
import { WebLinksAddon } from 'xterm-addon-web-links';
import 'xterm/css/xterm.css';
import { learningApi } from '../services/api';

interface TerminalProps {
  onCommandValidated?: (command: string, isCorrect: boolean, feedback: string) => void;
  currentCommand?: string;
  lessonId?: string;
  disabled?: boolean;
}

export default function Terminal({
  onCommandValidated,
  currentCommand,
  lessonId,
  disabled = false
}: TerminalProps) {
  const terminalRef = useRef<HTMLDivElement>(null);
  const xtermRef = useRef<XTerminal | null>(null);
  const fitAddonRef = useRef<FitAddon | null>(null);
  const [commandBuffer, setCommandBuffer] = useState('');
  const [commandHistory, setCommandHistory] = useState<string[]>([]);
  const [historyIndex, setHistoryIndex] = useState(-1);

  useEffect(() => {
    if (!terminalRef.current) return;

    // Initialize xterm.js
    const term = new XTerminal({
      cursorBlink: true,
      fontSize: 14,
      fontFamily: 'Menlo, Monaco, "Courier New", monospace',
      theme: {
        background: '#1e1e1e',
        foreground: '#d4d4d4',
        cursor: '#ffffff',
        black: '#000000',
        red: '#cd3131',
        green: '#0dbc79',
        yellow: '#e5e510',
        blue: '#2472c8',
        magenta: '#bc3fbc',
        cyan: '#11a8cd',
        white: '#e5e5e5',
        brightBlack: '#666666',
        brightRed: '#f14c4c',
        brightGreen: '#23d18b',
        brightYellow: '#f5f543',
        brightBlue: '#3b8eea',
        brightMagenta: '#d670d6',
        brightCyan: '#29b8db',
        brightWhite: '#ffffff',
      },
      rows: 24,
      cols: 80,
    });

    const fitAddon = new FitAddon();
    const webLinksAddon = new WebLinksAddon();

    term.loadAddon(fitAddon);
    term.loadAddon(webLinksAddon);
    term.open(terminalRef.current);

    fitAddon.fit();
    xtermRef.current = term;
    fitAddonRef.current = fitAddon;

    // Welcome message
    term.writeln('\x1b[1;32m╔════════════════════════════════════════════════════════╗\x1b[0m');
    term.writeln('\x1b[1;32m║  Docker Learning Terminal - Interactive Practice       ║\x1b[0m');
    term.writeln('\x1b[1;32m╚════════════════════════════════════════════════════════╝\x1b[0m');
    term.writeln('');
    term.writeln('\x1b[1;36mType Docker commands and press Enter to practice!\x1b[0m');
    term.writeln('\x1b[90mTip: Use ↑/↓ arrows to navigate command history\x1b[0m');
    term.writeln('');
    term.write('$ ');

    // Handle keyboard input
    term.onData((data) => {
      if (disabled) return;

      const code = data.charCodeAt(0);

      // Enter key
      if (code === 13) {
        term.write('\r\n');
        handleCommandSubmit(commandBuffer.trim());
        setCommandBuffer('');
        return;
      }

      // Backspace
      if (code === 127) {
        if (commandBuffer.length > 0) {
          setCommandBuffer((prev) => prev.slice(0, -1));
          term.write('\b \b');
        }
        return;
      }

      // Arrow up (previous command)
      if (data === '\x1b[A') {
        if (historyIndex < commandHistory.length - 1) {
          const newIndex = historyIndex + 1;
          setHistoryIndex(newIndex);
          replaceCurrentLine(term, commandHistory[commandHistory.length - 1 - newIndex]);
        }
        return;
      }

      // Arrow down (next command)
      if (data === '\x1b[B') {
        if (historyIndex > 0) {
          const newIndex = historyIndex - 1;
          setHistoryIndex(newIndex);
          replaceCurrentLine(term, commandHistory[commandHistory.length - 1 - newIndex]);
        } else if (historyIndex === 0) {
          setHistoryIndex(-1);
          replaceCurrentLine(term, '');
        }
        return;
      }

      // Ctrl+C
      if (code === 3) {
        term.write('^C\r\n$ ');
        setCommandBuffer('');
        return;
      }

      // Ctrl+L (clear screen)
      if (code === 12) {
        term.clear();
        term.write('$ ');
        return;
      }

      // Regular character input
      if (code >= 32 && code <= 126) {
        setCommandBuffer((prev) => prev + data);
        term.write(data);
      }
    });

    // Handle window resize
    const handleResize = () => {
      fitAddon.fit();
    };

    window.addEventListener('resize', handleResize);

    return () => {
      window.removeEventListener('resize', handleResize);
      term.dispose();
    };
  }, [disabled]);

  const replaceCurrentLine = (term: XTerminal, text: string) => {
    // Clear current line
    term.write('\r\x1b[K$ ');
    term.write(text);
    setCommandBuffer(text);
  };

  const handleCommandSubmit = async (command: string) => {
    if (!command || !xtermRef.current) return;

    const term = xtermRef.current;

    // Add to history
    if (command.trim()) {
      setCommandHistory((prev) => [...prev, command]);
      setHistoryIndex(-1);
    }

    // Validate command with API
    try {
      const response = await learningApi.validateCommand(command, {
        currentLessonId: lessonId,
        expectedCommand: currentCommand,
      });

      if (response.success && response.data) {
        const { isCorrect, feedback, output } = response.data;

        if (isCorrect) {
          // Success feedback
          term.writeln('\x1b[1;32m✓ Correct!\x1b[0m ' + (feedback || 'Command validated successfully!'));
          if (output) {
            term.writeln('\x1b[90m' + output + '\x1b[0m');
          }
        } else {
          // Error feedback
          term.writeln('\x1b[1;31m✗ Not quite right.\x1b[0m ' + (feedback || 'Try again!'));
          if (output) {
            term.writeln('\x1b[90m' + output + '\x1b[0m');
          }
        }

        // Callback to parent component
        if (onCommandValidated) {
          onCommandValidated(command, isCorrect, feedback || '');
        }
      } else {
        term.writeln('\x1b[1;33m⚠ Unable to validate command. Please try again.\x1b[0m');
      }
    } catch (error) {
      term.writeln('\x1b[1;31m✗ Error: Unable to connect to server\x1b[0m');
      console.error('Terminal command validation error:', error);
    }

    term.write('\r\n$ ');
  };

  return (
    <div className="terminal-container h-full bg-gray-900 rounded-lg overflow-hidden border border-gray-700">
      <div className="terminal-header bg-gray-800 px-4 py-2 flex items-center gap-2 border-b border-gray-700">
        <div className="flex gap-2">
          <div className="w-3 h-3 rounded-full bg-red-500"></div>
          <div className="w-3 h-3 rounded-full bg-yellow-500"></div>
          <div className="w-3 h-3 rounded-full bg-green-500"></div>
        </div>
        <span className="text-sm text-gray-400 ml-2">Docker Terminal</span>
      </div>
      <div
        ref={terminalRef}
        className="terminal-body p-2"
        style={{ height: 'calc(100% - 42px)' }}
      />
    </div>
  );
}
