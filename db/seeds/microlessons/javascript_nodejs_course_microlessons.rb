# AUTO-GENERATED from javascript_nodejs_course.rb
puts "Creating Microlessons for Modern Javascript..."

module_var = CourseModule.find_by(slug: 'modern-javascript')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# JavaScript ES6+ Features

    Modern JavaScript (ES6/ES2015 and beyond) introduced powerful features that make code more concise and maintainable.

    ## Variables: let, const, var

    ```javascript
    // var - function scoped, can be redeclared (OLD, avoid)
    var x = 1;
    var x = 2;  // OK but confusing

    // let - block scoped, can be reassigned
    let count = 0;
    count = 1;  // OK

    // const - block scoped, cannot be reassigned
    const API_KEY = 'abc123';
    // API_KEY = 'new';  // ERROR

    // But objects can be modified
    const user = { name: 'Alice' };
    user.name = 'Bob';  // OK - modifying property
    // user = {};  // ERROR - reassigning
    ```

    **Best Practice**: Use `const` by default, `let` when you need to reassign, never `var`.

    ## Arrow Functions

    ```javascript
    // Traditional function
    function add(a, b) {
      return a + b;
    }

    // Arrow function
    const add = (a, b) => a + b;

    // With block
    const multiply = (a, b) => {
      const result = a * b;
      return result;
    };

    // Single parameter (parentheses optional)
    const square = x => x * x;

    // No parameters
    const greet = () => console.log('Hello!');

    // Arrow functions and 'this'
    const person = {
      name: 'Alice',
      hobbies: ['reading', 'coding'],

      // Arrow function inherits 'this' from parent scope
      printHobbies() {
        this.hobbies.forEach(hobby => {
          console.log(\`\${this.name} likes \${hobby}\`);
        });
      }
    };
    ```

    ## Template Literals

    ```javascript
    const name = 'Alice';
    const age = 25;

    // Old way
    const message = 'Hello, ' + name + '! You are ' + age + ' years old.';

    // Template literals (backticks)
    const message = \`Hello, \${name}! You are \${age} years old.\`;

    // Multiline strings
    const html = \`
      <div>
        <h1>\${title}</h1>
        <p>\${content}</p>
      </div>
    \`;

    // Expression evaluation
    const total = \`Total: $\${price * quantity}\`;
    ```

    ## Destructuring

    ### Array Destructuring

    ```javascript
    const colors = ['red', 'green', 'blue'];

    // Old way
    const first = colors[0];
    const second = colors[1];

    // Destructuring
    const [first, second, third] = colors;
    console.log(first);  // 'red'

    // Skip elements
    const [, , third] = colors;  // Only 'blue'

    // Rest operator
    const [first, ...rest] = colors;
    console.log(rest);  // ['green', 'blue']

    // Default values
    const [a, b, c, d = 'yellow'] = colors;
    ```

    ### Object Destructuring

    ```javascript
    const user = {
      name: 'Alice',
      age: 25,
      email: 'alice@example.com',
      city: 'NYC'
    };

    // Extract properties
    const { name, age } = user;
    console.log(name);  // 'Alice'

    // Rename variables
    const { name: userName, age: userAge } = user;

    // Default values
    const { name, country = 'USA' } = user;

    // Nested destructuring
    const data = {
      user: {
        profile: {
          name: 'Alice'
        }
      }
    };
    const { user: { profile: { name } } } = data;

    // Function parameters
    function greet({ name, age }) {
      console.log(\`Hello \${name}, age \${age}\`);
    }
    greet(user);
    ```

    ## Spread and Rest Operators

    ### Spread (...) - Expand elements

    ```javascript
    // Arrays
    const arr1 = [1, 2, 3];
    const arr2 = [4, 5, 6];
    const combined = [...arr1, ...arr2];  // [1,2,3,4,5,6]

    // Copy array
    const copy = [...arr1];

    // Objects
    const defaults = { theme: 'dark', lang: 'en' };
    const userPrefs = { lang: 'fr', fontSize: 14 };
    const settings = { ...defaults, ...userPrefs };
    // { theme: 'dark', lang: 'fr', fontSize: 14 }

    // Function arguments
    const numbers = [1, 2, 3];
    Math.max(...numbers);  // 3
    ```

    ### Rest (...) - Collect remaining elements

    ```javascript
    // Function parameters
    function sum(...numbers) {
      return numbers.reduce((total, n) => total + n, 0);
    }
    sum(1, 2, 3, 4);  // 10

    // Mixed parameters
    function greet(greeting, ...names) {
      names.forEach(name => console.log(\`\${greeting}, \${name}!\`));
    }
    greet('Hello', 'Alice', 'Bob', 'Charlie');

    // Array destructuring
    const [first, ...rest] = [1, 2, 3, 4];
    // first = 1, rest = [2, 3, 4]
    ```

    ## Enhanced Object Literals

    ```javascript
    const name = 'Alice';
    const age = 25;

    // Property shorthand
    const user = { name, age };
    // Same as: { name: name, age: age }

    // Method shorthand
    const obj = {
      // Old way
      greet: function() {
        return 'Hello';
      },

      // New way
      greet() {
        return 'Hello';
      }
    };

    // Computed property names
    const key = 'email';
    const user = {
      name: 'Alice',
      [key]: 'alice@example.com',
      [\`user_\${key}\`]: 'alice@example.com'
    };
    ```

    ## Modules (Import/Export)

    ```javascript
    // math.js
    export const PI = 3.14159;
    export function square(x) {
      return x * x;
    }
    export default function add(a, b) {
      return a + b;
    }

    // app.js
    import add, { PI, square } from './math.js';
    console.log(add(2, 3));     // 5
    console.log(PI);            // 3.14159
    console.log(square(4));     // 16

    // Import all
    import * as math from './math.js';
    math.square(5);

    // Rename imports
    import { square as sq } from './math.js';
    ```

    ## Default Parameters

    ```javascript
    // Old way
    function greet(name) {
      name = name || 'Guest';
      return \`Hello, \${name}\`;
    }

    // New way
    function greet(name = 'Guest') {
      return \`Hello, \${name}\`;
    }

    // With expressions
    function createUser(name, role = 'user', id = generateId()) {
      return { name, role, id };
    }
    ```

    ## Classes

    ```javascript
    class Person {
      constructor(name, age) {
        this.name = name;
        this.age = age;
      }

      greet() {
        return \`Hello, I'm \${this.name}\`;
      }

      // Static method
      static create(name, age) {
        return new Person(name, age);
      }

      // Getter
      get info() {
        return \`\${this.name}, \${this.age}\`;
      }

      // Setter
      set age(value) {
        if (value < 0) throw new Error('Invalid age');
        this._age = value;
      }
    }

    // Inheritance
    class Developer extends Person {
      constructor(name, age, language) {
        super(name, age);
        this.language = language;
      }

      code() {
        return \`Coding in \${this.language}\`;
      }
    }

    const dev = new Developer('Alice', 25, 'JavaScript');
    ```

    ## Promises and Async/Await (Preview)

    ```javascript
    // Promise
    function fetchUser(id) {
      return new Promise((resolve, reject) => {
        setTimeout(() => {
          resolve({ id, name: 'Alice' });
        }, 1000);
      });
    }

    // Using promise
    fetchUser(1)
      .then(user => console.log(user))
      .catch(error => console.error(error));

    // Async/await (cleaner)
    async function getUser(id) {
      try {
        const user = await fetchUser(id);
        console.log(user);
      } catch (error) {
        console.error(error);
      }
    }
    ```

    **Next**: We'll dive deep into asynchronous JavaScript!
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# JavaScript ES6+ Features

    Modern JavaScript (ES6/ES2015 and beyond) introduced powerful features that make code more concise and maintainable.

    ## Variables: let, const, var

    ```javascript
    // var - function scoped, can be redeclared (OLD, avoid)
    var x = 1;
    var x = 2;  // OK but confusing

    // let - block scoped, can be reassigned
    let count = 0;
    count = 1;  // OK

    // const - block scoped, cannot be reassigned
    const API_KEY = 'abc123';
    // API_KEY = 'new';  // ERROR

    // But objects can be modified
    const user = { name: 'Alice' };
    user.name = 'Bob';  // OK - modifying property
    // user = {};  // ERROR - reassigning
    ```

    **Best Practice**: Use `const` by default, `let` when you need to reassign, never `var`.

    ## Arrow Functions

    ```javascript
    // Traditional function
    function add(a, b) {
      return a + b;
    }

    // Arrow function
    const add = (a, b) => a + b;

    // With block
    const multiply = (a, b) => {
      const result = a * b;
      return result;
    };

    // Single parameter (parentheses optional)
    const square = x => x * x;

    // No parameters
    const greet = () => console.log('Hello!');

    // Arrow functions and 'this'
    const person = {
      name: 'Alice',
      hobbies: ['reading', 'coding'],

      // Arrow function inherits 'this' from parent scope
      printHobbies() {
        this.hobbies.forEach(hobby => {
          console.log(\`\${this.name} likes \${hobby}\`);
        });
      }
    };
    ```

    ## Template Literals

    ```javascript
    const name = 'Alice';
    const age = 25;

    // Old way
    const message = 'Hello, ' + name + '! You are ' + age + ' years old.';

    // Template literals (backticks)
    const message = \`Hello, \${name}! You are \${age} years old.\`;

    // Multiline strings
    const html = \`
      <div>
        <h1>\${title}</h1>
        <p>\${content}</p>
      </div>
    \`;

    // Expression evaluation
    const total = \`Total: $\${price * quantity}\`;
    ```

    ## Destructuring

    ### Array Destructuring

    ```javascript
    const colors = ['red', 'green', 'blue'];

    // Old way
    const first = colors[0];
    const second = colors[1];

    // Destructuring
    const [first, second, third] = colors;
    console.log(first);  // 'red'

    // Skip elements
    const [, , third] = colors;  // Only 'blue'

    // Rest operator
    const [first, ...rest] = colors;
    console.log(rest);  // ['green', 'blue']

    // Default values
    const [a, b, c, d = 'yellow'] = colors;
    ```

    ### Object Destructuring

    ```javascript
    const user = {
      name: 'Alice',
      age: 25,
      email: 'alice@example.com',
      city: 'NYC'
    };

    // Extract properties
    const { name, age } = user;
    console.log(name);  // 'Alice'

    // Rename variables
    const { name: userName, age: userAge } = user;

    // Default values
    const { name, country = 'USA' } = user;

    // Nested destructuring
    const data = {
      user: {
        profile: {
          name: 'Alice'
        }
      }
    };
    const { user: { profile: { name } } } = data;

    // Function parameters
    function greet({ name, age }) {
      console.log(\`Hello \${name}, age \${age}\`);
    }
    greet(user);
    ```

    ## Spread and Rest Operators

    ### Spread (...) - Expand elements

    ```javascript
    // Arrays
    const arr1 = [1, 2, 3];
    const arr2 = [4, 5, 6];
    const combined = [...arr1, ...arr2];  // [1,2,3,4,5,6]

    // Copy array
    const copy = [...arr1];

    // Objects
    const defaults = { theme: 'dark', lang: 'en' };
    const userPrefs = { lang: 'fr', fontSize: 14 };
    const settings = { ...defaults, ...userPrefs };
    // { theme: 'dark', lang: 'fr', fontSize: 14 }

    // Function arguments
    const numbers = [1, 2, 3];
    Math.max(...numbers);  // 3
    ```

    ### Rest (...) - Collect remaining elements

    ```javascript
    // Function parameters
    function sum(...numbers) {
      return numbers.reduce((total, n) => total + n, 0);
    }
    sum(1, 2, 3, 4);  // 10

    // Mixed parameters
    function greet(greeting, ...names) {
      names.forEach(name => console.log(\`\${greeting}, \${name}!\`));
    }
    greet('Hello', 'Alice', 'Bob', 'Charlie');

    // Array destructuring
    const [first, ...rest] = [1, 2, 3, 4];
    // first = 1, rest = [2, 3, 4]
    ```

    ## Enhanced Object Literals

    ```javascript
    const name = 'Alice';
    const age = 25;

    // Property shorthand
    const user = { name, age };
    // Same as: { name: name, age: age }

    // Method shorthand
    const obj = {
      // Old way
      greet: function() {
        return 'Hello';
      },

      // New way
      greet() {
        return 'Hello';
      }
    };

    // Computed property names
    const key = 'email';
    const user = {
      name: 'Alice',
      [key]: 'alice@example.com',
      [\`user_\${key}\`]: 'alice@example.com'
    };
    ```

    ## Modules (Import/Export)

    ```javascript
    // math.js
    export const PI = 3.14159;
    export function square(x) {
      return x * x;
    }
    export default function add(a, b) {
      return a + b;
    }

    // app.js
    import add, { PI, square } from './math.js';
    console.log(add(2, 3));     // 5
    console.log(PI);            // 3.14159
    console.log(square(4));     // 16

    // Import all
    import * as math from './math.js';
    math.square(5);

    // Rename imports
    import { square as sq } from './math.js';
    ```

    ## Default Parameters

    ```javascript
    // Old way
    function greet(name) {
      name = name || 'Guest';
      return \`Hello, \${name}\`;
    }

    // New way
    function greet(name = 'Guest') {
      return \`Hello, \${name}\`;
    }

    // With expressions
    function createUser(name, role = 'user', id = generateId()) {
      return { name, role, id };
    }
    ```

    ## Classes

    ```javascript
    class Person {
      constructor(name, age) {
        this.name = name;
        this.age = age;
      }

      greet() {
        return \`Hello, I'm \${this.name}\`;
      }

      // Static method
      static create(name, age) {
        return new Person(name, age);
      }

      // Getter
      get info() {
        return \`\${this.name}, \${this.age}\`;
      }

      // Setter
      set age(value) {
        if (value < 0) throw new Error('Invalid age');
        this._age = value;
      }
    }

    // Inheritance
    class Developer extends Person {
      constructor(name, age, language) {
        super(name, age);
        this.language = language;
      }

      code() {
        return \`Coding in \${this.language}\`;
      }
    }

    const dev = new Developer('Alice', 25, 'JavaScript');
    ```

    ## Promises and Async/Await (Preview)

    ```javascript
    // Promise
    function fetchUser(id) {
      return new Promise((resolve, reject) => {
        setTimeout(() => {
          resolve({ id, name: 'Alice' });
        }, 1000);
      });
    }

    // Using promise
    fetchUser(1)
      .then(user => console.log(user))
      .catch(error => console.error(error));

    // Async/await (cleaner)
    async function getUser(id) {
      try {
        const user = await fetchUser(id);
        console.log(user);
      } catch (error) {
        console.error(error);
      }
    }
    ```

    **Next**: We'll dive deep into asynchronous JavaScript!
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 2 microlessons for Modern Javascript"
