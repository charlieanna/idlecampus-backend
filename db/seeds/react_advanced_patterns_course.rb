# React Advanced Patterns Course
puts "Creating React Advanced Patterns Course..."

react_course = Course.find_or_create_by!(slug: 'react-advanced-patterns') do |course|
  course.title = 'React Advanced Patterns'
  course.description = 'Master advanced React patterns, hooks, performance optimization, and architecture'
  course.difficulty_level = 'advanced'
  course.published = true
  course.sequence_order = 35
  course.estimated_hours = 30
  course.learning_objectives = JSON.generate([
    "Master custom hooks and hook composition",
    "Implement advanced patterns (HOC, Render Props, Compound Components)",
    "Optimize React performance with memoization and code splitting",
    "Use Context API effectively and avoid common pitfalls",
    "Build scalable React applications with proper architecture",
    "Apply state management patterns for complex state"
  ])
  course.prerequisites = JSON.generate(["React fundamentals", "JavaScript ES6+", "Component lifecycle understanding"])
end

puts "Created course: #{react_course.title}"

# ==========================================
# MODULE 1: Advanced Hooks & Patterns
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'react-hooks-advanced', course: react_course) do |mod|
  mod.title = 'Advanced Hooks & Patterns'
  mod.description = 'Custom hooks, composition, useReducer, Context optimization'
  mod.sequence_order = 1
  mod.estimated_minutes = 130
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Create reusable custom hooks",
    "Master hook composition patterns",
    "Use useReducer for complex state management",
    "Optimize Context API usage"
  ])
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Custom Hooks and Advanced Patterns") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Custom Hooks and Advanced Patterns

    **Custom hooks** let you extract component logic into reusable functions, enabling powerful composition patterns.

    ## Why Custom Hooks?

    **Problems custom hooks solve:**
    - Code duplication across components
    - Complex component logic
    - Sharing stateful logic
    - Abstracting imperative code

    ```jsx
    // Without custom hook - duplicated logic
    function UserProfile() {
      const [user, setUser] = useState(null);
      const [loading, setLoading] = useState(true);
      const [error, setError] = useState(null);

      useEffect(() => {
        fetch('/api/user')
          .then(res => res.json())
          .then(setUser)
          .catch(setError)
          .finally(() => setLoading(false));
      }, []);

      // Component logic...
    }

    function PostList() {
      const [posts, setPosts] = useState(null);
      const [loading, setLoading] = useState(true);
      const [error, setError] = useState(null);

      useEffect(() => {
        fetch('/api/posts')
          .then(res => res.json())
          .then(setPosts)
          .catch(setError)
          .finally(() => setLoading(false));
      }, []);

      // Same pattern repeated!
    }
    ```

    ## Custom Hook: useFetch

    **Extract data fetching logic into a reusable hook**

    ```jsx
    // hooks/useFetch.js
    import { useState, useEffect } from 'react';

    function useFetch(url, options = {}) {
      const [data, setData] = useState(null);
      const [loading, setLoading] = useState(true);
      const [error, setError] = useState(null);

      useEffect(() => {
        let cancelled = false;

        const fetchData = async () => {
          try {
            setLoading(true);
            const response = await fetch(url, options);

            if (!response.ok) {
              throw new Error(\`HTTP error! status: \${response.status}\`);
            }

            const json = await response.json();

            if (!cancelled) {
              setData(json);
              setError(null);
            }
          } catch (err) {
            if (!cancelled) {
              setError(err.message);
              setData(null);
            }
          } finally {
            if (!cancelled) {
              setLoading(false);
            }
          }
        };

        fetchData();

        // Cleanup function to prevent state updates on unmounted component
        return () => {
          cancelled = true;
        };
      }, [url, JSON.stringify(options)]); // Re-fetch when URL or options change

      return { data, loading, error };
    }

    // Usage
    function UserProfile() {
      const { data: user, loading, error } = useFetch('/api/user');

      if (loading) return <div>Loading...</div>;
      if (error) return <div>Error: {error}</div>;
      return <div>Hello, {user.name}!</div>;
    }

    function PostList() {
      const { data: posts, loading, error } = useFetch('/api/posts');

      if (loading) return <div>Loading...</div>;
      if (error) return <div>Error: {error}</div>;
      return (
        <ul>
          {posts.map(post => (
            <li key={post.id}>{post.title}</li>
          ))}
        </ul>
      );
    }
    ```

    ## Custom Hook: useLocalStorage

    **Sync state with localStorage**

    ```jsx
    // hooks/useLocalStorage.js
    import { useState, useEffect } from 'react';

    function useLocalStorage(key, initialValue) {
      // Initialize state with value from localStorage or initialValue
      const [storedValue, setStoredValue] = useState(() => {
        try {
          const item = window.localStorage.getItem(key);
          return item ? JSON.parse(item) : initialValue;
        } catch (error) {
          console.error(\`Error reading localStorage key "\${key}":\`, error);
          return initialValue;
        }
      });

      // Update localStorage when state changes
      const setValue = (value) => {
        try {
          // Allow value to be a function (same API as useState)
          const valueToStore = value instanceof Function ? value(storedValue) : value;

          setStoredValue(valueToStore);
          window.localStorage.setItem(key, JSON.stringify(valueToStore));
        } catch (error) {
          console.error(\`Error setting localStorage key "\${key}":\`, error);
        }
      };

      // Listen to storage events from other tabs/windows
      useEffect(() => {
        const handleStorageChange = (e) => {
          if (e.key === key && e.newValue !== null) {
            setStoredValue(JSON.parse(e.newValue));
          }
        };

        window.addEventListener('storage', handleStorageChange);
        return () => window.removeEventListener('storage', handleStorageChange);
      }, [key]);

      return [storedValue, setValue];
    }

    // Usage
    function ThemeToggle() {
      const [theme, setTheme] = useLocalStorage('theme', 'light');

      return (
        <button onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
          Current theme: {theme}
        </button>
      );
    }

    // Works across tabs - change theme in one tab, updates in all tabs!
    ```

    ## Custom Hook: useDebounce

    **Delay updating a value until user stops typing**

    ```jsx
    // hooks/useDebounce.js
    import { useState, useEffect } from 'react';

    function useDebounce(value, delay = 500) {
      const [debouncedValue, setDebouncedValue] = useState(value);

      useEffect(() => {
        // Set timeout to update debounced value
        const handler = setTimeout(() => {
          setDebouncedValue(value);
        }, delay);

        // Clear timeout if value changes before delay
        return () => {
          clearTimeout(handler);
        };
      }, [value, delay]);

      return debouncedValue;
    }

    // Usage: Search with debouncing
    function SearchUsers() {
      const [searchTerm, setSearchTerm] = useState('');
      const debouncedSearchTerm = useDebounce(searchTerm, 500);
      const { data: results, loading } = useFetch(
        debouncedSearchTerm
          ? \`/api/users?q=\${debouncedSearchTerm}\`
          : null
      );

      return (
        <div>
          <input
            type="text"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            placeholder="Search users..."
          />
          {loading && <div>Searching...</div>}
          {results && (
            <ul>
              {results.map(user => (
                <li key={user.id}>{user.name}</li>
              ))}
            </ul>
          )}
        </div>
      );
    }
    // Only fetches after user stops typing for 500ms!
    ```

    ## Custom Hook: useToggle

    **Simple boolean state toggle**

    ```jsx
    // hooks/useToggle.js
    import { useState, useCallback } from 'react';

    function useToggle(initialValue = false) {
      const [value, setValue] = useState(initialValue);

      const toggle = useCallback(() => {
        setValue(v => !v);
      }, []);

      const setTrue = useCallback(() => {
        setValue(true);
      }, []);

      const setFalse = useCallback(() => {
        setValue(false);
      }, []);

      return [value, { toggle, setTrue, setFalse }];
    }

    // Usage
    function Modal() {
      const [isOpen, { toggle, setTrue, setFalse }] = useToggle(false);

      return (
        <>
          <button onClick={setTrue}>Open Modal</button>
          {isOpen && (
            <div className="modal">
              <h2>Modal Content</h2>
              <button onClick={setFalse}>Close</button>
            </div>
          )}
        </>
      );
    }
    ```

    ## Hook Composition

    **Combine multiple hooks for complex functionality**

    ```jsx
    // hooks/useApi.js
    import { useState, useCallback } from 'react';

    // Composing useFetch with manual trigger
    function useApi(url, options = {}) {
      const [data, setData] = useState(null);
      const [loading, setLoading] = useState(false);
      const [error, setError] = useState(null);

      const execute = useCallback(async (additionalOptions = {}) => {
        try {
          setLoading(true);
          setError(null);

          const response = await fetch(url, { ...options, ...additionalOptions });

          if (!response.ok) {
            throw new Error(\`HTTP error! status: \${response.status}\`);
          }

          const json = await response.json();
          setData(json);
          return json;
        } catch (err) {
          setError(err.message);
          throw err;
        } finally {
          setLoading(false);
        }
      }, [url, JSON.stringify(options)]);

      return { data, loading, error, execute };
    }

    // Usage: Manual data submission
    function CreatePost() {
      const { data, loading, error, execute } = useApi('/api/posts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
      });

      const handleSubmit = async (e) => {
        e.preventDefault();
        const formData = new FormData(e.target);
        const post = Object.fromEntries(formData);

        try {
          await execute({ body: JSON.stringify(post) });
          alert('Post created!');
        } catch (err) {
          // Error already set in hook
        }
      };

      return (
        <form onSubmit={handleSubmit}>
          <input name="title" placeholder="Title" required />
          <textarea name="content" placeholder="Content" required />
          <button type="submit" disabled={loading}>
            {loading ? 'Creating...' : 'Create Post'}
          </button>
          {error && <div className="error">{error}</div>}
        </form>
      );
    }
    ```

    ## useReducer for Complex State

    **When state updates depend on previous state or have complex logic**

    ```jsx
    import { useReducer } from 'react';

    // State management for a shopping cart
    const initialState = {
      items: [],
      total: 0
    };

    function cartReducer(state, action) {
      switch (action.type) {
        case 'ADD_ITEM': {
          const existingItem = state.items.find(item => item.id === action.payload.id);

          if (existingItem) {
            // Increase quantity
            return {
              ...state,
              items: state.items.map(item =>
                item.id === action.payload.id
                  ? { ...item, quantity: item.quantity + 1 }
                  : item
              ),
              total: state.total + action.payload.price
            };
          } else {
            // Add new item
            return {
              ...state,
              items: [...state.items, { ...action.payload, quantity: 1 }],
              total: state.total + action.payload.price
            };
          }
        }

        case 'REMOVE_ITEM': {
          const item = state.items.find(item => item.id === action.payload);
          return {
            ...state,
            items: state.items.filter(item => item.id !== action.payload),
            total: state.total - (item.price * item.quantity)
          };
        }

        case 'UPDATE_QUANTITY': {
          const item = state.items.find(item => item.id === action.payload.id);
          const oldQuantity = item.quantity;
          const newQuantity = action.payload.quantity;
          const quantityDiff = newQuantity - oldQuantity;

          return {
            ...state,
            items: state.items.map(item =>
              item.id === action.payload.id
                ? { ...item, quantity: newQuantity }
                : item
            ),
            total: state.total + (item.price * quantityDiff)
          };
        }

        case 'CLEAR_CART':
          return initialState;

        default:
          throw new Error(\`Unknown action: \${action.type}\`);
      }
    }

    function ShoppingCart() {
      const [state, dispatch] = useReducer(cartReducer, initialState);

      const addItem = (product) => {
        dispatch({ type: 'ADD_ITEM', payload: product });
      };

      const removeItem = (productId) => {
        dispatch({ type: 'REMOVE_ITEM', payload: productId });
      };

      const updateQuantity = (productId, quantity) => {
        dispatch({ type: 'UPDATE_QUANTITY', payload: { id: productId, quantity } });
      };

      const clearCart = () => {
        dispatch({ type: 'CLEAR_CART' });
      };

      return (
        <div>
          <h2>Shopping Cart</h2>
          {state.items.map(item => (
            <div key={item.id}>
              <span>{item.name}</span>
              <input
                type="number"
                value={item.quantity}
                onChange={(e) => updateQuantity(item.id, parseInt(e.target.value))}
                min="1"
              />
              <span>\${item.price * item.quantity}</span>
              <button onClick={() => removeItem(item.id)}>Remove</button>
            </div>
          ))}
          <div>Total: \${state.total.toFixed(2)}</div>
          <button onClick={clearCart}>Clear Cart</button>
        </div>
      );
    }
    ```

    ## Context API Optimization

    **Problem: Context re-renders all consumers when any value changes**

    ```jsx
    // ❌ Bad: Re-renders all consumers on any state change
    const AppContext = React.createContext();

    function AppProvider({ children }) {
      const [user, setUser] = useState(null);
      const [theme, setTheme] = useState('light');
      const [notifications, setNotifications] = useState([]);

      // All consumers re-render when ANY of these change!
      const value = { user, setUser, theme, setTheme, notifications, setNotifications };

      return <AppContext.Provider value={value}>{children}</AppContext.Provider>;
    }
    ```

    ### Solution 1: Split Contexts

    ```jsx
    // ✅ Good: Separate contexts for different concerns
    const UserContext = React.createContext();
    const ThemeContext = React.createContext();
    const NotificationContext = React.createContext();

    function AppProvider({ children }) {
      const [user, setUser] = useState(null);
      const [theme, setTheme] = useState('light');
      const [notifications, setNotifications] = useState([]);

      // Memoize values to prevent unnecessary re-renders
      const userValue = useMemo(() => ({ user, setUser }), [user]);
      const themeValue = useMemo(() => ({ theme, setTheme }), [theme]);
      const notificationValue = useMemo(
        () => ({ notifications, setNotifications }),
        [notifications]
      );

      return (
        <UserContext.Provider value={userValue}>
          <ThemeContext.Provider value={themeValue}>
            <NotificationContext.Provider value={notificationValue}>
              {children}
            </NotificationContext.Provider>
          </ThemeContext.Provider>
        </UserContext.Provider>
      );
    }

    // Components only subscribe to what they need
    function UserProfile() {
      const { user } = useContext(UserContext); // Only re-renders when user changes
      return <div>{user?.name}</div>;
    }

    function ThemeToggle() {
      const { theme, setTheme } = useContext(ThemeContext); // Only re-renders when theme changes
      return <button onClick={() => setTheme(t => t === 'light' ? 'dark' : 'light')}>{theme}</button>;
    }
    ```

    ### Solution 2: Use useReducer with Context

    ```jsx
    // Combine useReducer + Context for complex state
    const TodoContext = React.createContext();
    const TodoDispatchContext = React.createContext();

    function todoReducer(state, action) {
      switch (action.type) {
        case 'ADD_TODO':
          return [...state, { id: Date.now(), text: action.text, completed: false }];
        case 'TOGGLE_TODO':
          return state.map(todo =>
            todo.id === action.id ? { ...todo, completed: !todo.completed } : todo
          );
        case 'DELETE_TODO':
          return state.filter(todo => todo.id !== action.id);
        default:
          throw new Error(\`Unknown action: \${action.type}\`);
      }
    }

    function TodoProvider({ children }) {
      const [todos, dispatch] = useReducer(todoReducer, []);

      return (
        <TodoContext.Provider value={todos}>
          <TodoDispatchContext.Provider value={dispatch}>
            {children}
          </TodoDispatchContext.Provider>
        </TodoContext.Provider>
      );
    }

    // Separate hooks for state and dispatch
    function useTodos() {
      const context = useContext(TodoContext);
      if (context === undefined) {
        throw new Error('useTodos must be used within TodoProvider');
      }
      return context;
    }

    function useTodoDispatch() {
      const context = useContext(TodoDispatchContext);
      if (context === undefined) {
        throw new Error('useTodoDispatch must be used within TodoProvider');
      }
      return context;
    }

    // Components can subscribe to state or dispatch separately
    function TodoList() {
      const todos = useTodos(); // Re-renders when todos change
      return (
        <ul>
          {todos.map(todo => (
            <TodoItem key={todo.id} todo={todo} />
          ))}
        </ul>
      );
    }

    function TodoItem({ todo }) {
      const dispatch = useTodoDispatch(); // Never re-renders from context changes!

      return (
        <li>
          <input
            type="checkbox"
            checked={todo.completed}
            onChange={() => dispatch({ type: 'TOGGLE_TODO', id: todo.id })}
          />
          <span>{todo.text}</span>
          <button onClick={() => dispatch({ type: 'DELETE_TODO', id: todo.id })}>
            Delete
          </button>
        </li>
      );
    }
    ```

    ## Real-World Example: Form Management Hook

    ```jsx
    // hooks/useForm.js
    import { useState, useCallback } from 'react';

    function useForm(initialValues = {}, onSubmit) {
      const [values, setValues] = useState(initialValues);
      const [errors, setErrors] = useState({});
      const [touched, setTouched] = useState({});
      const [isSubmitting, setIsSubmitting] = useState(false);

      const handleChange = useCallback((e) => {
        const { name, value, type, checked } = e.target;
        setValues(prev => ({
          ...prev,
          [name]: type === 'checkbox' ? checked : value
        }));
      }, []);

      const handleBlur = useCallback((e) => {
        const { name } = e.target;
        setTouched(prev => ({ ...prev, [name]: true }));
      }, []);

      const validate = useCallback((values) => {
        const errors = {};
        // Add validation logic here
        if (!values.email) {
          errors.email = 'Email is required';
        } else if (!/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$/i.test(values.email)) {
          errors.email = 'Invalid email address';
        }
        return errors;
      }, []);

      const handleSubmit = useCallback(async (e) => {
        e.preventDefault();

        const validationErrors = validate(values);
        setErrors(validationErrors);

        if (Object.keys(validationErrors).length === 0) {
          setIsSubmitting(true);
          try {
            await onSubmit(values);
          } catch (error) {
            setErrors({ submit: error.message });
          } finally {
            setIsSubmitting(false);
          }
        }
      }, [values, validate, onSubmit]);

      const reset = useCallback(() => {
        setValues(initialValues);
        setErrors({});
        setTouched({});
        setIsSubmitting(false);
      }, [initialValues]);

      return {
        values,
        errors,
        touched,
        isSubmitting,
        handleChange,
        handleBlur,
        handleSubmit,
        reset
      };
    }

    // Usage
    function SignupForm() {
      const { values, errors, touched, isSubmitting, handleChange, handleBlur, handleSubmit } =
        useForm(
          { email: '', password: '', agreeToTerms: false },
          async (values) => {
            const response = await fetch('/api/signup', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(values)
            });
            if (!response.ok) throw new Error('Signup failed');
          }
        );

      return (
        <form onSubmit={handleSubmit}>
          <div>
            <input
              name="email"
              type="email"
              value={values.email}
              onChange={handleChange}
              onBlur={handleBlur}
              placeholder="Email"
            />
            {touched.email && errors.email && <span className="error">{errors.email}</span>}
          </div>

          <div>
            <input
              name="password"
              type="password"
              value={values.password}
              onChange={handleChange}
              onBlur={handleBlur}
              placeholder="Password"
            />
            {touched.password && errors.password && <span className="error">{errors.password}</span>}
          </div>

          <button type="submit" disabled={isSubmitting}>
            {isSubmitting ? 'Signing up...' : 'Sign Up'}
          </button>
        </form>
      );
    }
    ```

    ## Best Practices

    1. **Name custom hooks with "use" prefix** - Required by React linting rules
    2. **Keep hooks focused** - One responsibility per hook
    3. **Return arrays for simple hooks** - Like useState: `[value, setValue]`
    4. **Return objects for complex hooks** - Named properties are clearer
    5. **Memoize context values** - Prevent unnecessary re-renders
    6. **Split large contexts** - Separate concerns for better performance
    7. **Always cleanup effects** - Prevent memory leaks and stale updates

    **Next**: We'll explore performance optimization techniques in React.
  MARKDOWN
  lesson.key_concepts = ['custom hooks', 'useReducer', 'hook composition', 'Context optimization', 'useFetch', 'useDebounce', 'useLocalStorage']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

puts "  ✅ Created module: #{module1.title}"

# ==========================================
# MODULE 2: Performance Optimization
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'react-performance', course: react_course) do |mod|
  mod.title = 'Performance Optimization'
  mod.description = 'Memoization, code splitting, virtualization, profiling'
  mod.sequence_order = 2
  mod.estimated_minutes = 140
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Use React.memo and useMemo effectively",
    "Optimize callbacks with useCallback",
    "Implement code splitting with lazy() and Suspense",
    "Virtualize long lists for performance",
    "Profile and identify performance bottlenecks"
  ])
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "React Performance Optimization") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # React Performance Optimization

    React is fast by default, but as apps grow, performance optimization becomes critical. Learn when and how to optimize.

    ## Understanding Re-renders

    **React re-renders a component when:**
    1. State changes (useState, useReducer)
    2. Props change
    3. Parent component re-renders
    4. Context value changes

    ```jsx
    // Example: Why components re-render
    function Parent() {
      const [count, setCount] = useState(0);

      console.log('Parent render');

      return (
        <div>
          <button onClick={() => setCount(count + 1)}>Count: {count}</button>
          <ExpensiveChild />  {/* Re-renders even though props don't change! */}
        </div>
      );
    }

    function ExpensiveChild() {
      console.log('ExpensiveChild render');

      // Expensive calculation
      const result = Array.from({ length: 10000 }, (_, i) => i).reduce((a, b) => a + b, 0);

      return <div>Result: {result}</div>;
    }

    // Every click re-renders both Parent AND ExpensiveChild unnecessarily!
    ```

    ## React.memo

    **Prevent re-renders when props haven't changed**

    ```jsx
    import { memo } from 'react';

    // ✅ Memoized component - only re-renders if props change
    const ExpensiveChild = memo(function ExpensiveChild() {
      console.log('ExpensiveChild render');

      const result = Array.from({ length: 10000 }, (_, i) => i).reduce((a, b) => a + b, 0);

      return <div>Result: {result}</div>;
    });

    function Parent() {
      const [count, setCount] = useState(0);

      return (
        <div>
          <button onClick={() => setCount(count + 1)}>Count: {count}</button>
          <ExpensiveChild />  {/* Now only renders once! */}
        </div>
      );
    }
    ```

    ### React.memo with Props

    ```jsx
    // Component with props
    const UserCard = memo(function UserCard({ user, onEdit }) {
      console.log('UserCard render');

      return (
        <div className="user-card">
          <h3>{user.name}</h3>
          <p>{user.email}</p>
          <button onClick={() => onEdit(user.id)}>Edit</button>
        </div>
      );
    });

    // ❌ Problem: This still re-renders unnecessarily!
    function UserList() {
      const [users, setUsers] = useState([...]);
      const [count, setCount] = useState(0);

      const handleEdit = (userId) => {
        console.log('Edit user', userId);
      };

      return (
        <div>
          <button onClick={() => setCount(count + 1)}>Count: {count}</button>
          {users.map(user => (
            <UserCard
              key={user.id}
              user={user}
              onEdit={handleEdit}  {/* New function every render! */}
            />
          ))}
        </div>
      );
    }
    // handleEdit is a new function reference every render, so memo doesn't help!
    ```

    ## useCallback

    **Memoize function references**

    ```jsx
    import { useState, useCallback, memo } from 'react';

    const UserCard = memo(function UserCard({ user, onEdit }) {
      console.log('UserCard render');

      return (
        <div className="user-card">
          <h3>{user.name}</h3>
          <button onClick={() => onEdit(user.id)}>Edit</button>
        </div>
      );
    });

    function UserList() {
      const [users, setUsers] = useState([...]);
      const [count, setCount] = useState(0);

      // ✅ Memoized function - same reference across renders
      const handleEdit = useCallback((userId) => {
        console.log('Edit user', userId);
        // Edit logic...
      }, []); // Empty deps = never changes

      return (
        <div>
          <button onClick={() => setCount(count + 1)}>Count: {count}</button>
          {users.map(user => (
            <UserCard
              key={user.id}
              user={user}
              onEdit={handleEdit}  {/* Same reference every render! */}
            />
          ))}
        </div>
      );
    }
    // Now UserCard only re-renders when user prop changes!
    ```

    ### useCallback with Dependencies

    ```jsx
    function TodoList({ filter }) {
      const [todos, setTodos] = useState([...]);

      // ✅ Function recreated only when filter changes
      const handleToggle = useCallback((id) => {
        setTodos(prevTodos =>
          prevTodos.map(todo =>
            todo.id === id ? { ...todo, completed: !todo.completed } : todo
          )
        );
      }, []); // No dependencies needed (using functional update)

      // ✅ Function recreated when filter changes
      const filteredTodos = useMemo(() => {
        return todos.filter(todo => {
          if (filter === 'active') return !todo.completed;
          if (filter === 'completed') return todo.completed;
          return true;
        });
      }, [todos, filter]);

      return (
        <ul>
          {filteredTodos.map(todo => (
            <TodoItem key={todo.id} todo={todo} onToggle={handleToggle} />
          ))}
        </ul>
      );
    }
    ```

    ## useMemo

    **Memoize expensive calculations**

    ```jsx
    import { useMemo } from 'react';

    function ProductList({ products, sortBy }) {
      // ❌ Bad: Expensive calculation on every render
      const sortedProducts = products.sort((a, b) => {
        if (sortBy === 'price') return a.price - b.price;
        if (sortBy === 'name') return a.name.localeCompare(b.name);
        return 0;
      });

      return (
        <ul>
          {sortedProducts.map(product => (
            <li key={product.id}>{product.name} - \${product.price}</li>
          ))}
        </ul>
      );
    }

    // ✅ Good: Memoize expensive calculation
    function ProductList({ products, sortBy }) {
      const sortedProducts = useMemo(() => {
        console.log('Sorting products...');
        return [...products].sort((a, b) => {
          if (sortBy === 'price') return a.price - b.price;
          if (sortBy === 'name') return a.name.localeCompare(b.name);
          return 0;
        });
      }, [products, sortBy]); // Only re-sort when products or sortBy changes

      return (
        <ul>
          {sortedProducts.map(product => (
            <li key={product.id}>{product.name} - \${product.price}</li>
          ))}
        </ul>
      );
    }
    ```

    ### useMemo vs useCallback

    ```jsx
    // useMemo returns the memoized VALUE
    const expensiveValue = useMemo(() => computeExpensiveValue(a, b), [a, b]);

    // useCallback returns the memoized FUNCTION
    const memoizedCallback = useCallback(() => doSomething(a, b), [a, b]);

    // These are equivalent:
    const memoizedCallback = useCallback(() => doSomething(a, b), [a, b]);
    const memoizedCallback = useMemo(() => () => doSomething(a, b), [a, b]);
    ```

    ## Code Splitting with lazy() and Suspense

    **Load components only when needed**

    ```jsx
    import { lazy, Suspense } from 'react';

    // ❌ Bad: Import everything upfront
    import Dashboard from './Dashboard';
    import Profile from './Profile';
    import Settings from './Settings';

    // Bundle size: 500KB (all loaded immediately)

    // ✅ Good: Lazy load components
    const Dashboard = lazy(() => import('./Dashboard'));
    const Profile = lazy(() => import('./Profile'));
    const Settings = lazy(() => import('./Settings'));

    function App() {
      const [currentPage, setCurrentPage] = useState('dashboard');

      return (
        <div>
          <nav>
            <button onClick={() => setCurrentPage('dashboard')}>Dashboard</button>
            <button onClick={() => setCurrentPage('profile')}>Profile</button>
            <button onClick={() => setCurrentPage('settings')}>Settings</button>
          </nav>

          <Suspense fallback={<div>Loading...</div>}>
            {currentPage === 'dashboard' && <Dashboard />}
            {currentPage === 'profile' && <Profile />}
            {currentPage === 'settings' && <Settings />}
          </Suspense>
        </div>
      );
    }
    // Initial bundle: 150KB, then 150KB each when navigating
    ```

    ### Route-Based Code Splitting

    ```jsx
    import { BrowserRouter, Routes, Route } from 'react-router-dom';
    import { lazy, Suspense } from 'react';

    const Home = lazy(() => import('./pages/Home'));
    const About = lazy(() => import('./pages/About'));
    const Products = lazy(() => import('./pages/Products'));
    const Contact = lazy(() => import('./pages/Contact'));

    function App() {
      return (
        <BrowserRouter>
          <Suspense fallback={<PageLoader />}>
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/about" element={<About />} />
              <Route path="/products" element={<Products />} />
              <Route path="/contact" element={<Contact />} />
            </Routes>
          </Suspense>
        </BrowserRouter>
      );
    }

    function PageLoader() {
      return (
        <div className="page-loader">
          <div className="spinner" />
          <p>Loading...</p>
        </div>
      );
    }
    ```

    ### Preloading Lazy Components

    ```jsx
    const ProductDetails = lazy(() => import('./ProductDetails'));

    function ProductCard({ product }) {
      // Preload component on hover
      const handleMouseEnter = () => {
        // Start loading ProductDetails component
        import('./ProductDetails');
      };

      return (
        <div onMouseEnter={handleMouseEnter}>
          <h3>{product.name}</h3>
          <Link to={\`/products/\${product.id}\`}>View Details</Link>
        </div>
      );
    }
    // Component likely already loaded when user clicks!
    ```

    ## Virtualization with react-window

    **Render only visible items in long lists**

    ```jsx
    // ❌ Bad: Render 10,000 items (slow!)
    function ProductList({ products }) {
      return (
        <div className="product-list">
          {products.map(product => (
            <ProductCard key={product.id} product={product} />
          ))}
        </div>
      );
    }
    // 10,000 DOM nodes = Slow rendering, high memory usage

    // ✅ Good: Virtualized list (fast!)
    import { FixedSizeList } from 'react-window';

    function ProductList({ products }) {
      const Row = ({ index, style }) => (
        <div style={style}>
          <ProductCard product={products[index]} />
        </div>
      );

      return (
        <FixedSizeList
          height={600}           // Viewport height
          itemCount={products.length}  // Total items
          itemSize={120}         // Height of each item
          width="100%"
        >
          {Row}
        </FixedSizeList>
      );
    }
    // Only renders ~10 visible items + buffer!
    ```

    ### Variable Size Lists

    ```jsx
    import { VariableSizeList } from 'react-window';

    function MessageList({ messages }) {
      const listRef = useRef();

      // Function to calculate item height
      const getItemSize = (index) => {
        const message = messages[index];
        // Base height + character-based calculation
        return 50 + Math.ceil(message.text.length / 50) * 20;
      };

      const Row = ({ index, style }) => {
        const message = messages[index];
        return (
          <div style={style} className="message">
            <strong>{message.author}</strong>
            <p>{message.text}</p>
          </div>
        );
      };

      return (
        <VariableSizeList
          ref={listRef}
          height={600}
          itemCount={messages.length}
          itemSize={getItemSize}
          width="100%"
        >
          {Row}
        </VariableSizeList>
      );
    }
    ```

    ## Profiler and DevTools

    **Identify performance bottlenecks**

    ```jsx
    import { Profiler } from 'react';

    function onRenderCallback(
      id,           // Component identifier
      phase,        // "mount" or "update"
      actualDuration,  // Time spent rendering
      baseDuration,    // Estimated time without memoization
      startTime,
      commitTime,
      interactions
    ) {
      console.log(\`\${id} (\${phase}) took \${actualDuration}ms\`);
    }

    function App() {
      return (
        <Profiler id="App" onRender={onRenderCallback}>
          <Dashboard />
        </Profiler>
      );
    }

    // Log performance data to analytics
    function onRenderCallback(id, phase, actualDuration) {
      if (actualDuration > 100) {
        analytics.track('slow-render', {
          component: id,
          phase,
          duration: actualDuration
        });
      }
    }
    ```

    ### React DevTools Profiler

    **Steps to profile:**
    1. Open React DevTools
    2. Click "Profiler" tab
    3. Click record button
    4. Interact with your app
    5. Click stop button
    6. Analyze flame graph

    **What to look for:**
    - Components that render frequently
    - Components with long render times
    - Unnecessary re-renders (same props/state)
    - Deep component trees

    ## Common Performance Pitfalls

    ### 1. Creating Objects/Arrays in Render

    ```jsx
    // ❌ Bad: New object every render
    function UserProfile({ userId }) {
      return <ExpensiveComponent config={{ userId, theme: 'dark' }} />;
      // config is a new object reference every render!
    }

    // ✅ Good: Memoize the object
    function UserProfile({ userId }) {
      const config = useMemo(() => ({ userId, theme: 'dark' }), [userId]);
      return <ExpensiveComponent config={config} />;
    }
    ```

    ### 2. Inline Function Props

    ```jsx
    // ❌ Bad: New function every render
    function TodoList({ todos }) {
      return (
        <ul>
          {todos.map(todo => (
            <TodoItem
              key={todo.id}
              todo={todo}
              onDelete={() => deleteTodo(todo.id)}  {/* New function! */}
            />
          ))}
        </ul>
      );
    }

    // ✅ Good: Pass stable function + id
    function TodoList({ todos }) {
      const handleDelete = useCallback((id) => deleteTodo(id), []);

      return (
        <ul>
          {todos.map(todo => (
            <TodoItem
              key={todo.id}
              todo={todo}
              onDelete={handleDelete}
            />
          ))}
        </ul>
      );
    }

    const TodoItem = memo(({ todo, onDelete }) => (
      <li>
        {todo.text}
        <button onClick={() => onDelete(todo.id)}>Delete</button>
      </li>
    ));
    ```

    ### 3. Not Using Keys Properly

    ```jsx
    // ❌ Bad: Index as key (causes re-renders on reorder)
    {todos.map((todo, index) => (
      <TodoItem key={index} todo={todo} />
    ))}

    // ✅ Good: Stable unique identifier
    {todos.map(todo => (
      <TodoItem key={todo.id} todo={todo} />
    ))}
    ```

    ### 4. Large Context Values

    ```jsx
    // ❌ Bad: All consumers re-render on any change
    const AppContext = createContext();

    function AppProvider({ children }) {
      const [state, setState] = useState({
        user: null,
        theme: 'light',
        notifications: [],
        settings: {}
      });

      return (
        <AppContext.Provider value={state}>
          {children}
        </AppContext.Provider>
      );
    }

    // ✅ Good: Split contexts or memoize selectively
    const UserContext = createContext();
    const ThemeContext = createContext();
    const NotificationContext = createContext();

    // Or use context selectors with useSyncExternalStore
    ```

    ## Performance Checklist

    ✅ **Do:**
    - Profile before optimizing
    - Use React.memo for expensive components
    - Use useCallback for functions passed as props
    - Use useMemo for expensive calculations
    - Code split by route
    - Virtualize long lists (1000+ items)
    - Debounce/throttle frequent updates
    - Use production builds for benchmarking

    ❌ **Don't:**
    - Optimize prematurely
    - Use memo/useMemo everywhere (overhead!)
    - Create new objects/arrays in render
    - Use index as key for dynamic lists
    - Put everything in one Context
    - Render 1000+ items without virtualization

    ## Measuring Performance

    ```jsx
    // Measure component render time
    function MyComponent() {
      const startTime = performance.now();

      // Component logic...

      useEffect(() => {
        const endTime = performance.now();
        console.log(\`Render took \${endTime - startTime}ms\`);
      });

      return <div>...</div>;
    }

    // Track Core Web Vitals
    import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals';

    getCLS(console.log);  // Cumulative Layout Shift
    getFID(console.log);  // First Input Delay
    getFCP(console.log);  // First Contentful Paint
    getLCP(console.log);  // Largest Contentful Paint
    getTTFB(console.log); // Time to First Byte
    ```

    **Next**: We'll explore advanced component design patterns.
  MARKDOWN
  lesson.key_concepts = ['React.memo', 'useMemo', 'useCallback', 'code splitting', 'lazy', 'Suspense', 'virtualization', 'Profiler', 'performance optimization']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
  item.required = true
end

puts "  ✅ Created module: #{module2.title}"

# ==========================================
# MODULE 3: Advanced Component Patterns
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'react-patterns', course: react_course) do |mod|
  mod.title = 'Advanced Component Patterns'
  mod.description = 'Compound components, Render Props, HOC, Control Props, State Reducer'
  mod.sequence_order = 3
  mod.estimated_minutes = 130
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Build flexible Compound Components",
    "Use Render Props pattern effectively",
    "Create Higher-Order Components (HOC)",
    "Implement Control Props pattern",
    "Apply State Reducer pattern for extensibility"
  ])
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Component Design Patterns") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Component Design Patterns

    Advanced patterns for building flexible, reusable, and composable React components.

    ## Compound Components Pattern

    **Components that work together to form a complete UI**

    Like HTML elements: `<select>` and `<option>` work together.

    ```jsx
    // Example: Accordion component
    import { createContext, useContext, useState } from 'react';

    // Create context for sharing state
    const AccordionContext = createContext();

    function Accordion({ children, defaultIndex = 0 }) {
      const [activeIndex, setActiveIndex] = useState(defaultIndex);

      const value = { activeIndex, setActiveIndex };

      return (
        <AccordionContext.Provider value={value}>
          <div className="accordion">{children}</div>
        </AccordionContext.Provider>
      );
    }

    function AccordionItem({ children, index }) {
      const { activeIndex, setActiveIndex } = useContext(AccordionContext);
      const isActive = activeIndex === index;

      return (
        <div className="accordion-item">
          <div
            className="accordion-header"
            onClick={() => setActiveIndex(isActive ? -1 : index)}
          >
            {children[0]} {/* AccordionHeader */}
          </div>
          {isActive && (
            <div className="accordion-content">
              {children[1]} {/* AccordionPanel */}
            </div>
          )}
        </div>
      );
    }

    function AccordionHeader({ children }) {
      return <h3>{children}</h3>;
    }

    function AccordionPanel({ children }) {
      return <div>{children}</div>;
    }

    // Attach sub-components
    Accordion.Item = AccordionItem;
    Accordion.Header = AccordionHeader;
    Accordion.Panel = AccordionPanel;

    // Usage - Very flexible API!
    function App() {
      return (
        <Accordion defaultIndex={0}>
          <Accordion.Item index={0}>
            <Accordion.Header>Section 1</Accordion.Header>
            <Accordion.Panel>Content for section 1</Accordion.Panel>
          </Accordion.Item>

          <Accordion.Item index={1}>
            <Accordion.Header>Section 2</Accordion.Header>
            <Accordion.Panel>Content for section 2</Accordion.Panel>
          </Accordion.Item>

          <Accordion.Item index={2}>
            <Accordion.Header>Section 3</Accordion.Header>
            <Accordion.Panel>Content for section 3</Accordion.Panel>
          </Accordion.Item>
        </Accordion>
      );
    }
    ```

    ### Real-World Example: Tabs Component

    ```jsx
    const TabsContext = createContext();

    function Tabs({ children, defaultTab = 0 }) {
      const [activeTab, setActiveTab] = useState(defaultTab);

      return (
        <TabsContext.Provider value={{ activeTab, setActiveTab }}>
          <div className="tabs">{children}</div>
        </TabsContext.Provider>
      );
    }

    function TabList({ children }) {
      return <div className="tab-list" role="tablist">{children}</div>;
    }

    function Tab({ children, index }) {
      const { activeTab, setActiveTab } = useContext(TabsContext);
      const isActive = activeTab === index;

      return (
        <button
          role="tab"
          aria-selected={isActive}
          className={\`tab \${isActive ? 'active' : ''}\`}
          onClick={() => setActiveTab(index)}
        >
          {children}
        </button>
      );
    }

    function TabPanels({ children }) {
      return <div className="tab-panels">{children}</div>;
    }

    function TabPanel({ children, index }) {
      const { activeTab } = useContext(TabsContext);

      if (activeTab !== index) return null;

      return (
        <div role="tabpanel" className="tab-panel">
          {children}
        </div>
      );
    }

    Tabs.List = TabList;
    Tabs.Tab = Tab;
    Tabs.Panels = TabPanels;
    Tabs.Panel = TabPanel;

    // Usage
    function Dashboard() {
      return (
        <Tabs defaultTab={0}>
          <Tabs.List>
            <Tabs.Tab index={0}>Overview</Tabs.Tab>
            <Tabs.Tab index={1}>Analytics</Tabs.Tab>
            <Tabs.Tab index={2}>Settings</Tabs.Tab>
          </Tabs.List>

          <Tabs.Panels>
            <Tabs.Panel index={0}>
              <Overview />
            </Tabs.Panel>
            <Tabs.Panel index={1}>
              <Analytics />
            </Tabs.Panel>
            <Tabs.Panel index={2}>
              <Settings />
            </Tabs.Panel>
          </Tabs.Panels>
        </Tabs>
      );
    }
    ```

    ## Render Props Pattern

    **Share code between components using a prop whose value is a function**

    ```jsx
    // Mouse tracker using render props
    function MouseTracker({ render }) {
      const [position, setPosition] = useState({ x: 0, y: 0 });

      useEffect(() => {
        const handleMouseMove = (e) => {
          setPosition({ x: e.clientX, y: e.clientY });
        };

        window.addEventListener('mousemove', handleMouseMove);
        return () => window.removeEventListener('mousemove', handleMouseMove);
      }, []);

      return render(position);
    }

    // Usage - Complete control over rendering!
    function App() {
      return (
        <div>
          <h1>Move your mouse!</h1>

          <MouseTracker render={({ x, y }) => (
            <p>Mouse position: ({x}, {y})</p>
          )} />

          <MouseTracker render={({ x, y }) => (
            <div
              style={{
                position: 'fixed',
                left: x,
                top: y,
                width: 20,
                height: 20,
                borderRadius: '50%',
                backgroundColor: 'red',
                pointerEvents: 'none'
              }}
            />
          )} />
        </div>
      );
    }
    ```

    ### Children as Function (Render Props Variant)

    ```jsx
    // Data fetching with render props
    function DataFetcher({ url, children }) {
      const [data, setData] = useState(null);
      const [loading, setLoading] = useState(true);
      const [error, setError] = useState(null);

      useEffect(() => {
        let cancelled = false;

        fetch(url)
          .then(res => res.json())
          .then(json => {
            if (!cancelled) {
              setData(json);
              setLoading(false);
            }
          })
          .catch(err => {
            if (!cancelled) {
              setError(err);
              setLoading(false);
            }
          });

        return () => { cancelled = true; };
      }, [url]);

      return children({ data, loading, error });
    }

    // Usage
    function UserProfile() {
      return (
        <DataFetcher url="/api/user">
          {({ data, loading, error }) => {
            if (loading) return <Spinner />;
            if (error) return <Error message={error.message} />;
            return <UserCard user={data} />;
          }}
        </DataFetcher>
      );
    }
    ```

    ## Higher-Order Components (HOC)

    **Function that takes a component and returns a new enhanced component**

    ```jsx
    // HOC for authentication
    function withAuth(Component) {
      return function AuthenticatedComponent(props) {
        const { user, loading } = useAuth(); // Custom hook

        if (loading) {
          return <Spinner />;
        }

        if (!user) {
          return <Navigate to="/login" />;
        }

        return <Component {...props} user={user} />;
      };
    }

    // Usage
    function Dashboard({ user }) {
      return <h1>Welcome, {user.name}!</h1>;
    }

    const AuthenticatedDashboard = withAuth(Dashboard);

    function App() {
      return (
        <Routes>
          <Route path="/dashboard" element={<AuthenticatedDashboard />} />
        </Routes>
      );
    }
    ```

    ### HOC for Data Fetching

    ```jsx
    // Generic data fetching HOC
    function withData(Component, endpoint) {
      return function DataComponent(props) {
        const [data, setData] = useState(null);
        const [loading, setLoading] = useState(true);
        const [error, setError] = useState(null);

        useEffect(() => {
          fetch(endpoint)
            .then(res => res.json())
            .then(setData)
            .catch(setError)
            .finally(() => setLoading(false));
        }, []);

        if (loading) return <Spinner />;
        if (error) return <Error error={error} />;

        return <Component {...props} data={data} />;
      };
    }

    // Usage
    function UserList({ data }) {
      return (
        <ul>
          {data.map(user => (
            <li key={user.id}>{user.name}</li>
          ))}
        </ul>
      );
    }

    const UserListWithData = withData(UserList, '/api/users');

    function PostList({ data }) {
      return (
        <ul>
          {data.map(post => (
            <li key={post.id}>{post.title}</li>
          ))}
        </ul>
      );
    }

    const PostListWithData = withData(PostList, '/api/posts');
    ```

    ### Composing Multiple HOCs

    ```jsx
    // Compose HOCs together
    import { compose } from 'lodash/fp'; // or write your own

    function withLogging(Component) {
      return function LoggingComponent(props) {
        useEffect(() => {
          console.log('Component mounted:', Component.name);
          return () => console.log('Component unmounted:', Component.name);
        }, []);

        return <Component {...props} />;
      };
    }

    function withAnalytics(Component) {
      return function AnalyticsComponent(props) {
        useEffect(() => {
          analytics.track('page_view', { component: Component.name });
        }, []);

        return <Component {...props} />;
      };
    }

    // Compose multiple HOCs
    const enhance = compose(
      withAuth,
      withLogging,
      withAnalytics
    );

    const EnhancedDashboard = enhance(Dashboard);
    ```

    ## Control Props Pattern

    **Let parent component control component state (controlled vs uncontrolled)**

    ```jsx
    // Controlled + Uncontrolled component
    function Counter({
      value: controlledValue,           // Controlled
      defaultValue = 0,                 // Uncontrolled default
      onChange,                         // Callback for controlled mode
      ...props
    }) {
      // Determine if controlled or uncontrolled
      const isControlled = controlledValue !== undefined;
      const [uncontrolledValue, setUncontrolledValue] = useState(defaultValue);

      // Use controlled value if provided, otherwise use internal state
      const value = isControlled ? controlledValue : uncontrolledValue;

      const handleIncrement = () => {
        const newValue = value + 1;

        if (isControlled) {
          // Controlled: notify parent
          onChange?.(newValue);
        } else {
          // Uncontrolled: update internal state
          setUncontrolledValue(newValue);
        }
      };

      const handleDecrement = () => {
        const newValue = value - 1;

        if (isControlled) {
          onChange?.(newValue);
        } else {
          setUncontrolledValue(newValue);
        }
      };

      return (
        <div>
          <button onClick={handleDecrement}>-</button>
          <span>{value}</span>
          <button onClick={handleIncrement}>+</button>
        </div>
      );
    }

    // Usage 1: Uncontrolled (component manages state)
    function App() {
      return <Counter defaultValue={5} />;
    }

    // Usage 2: Controlled (parent manages state)
    function App() {
      const [count, setCount] = useState(10);

      return (
        <div>
          <Counter value={count} onChange={setCount} />
          <p>Count from parent: {count}</p>
          <button onClick={() => setCount(0)}>Reset from parent</button>
        </div>
      );
    }
    ```

    ### Real-World Example: Toggle Component

    ```jsx
    function Toggle({
      on: controlledOn,
      defaultOn = false,
      onChange,
      children
    }) {
      const isControlled = controlledOn !== undefined;
      const [uncontrolledOn, setUncontrolledOn] = useState(defaultOn);

      const on = isControlled ? controlledOn : uncontrolledOn;

      const toggle = () => {
        const newOn = !on;
        if (isControlled) {
          onChange?.(newOn);
        } else {
          setUncontrolledOn(newOn);
        }
      };

      return children({ on, toggle });
    }

    // Usage 1: Uncontrolled
    function App() {
      return (
        <Toggle defaultOn={false}>
          {({ on, toggle }) => (
            <div>
              <Switch on={on} onClick={toggle} />
              {on && <div>The switch is on!</div>}
            </div>
          )}
        </Toggle>
      );
    }

    // Usage 2: Controlled (with validation)
    function App() {
      const [isOn, setIsOn] = useState(false);
      const [confirmModalOpen, setConfirmModalOpen] = useState(false);

      const handleChange = (newValue) => {
        if (newValue === true) {
          // Show confirmation before turning on
          setConfirmModalOpen(true);
        } else {
          setIsOn(false);
        }
      };

      const confirmTurnOn = () => {
        setIsOn(true);
        setConfirmModalOpen(false);
      };

      return (
        <>
          <Toggle on={isOn} onChange={handleChange}>
            {({ on, toggle }) => (
              <Switch on={on} onClick={toggle} />
            )}
          </Toggle>

          {confirmModalOpen && (
            <Modal>
              <p>Are you sure you want to turn this on?</p>
              <button onClick={confirmTurnOn}>Yes</button>
              <button onClick={() => setConfirmModalOpen(false)}>No</button>
            </Modal>
          )}
        </>
      );
    }
    ```

    ## State Reducer Pattern

    **Give users control over component's state management logic**

    ```jsx
    // Default reducer
    function toggleReducer(state, action) {
      switch (action.type) {
        case 'TOGGLE':
          return { on: !state.on };
        case 'SET_ON':
          return { on: true };
        case 'SET_OFF':
          return { on: false };
        default:
          throw new Error(\`Unsupported action type: \${action.type}\`);
      }
    }

    function Toggle({ reducer = toggleReducer, initialOn = false, children }) {
      const [state, dispatch] = useReducer(reducer, { on: initialOn });

      const toggle = () => dispatch({ type: 'TOGGLE' });
      const setOn = () => dispatch({ type: 'SET_ON' });
      const setOff = () => dispatch({ type: 'SET_OFF' });

      return children({ on: state.on, toggle, setOn, setOff });
    }

    // Usage 1: Default behavior
    function App() {
      return (
        <Toggle>
          {({ on, toggle }) => (
            <button onClick={toggle}>
              {on ? 'ON' : 'OFF'}
            </button>
          )}
        </Toggle>
      );
    }

    // Usage 2: Custom reducer with click limit
    function clickLimitReducer(state, action) {
      const MAX_CLICKS = 4;

      switch (action.type) {
        case 'TOGGLE':
          if (state.clicks >= MAX_CLICKS) {
            // Prevent toggle after max clicks
            return state;
          }
          return {
            on: !state.on,
            clicks: state.clicks + 1
          };
        case 'SET_ON':
          return { ...state, on: true };
        case 'SET_OFF':
          return { ...state, on: false };
        case 'RESET':
          return { on: false, clicks: 0 };
        default:
          throw new Error(\`Unsupported action type: \${action.type}\`);
      }
    }

    function App() {
      return (
        <Toggle reducer={clickLimitReducer} initialOn={false}>
          {({ on, toggle }) => {
            const [state, dispatch] = useReducer(clickLimitReducer, { on: false, clicks: 0 });

            return (
              <div>
                <button onClick={toggle} disabled={state.clicks >= 4}>
                  {on ? 'ON' : 'OFF'}
                </button>
                <p>Clicks: {state.clicks}/4</p>
                {state.clicks >= 4 && (
                  <button onClick={() => dispatch({ type: 'RESET' })}>
                    Reset
                  </button>
                )}
              </div>
            );
          }}
        </Toggle>
      );
    }
    ```

    ## Pattern Comparison

    | Pattern | Best For | Flexibility | Complexity |
    |---------|----------|-------------|------------|
    | **Compound Components** | Related components working together | High | Medium |
    | **Render Props** | Sharing logic with full render control | Very High | Low |
    | **HOC** | Cross-cutting concerns, reusable logic | Medium | Medium |
    | **Control Props** | Making component controlled/uncontrolled | High | Low |
    | **State Reducer** | Giving users control over state logic | Very High | High |

    ## When to Use Each Pattern

    ### Compound Components
    ✅ Tabs, Accordions, Dropdowns, Modals
    ✅ When components naturally work together
    ✅ Want flexible composition

    ### Render Props
    ✅ Data fetching, Mouse tracking, Drag and drop
    ✅ Need full control over rendering
    ✅ Share logic without assuming UI

    ### Higher-Order Components
    ✅ Authentication, Logging, Analytics
    ✅ Cross-cutting concerns across many components
    ✅ Enhance components with same logic

    ### Control Props
    ✅ Form inputs, Toggles, Any component that manages state
    ✅ Want both controlled and uncontrolled modes
    ✅ Give users flexibility

    ### State Reducer
    ✅ Complex components with custom behavior needs
    ✅ Library components used in many contexts
    ✅ Users need to customize state logic

    ## Real-World Example: Dropdown Menu

    **Combining multiple patterns**

    ```jsx
    // Using Compound Components + Control Props + Render Props
    const DropdownContext = createContext();

    function Dropdown({
      children,
      isOpen: controlledIsOpen,
      defaultIsOpen = false,
      onOpenChange
    }) {
      const isControlled = controlledIsOpen !== undefined;
      const [uncontrolledIsOpen, setUncontrolledIsOpen] = useState(defaultIsOpen);

      const isOpen = isControlled ? controlledIsOpen : uncontrolledIsOpen;

      const toggle = () => {
        const newIsOpen = !isOpen;
        if (isControlled) {
          onOpenChange?.(newIsOpen);
        } else {
          setUncontrolledIsOpen(newIsOpen);
        }
      };

      const open = () => {
        if (isControlled) {
          onOpenChange?.(true);
        } else {
          setUncontrolledIsOpen(true);
        }
      };

      const close = () => {
        if (isControlled) {
          onOpenChange?.(false);
        } else {
          setUncontrolledIsOpen(false);
        }
      };

      return (
        <DropdownContext.Provider value={{ isOpen, toggle, open, close }}>
          {children}
        </DropdownContext.Provider>
      );
    }

    function DropdownTrigger({ children }) {
      const { toggle } = useContext(DropdownContext);
      return <button onClick={toggle}>{children}</button>;
    }

    function DropdownMenu({ children }) {
      const { isOpen } = useContext(DropdownContext);
      if (!isOpen) return null;
      return <div className="dropdown-menu">{children}</div>;
    }

    function DropdownItem({ children, onClick }) {
      const { close } = useContext(DropdownContext);

      const handleClick = () => {
        onClick?.();
        close();
      };

      return (
        <button className="dropdown-item" onClick={handleClick}>
          {children}
        </button>
      );
    }

    Dropdown.Trigger = DropdownTrigger;
    Dropdown.Menu = DropdownMenu;
    Dropdown.Item = DropdownItem;

    // Usage
    function UserMenu() {
      return (
        <Dropdown>
          <Dropdown.Trigger>
            User Menu ▼
          </Dropdown.Trigger>
          <Dropdown.Menu>
            <Dropdown.Item onClick={() => navigate('/profile')}>
              Profile
            </Dropdown.Item>
            <Dropdown.Item onClick={() => navigate('/settings')}>
              Settings
            </Dropdown.Item>
            <Dropdown.Item onClick={handleLogout}>
              Logout
            </Dropdown.Item>
          </Dropdown.Menu>
        </Dropdown>
      );
    }
    ```

    ## Best Practices

    1. **Start simple** - Don't over-engineer. Use patterns when complexity demands it.
    2. **Prefer hooks** - Modern React favors hooks over HOCs and render props.
    3. **Compound components for related UI** - Great for flexible component APIs.
    4. **Document your patterns** - Make it clear how components should be used.
    5. **Test thoroughly** - Complex patterns need comprehensive tests.

    **You've mastered advanced React patterns! Use these to build flexible, reusable component libraries.**
  MARKDOWN
  lesson.key_concepts = ['Compound Components', 'Render Props', 'Higher-Order Components', 'Control Props', 'State Reducer', 'component patterns', 'composition']
end

ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1) do |item|
  item.sequence_order = 1
  item.required = true
end

puts "  ✅ Created module: #{module3.title}"

puts "\n✅ React Advanced Patterns Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{react_course.title}"
puts "📖 Modules: #{react_course.course_modules.count}"
puts "📝 Lessons: Comprehensive content with extensive React examples"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
