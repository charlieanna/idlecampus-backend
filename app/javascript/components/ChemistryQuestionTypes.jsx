import React, { useState } from 'react';
import { CheckCircleIcon, XCircleIcon, BeakerIcon } from '@heroicons/react/24/solid';
import { DndContext, closestCenter, KeyboardSensor, PointerSensor, useSensor, useSensors } from '@dnd-kit/core';
import { arrayMove, SortableContext, sortableKeyboardCoordinates, verticalListSortingStrategy, useSortable } from '@dnd-kit/sortable';
import { CSS } from '@dnd-kit/utilities';

// Numerical Question Component
export const NumericalQuestion = ({ question, onAnswer, disabled, showResult, isCorrect }) => {
  const [answer, setAnswer] = useState('');

  const handleSubmit = () => {
    if (answer.trim() && onAnswer) {
      onAnswer(answer.trim());
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-start space-x-3">
        <BeakerIcon className="h-6 w-6 text-blue-600 flex-shrink-0 mt-1" />
        <div className="flex-1">
          <p className="text-lg text-gray-900">{question.question_text}</p>
          {question.image_url && (
            <img src={question.image_url} alt="Question diagram" className="mt-4 max-w-md rounded-lg border" />
          )}
        </div>
      </div>

      <div className="flex items-center space-x-3">
        <input
          type="number"
          step="any"
          value={answer}
          onChange={(e) => setAnswer(e.target.value)}
          onKeyPress={(e) => e.key === 'Enter' && handleSubmit()}
          disabled={disabled}
          placeholder="Enter your numerical answer..."
          className={`flex-1 px-4 py-3 text-lg font-mono border-2 rounded-lg focus:outline-none focus:ring-2 ${
            showResult
              ? isCorrect
                ? 'border-green-500 bg-green-50'
                : 'border-red-500 bg-red-50'
              : 'border-gray-300 focus:border-blue-500 focus:ring-blue-200'
          }`}
        />
        {!disabled && (
          <button
            onClick={handleSubmit}
            disabled={!answer.trim()}
            className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed font-semibold"
          >
            Submit
          </button>
        )}
      </div>

      {question.tolerance > 0 && !showResult && (
        <p className="text-sm text-gray-600">
          Tolerance: ±{question.tolerance}
        </p>
      )}
    </div>
  );
};

// Equation Balance Question Component
export const EquationBalanceQuestion = ({ question, onAnswer, disabled, showResult, isCorrect }) => {
  const [equation, setEquation] = useState('');

  const handleSubmit = () => {
    if (equation.trim() && onAnswer) {
      onAnswer(equation.trim());
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-start space-x-3">
        <BeakerIcon className="h-6 w-6 text-purple-600 flex-shrink-0 mt-1" />
        <div className="flex-1">
          <p className="text-lg text-gray-900">{question.question_text}</p>
          {question.image_url && (
            <img src={question.image_url} alt="Chemical equation" className="mt-4 max-w-md rounded-lg border" />
          )}
        </div>
      </div>

      <div className="space-y-2">
        <textarea
          value={equation}
          onChange={(e) => setEquation(e.target.value)}
          disabled={disabled}
          rows={3}
          placeholder="Enter the balanced equation (e.g., 2 H2 + O2 -> 2 H2O)..."
          className={`w-full px-4 py-3 text-lg font-mono border-2 rounded-lg focus:outline-none focus:ring-2 ${
            showResult
              ? isCorrect
                ? 'border-green-500 bg-green-50'
                : 'border-red-500 bg-red-50'
              : 'border-gray-300 focus:border-purple-500 focus:ring-purple-200'
          }`}
        />

        {!disabled && (
          <button
            onClick={handleSubmit}
            disabled={!equation.trim()}
            className="w-full px-6 py-3 bg-purple-600 text-white rounded-lg hover:bg-purple-700 disabled:opacity-50 disabled:cursor-not-allowed font-semibold"
          >
            Submit Balanced Equation
          </button>
        )}
      </div>

      <div className="text-sm text-gray-600 bg-gray-50 p-3 rounded">
        <p className="font-semibold mb-1">Tips:</p>
        <ul className="list-disc list-inside space-y-1">
          <li>Use -> or => for the arrow</li>
          <li>Example: 4 Fe + 3 O2 -&gt; 2 Fe2O3</li>
          <li>Make sure atoms balance on both sides!</li>
        </ul>
      </div>
    </div>
  );
};

// Sortable Item for Sequence Questions
const SortableItem = ({ id, text }) => {
  const { attributes, listeners, setNodeRef, transform, transition, isDragging } = useSortable({ id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
    opacity: isDragging ? 0.5 : 1,
  };

  return (
    <div
      ref={setNodeRef}
      style={style}
      {...attributes}
      {...listeners}
      className="flex items-center space-x-3 p-4 bg-white border-2 border-gray-300 rounded-lg cursor-move hover:border-indigo-400 hover:shadow-md transition"
    >
      <div className="flex-shrink-0">
        <svg className="h-6 w-6 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 8h16M4 16h16" />
        </svg>
      </div>
      <span className="flex-1 text-gray-900">{text}</span>
    </div>
  );
};

// Sequence Question Component
export const SequenceQuestion = ({ question, onAnswer, disabled, showResult, isCorrect }) => {
  const [items, setItems] = useState(question.sequence_items || []);

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor, { coordinateGetter: sortableKeyboardCoordinates })
  );

  const handleDragEnd = (event) => {
    const { active, over } = event;

    if (active.id !== over.id) {
      setItems((items) => {
        const oldIndex = items.findIndex((item) => item.id === active.id);
        const newIndex = items.findIndex((item) => item.id === over.id);
        return arrayMove(items, oldIndex, newIndex);
      });
    }
  };

  const handleSubmit = () => {
    if (onAnswer) {
      const sequence = items.map((item) => item.id).join(',');
      onAnswer(sequence);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-start space-x-3">
        <svg className="h-6 w-6 text-indigo-600 flex-shrink-0 mt-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4" />
        </svg>
        <div className="flex-1">
          <p className="text-lg text-gray-900">{question.question_text}</p>
          {question.image_url && (
            <img src={question.image_url} alt="Sequence diagram" className="mt-4 max-w-md rounded-lg border" />
          )}
        </div>
      </div>

      <div className={`p-4 rounded-lg ${showResult ? (isCorrect ? 'bg-green-50' : 'bg-red-50') : 'bg-indigo-50'}`}>
        <p className="text-sm font-semibold text-indigo-900 mb-3">
          {disabled ? 'Your answer:' : 'Drag to reorder the steps:'}
        </p>

        <DndContext sensors={sensors} collisionDetection={closestCenter} onDragEnd={handleDragEnd}>
          <SortableContext items={items.map((item) => item.id)} strategy={verticalListSortingStrategy} disabled={disabled}>
            <div className="space-y-2">
              {items.map((item) => (
                <SortableItem key={item.id} id={item.id} text={item.text} />
              ))}
            </div>
          </SortableContext>
        </DndContext>
      </div>

      {!disabled && (
        <button
          onClick={handleSubmit}
          className="w-full px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 font-semibold"
        >
          Submit Order
        </button>
      )}
    </div>
  );
};

// Multi-Correct MCQ Component
export const MultiCorrectMCQ = ({ question, onAnswer, disabled, showResult, isCorrect }) => {
  const [selectedOptions, setSelectedOptions] = useState([]);

  const toggleOption = (index) => {
    if (disabled) return;

    setSelectedOptions((prev) =>
      prev.includes(index) ? prev.filter((i) => i !== index) : [...prev, index]
    );
  };

  const handleSubmit = () => {
    if (onAnswer && selectedOptions.length > 0) {
      onAnswer(selectedOptions.sort());
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-start space-x-3">
        <CheckCircleIcon className="h-6 w-6 text-amber-600 flex-shrink-0 mt-1" />
        <div className="flex-1">
          <p className="text-lg text-gray-900">{question.question_text}</p>
          {question.image_url && (
            <img src={question.image_url} alt="Question diagram" className="mt-4 max-w-md rounded-lg border" />
          )}
          <p className="text-sm text-amber-600 font-semibold mt-2">Select ALL correct options</p>
        </div>
      </div>

      <div className="space-y-2">
        {question.options?.map((option, index) => {
          const isSelected = selectedOptions.includes(index);
          const showCorrect = showResult && option.correct;
          const showWrong = showResult && isSelected && !option.correct;

          return (
            <button
              key={index}
              onClick={() => toggleOption(index)}
              disabled={disabled}
              className={`w-full text-left p-4 rounded-lg border-2 transition ${
                showCorrect
                  ? 'border-green-500 bg-green-50'
                  : showWrong
                  ? 'border-red-500 bg-red-50'
                  : isSelected
                  ? 'border-amber-500 bg-amber-50'
                  : 'border-gray-200 hover:border-amber-300 bg-white'
              } ${disabled ? 'cursor-default' : 'cursor-pointer'}`}
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center space-x-3 flex-1">
                  <div className={`w-5 h-5 border-2 rounded flex items-center justify-center ${
                    isSelected ? 'border-amber-500 bg-amber-500' : 'border-gray-300'
                  }`}>
                    {isSelected && <CheckCircleIcon className="h-4 w-4 text-white" />}
                  </div>
                  <span className={`${
                    showCorrect ? 'text-green-900' : showWrong ? 'text-red-900' : 'text-gray-900'
                  }`}>
                    {option.text}
                  </span>
                </div>
                {showCorrect && <CheckCircleIcon className="h-6 w-6 text-green-500 flex-shrink-0" />}
                {showWrong && <XCircleIcon className="h-6 w-6 text-red-500 flex-shrink-0" />}
              </div>
            </button>
          );
        })}
      </div>

      {!disabled && (
        <button
          onClick={handleSubmit}
          disabled={selectedOptions.length === 0}
          className="w-full px-6 py-3 bg-amber-600 text-white rounded-lg hover:bg-amber-700 disabled:opacity-50 disabled:cursor-not-allowed font-semibold"
        >
          Submit ({selectedOptions.length} selected)
        </button>
      )}
    </div>
  );
};

export default {
  NumericalQuestion,
  EquationBalanceQuestion,
  SequenceQuestion,
  MultiCorrectMCQ,
};
