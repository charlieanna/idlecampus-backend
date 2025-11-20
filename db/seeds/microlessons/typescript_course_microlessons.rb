# AUTO-GENERATED from typescript_course.rb
puts "Creating Microlessons for Typescript Basics..."

module_var = CourseModule.find_by(slug: 'typescript-basics')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# TypeScript Fundamentals and Type System

    **TypeScript** is JavaScript with syntax for types. It's a strongly typed superset of JavaScript that compiles to plain JavaScript.

    ## Why TypeScript?

    ### JavaScript Pain Points

    ```javascript
    // JavaScript - No type safety
    function add(a, b) {
      return a + b;
    }

    add(5, 10);        // 15 ✓
    add("5", "10");    // "510" - String concatenation!
    add(5, "10");      // "510" - Type coercion!
    add({}, []);       // "[object Object]" - WTF?
    ```

    ### TypeScript Solution

    ```typescript
    // TypeScript - Type safety
    function add(a: number, b: number): number {
      return a + b;
    }

    add(5, 10);        // 15 ✓
    add("5", "10");    // ❌ Error: Argument of type 'string' not assignable to 'number'
    add(5, "10");      // ❌ Error: Argument of type 'string' not assignable to 'number'
    ```

    **Benefits:**
    - Catch errors at compile time (not runtime!)
    - Better IDE support (autocomplete, refactoring)
    - Self-documenting code
    - Easier refactoring and maintenance

    ## Basic Types

    ### Primitive Types

    ```typescript
    // String
    let name: string = "Alice";
    let greeting: string = `Hello, ${name}`;

    // Number (int, float, hex, binary all are number)
    let age: number = 30;
    let price: number = 99.99;
    let hex: number = 0xf00d;
    let binary: number = 0b1010;

    // Boolean
    let isDone: boolean = false;
    let isActive: boolean = true;

    // Null and Undefined
    let nothing: null = null;
    let notDefined: undefined = undefined;

    // Any (avoid when possible!)
    let anything: any = "string";
    anything = 42;        // OK
    anything = true;      // OK
    anything = {};        // OK - defeats purpose of TypeScript!
    ```

    ### Arrays

    ```typescript
    // Array of numbers
    let numbers: number[] = [1, 2, 3, 4, 5];
    let nums: Array<number> = [1, 2, 3];  // Alternative syntax

    // Array of strings
    let names: string[] = ["Alice", "Bob", "Charlie"];

    // Mixed array (avoid!)
    let mixed: any[] = [1, "two", true];

    // Array methods are type-safe
    numbers.push(6);        // OK
    numbers.push("7");      // ❌ Error: Argument of type 'string' not assignable

    // Array operations
    const doubled = numbers.map(n => n * 2);  // Type: number[]
    const evens = numbers.filter(n => n % 2 === 0);  // Type: number[]
    ```

    ### Tuples

    **Fixed-length arrays with specific types**

    ```typescript
    // Tuple: [string, number]
    let person: [string, number] = ["Alice", 30];

    console.log(person[0].toUpperCase());  // "ALICE" - knows it's a string
    console.log(person[1].toFixed(2));     // "30.00" - knows it's a number

    // Error: Wrong types
    person = [30, "Alice"];  // ❌ Error: Type 'number' not assignable to 'string'

    // Error: Wrong length
    person = ["Alice", 30, true];  // ❌ Error: Type '[string, number, boolean]' not assignable

    // Common use case: React hooks
    const [count, setCount]: [number, (n: number) => void] = useState(0);

    // Multiple return values
    function getCoordinates(): [number, number] {
      return [10, 20];
    }

    const [x, y] = getCoordinates();  // x: number, y: number
    ```

    ### Enums

    **Named constants**

    ```typescript
    // Numeric enum (default)
    enum Direction {
      Up,      // 0
      Down,    // 1
      Left,    // 2
      Right    // 3
    }

    let dir: Direction = Direction.Up;
    console.log(dir);  // 0

    // String enum (recommended)
    enum Status {
      Pending = "PENDING",
      Approved = "APPROVED",
      Rejected = "REJECTED"
    }

    function updateStatus(status: Status) {
      console.log(`Status updated to: ${status}`);
    }

    updateStatus(Status.Approved);  // "Status updated to: APPROVED"
    updateStatus("APPROVED");       // ❌ Error: Argument type '"APPROVED"' not assignable

    // Enum with custom values
    enum HttpStatus {
      OK = 200,
      BadRequest = 400,
      Unauthorized = 401,
      NotFound = 404,
      ServerError = 500
    }

    // Const enum (better performance - inlined at compile time)
    const enum Color {
      Red = "#FF0000",
      Green = "#00FF00",
      Blue = "#0000FF"
    }
    ```

    ## Type Inference

    **TypeScript infers types automatically**

    ```typescript
    // Explicit type annotation
    let count: number = 10;

    // Type inference (preferred when obvious)
    let inferredCount = 10;  // Type: number (inferred)

    // Function return type inference
    function add(a: number, b: number) {
      return a + b;  // Return type inferred as number
    }

    // Array type inference
    let numbers = [1, 2, 3];  // Type: number[]
    let mixed = [1, "two"];   // Type: (string | number)[]

    // Object type inference
    let user = {
      name: "Alice",
      age: 30
    };
    // Type: { name: string; age: number; }

    user.name = "Bob";     // OK
    user.age = "thirty";   // ❌ Error: Type 'string' not assignable to 'number'
    ```

    **When to use explicit types:**
    - Function parameters (required)
    - Public API boundaries
    - When inference is unclear
    - When you want to enforce a specific type

    ## Type Annotations

    ### Function Types

    ```typescript
    // Function with type annotations
    function greet(name: string): string {
      return `Hello, ${name}!`;
    }

    // Arrow function
    const greet2 = (name: string): string => `Hello, ${name}!`;

    // Optional parameters
    function greet3(name: string, greeting?: string): string {
      return `${greeting || "Hello"}, ${name}!`;
    }

    greet3("Alice");           // "Hello, Alice!"
    greet3("Alice", "Hi");     // "Hi, Alice!"

    // Default parameters
    function greet4(name: string, greeting: string = "Hello"): string {
      return `${greeting}, ${name}!`;
    }

    // Rest parameters
    function sum(...numbers: number[]): number {
      return numbers.reduce((total, n) => total + n, 0);
    }

    sum(1, 2, 3, 4, 5);  // 15

    // Void return type (no return value)
    function log(message: string): void {
      console.log(message);
    }

    // Never return type (function never returns)
    function throwError(message: string): never {
      throw new Error(message);
    }

    function infiniteLoop(): never {
      while (true) {}
    }
    ```

    ### Object Types

    ```typescript
    // Object type annotation
    let user: { name: string; age: number; email?: string } = {
      name: "Alice",
      age: 30
    };

    // Optional property (email?)
    user.email = "alice@example.com";  // OK
    delete user.email;                 // OK

    // Readonly properties
    let config: { readonly apiKey: string; timeout: number } = {
      apiKey: "secret123",
      timeout: 5000
    };

    config.timeout = 10000;  // OK
    config.apiKey = "new";   // ❌ Error: Cannot assign to 'apiKey' (readonly)

    // Index signature (dynamic keys)
    let scores: { [key: string]: number } = {
      math: 95,
      english: 87,
      science: 92
    };

    scores.history = 88;  // OK - any string key allowed
    scores.math = "A";    // ❌ Error: Type 'string' not assignable to 'number'
    ```

    ## Interfaces vs Types

    ### Interfaces

    ```typescript
    // Interface definition
    interface User {
      id: number;
      name: string;
      email: string;
      age?: number;  // Optional
    }

    const user1: User = {
      id: 1,
      name: "Alice",
      email: "alice@example.com"
    };

    // Interface with methods
    interface Product {
      id: number;
      name: string;
      price: number;
      calculateDiscount(percentage: number): number;
    }

    const product: Product = {
      id: 1,
      name: "Laptop",
      price: 1000,
      calculateDiscount(percentage: number): number {
        return this.price * (percentage / 100);
      }
    };

    // Extending interfaces
    interface Employee {
      id: number;
      name: string;
    }

    interface Manager extends Employee {
      department: string;
      subordinates: Employee[];
    }

    const manager: Manager = {
      id: 1,
      name: "Bob",
      department: "Engineering",
      subordinates: []
    };

    // Interface merging (declaration merging)
    interface Window {
      customProperty: string;
    }

    interface Window {
      anotherProperty: number;
    }

    // Now Window has both properties
    window.customProperty = "value";
    window.anotherProperty = 42;
    ```

    ### Type Aliases

    ```typescript
    // Type alias
    type User = {
      id: number;
      name: string;
      email: string;
      age?: number;
    };

    // Union types (types only!)
    type ID = string | number;

    let userId: ID = 123;     // OK
    userId = "abc-123";       // OK

    // Intersection types
    type Person = {
      name: string;
      age: number;
    };

    type Employee = {
      employeeId: number;
      department: string;
    };

    type EmployeePerson = Person & Employee;

    const emp: EmployeePerson = {
      name: "Alice",
      age: 30,
      employeeId: 123,
      department: "Engineering"
    };

    // Literal types
    type Status = "pending" | "approved" | "rejected";
    type Direction = "north" | "south" | "east" | "west";

    let status: Status = "pending";    // OK
    status = "approved";               // OK
    status = "cancelled";              // ❌ Error: Type '"cancelled"' not assignable

    // Function type
    type MathOperation = (a: number, b: number) => number;

    const add: MathOperation = (a, b) => a + b;
    const subtract: MathOperation = (a, b) => a - b;
    ```

    ## Interfaces vs Types: When to Use What?

    ### Use Interfaces When:

    ```typescript
    // 1. Defining object shapes
    interface User {
      id: number;
      name: string;
    }

    // 2. Need to extend/inherit
    interface Admin extends User {
      permissions: string[];
    }

    // 3. Working with classes
    class UserAccount implements User {
      constructor(public id: number, public name: string) {}
    }

    // 4. Want declaration merging
    interface Config {
      apiUrl: string;
    }

    interface Config {
      timeout: number;
    }
    ```

    ### Use Types When:

    ```typescript
    // 1. Union types
    type Result = Success | Error;

    // 2. Intersection types
    type Combined = TypeA & TypeB;

    // 3. Primitive aliases
    type ID = string | number;

    // 4. Tuple types
    type Point = [number, number];

    // 5. Function types
    type Callback = (data: string) => void;

    // 6. Mapped types
    type Readonly<T> = {
      readonly [P in keyof T]: T[P];
    };
    ```

    **General rule:** Use `interface` for object shapes and public APIs. Use `type` for unions, intersections, and utility types.

    ## Real-World Example: User Management

    ```typescript
    // Types and interfaces
    type UserRole = "admin" | "user" | "guest";

    interface BaseUser {
      id: string;
      email: string;
      createdAt: Date;
    }

    interface User extends BaseUser {
      name: string;
      role: UserRole;
      isActive: boolean;
    }

    interface UserWithProfile extends User {
      profile: {
        bio?: string;
        avatar?: string;
        location?: string;
      };
    }

    // Function implementations
    function createUser(
      email: string,
      name: string,
      role: UserRole = "user"
    ): User {
      return {
        id: generateId(),
        email,
        name,
        role,
        isActive: true,
        createdAt: new Date()
      };
    }

    function updateUser(
      userId: string,
      updates: Partial<User>
    ): User | null {
      // Implementation
      const user = findUserById(userId);
      if (!user) return null;

      return { ...user, ...updates };
    }

    function findUsersByRole(role: UserRole): User[] {
      // Type-safe database query
      return users.filter(u => u.role === role);
    }

    // Usage
    const newUser = createUser("alice@example.com", "Alice", "admin");
    const updated = updateUser(newUser.id, { isActive: false });
    const admins = findUsersByRole("admin");
    ```

    ## Type Assertions

    ```typescript
    // Type assertion (when you know more than TypeScript)
    let someValue: any = "this is a string";

    // Angle-bracket syntax
    let strLength1: number = (<string>someValue).length;

    // As syntax (preferred, required in JSX)
    let strLength2: number = (someValue as string).length;

    // Common use case: DOM elements
    const input = document.getElementById("email") as HTMLInputElement;
    input.value = "alice@example.com";  // OK - knows it's an input

    // Non-null assertion (!)
    function processUser(user: User | null) {
      // If you're SURE it's not null
      console.log(user!.name);  // Tell TS: trust me, it's not null
    }
    ```

    ## Interview Tips

    1. **Always prefer type inference when obvious**
    2. **Use strict mode** (`strict: true` in tsconfig.json)
    3. **Avoid `any`** - use `unknown` if type is truly unknown
    4. **Interfaces for objects, types for everything else**
    5. **Enums vs union types**: String unions are often simpler
    6. **Optional chaining**: `user?.profile?.bio`
    7. **Nullish coalescing**: `value ?? defaultValue`

    **Next**: We'll explore generics and advanced type features!
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

# Generics and Advanced Types

    **Generics** allow you to write reusable, type-safe code that works with multiple types.

    ## Why Generics?

    ### Without Generics

    ```typescript
    // Specific to numbers
    function identityNumber(arg: number): number {
      return arg;
    }

    // Specific to strings
    function identityString(arg: string): string {
      return arg;
    }

    // Using any (loses type safety!)
    function identityAny(arg: any): any {
      return arg;
    }

    const result = identityAny("hello");
    result.toUpperCase();  // No autocomplete, no type checking!
    ```

    ### With Generics

    ```typescript
    // Generic function - works with any type
    function identity<T>(arg: T): T {
      return arg;
    }

    // Type is inferred
    const num = identity(42);           // Type: number
    const str = identity("hello");      // Type: string
    const bool = identity(true);        // Type: boolean

    // Explicit type parameter
    const explicit = identity<string>("hello");

    // Full type safety!
    str.toUpperCase();  // ✓ Autocomplete works
    str.toFixed();      // ❌ Error: Property 'toFixed' does not exist on string
    ```

    ## Generic Functions

    ### Basic Generic Function

    ```typescript
    // Generic array reversal
    function reverse<T>(items: T[]): T[] {
      return items.reverse();
    }

    const numbers = reverse([1, 2, 3]);      // Type: number[]
    const strings = reverse(["a", "b", "c"]);  // Type: string[]

    // Generic with multiple type parameters
    function pair<T, U>(first: T, second: U): [T, U] {
      return [first, second];
    }

    const p1 = pair("age", 30);           // Type: [string, number]
    const p2 = pair(true, "active");      // Type: [boolean, string]

    // Generic with constraints
    interface HasLength {
      length: number;
    }

    function logLength<T extends HasLength>(arg: T): T {
      console.log(arg.length);  // OK - T guaranteed to have length
      return arg;
    }

    logLength("hello");        // OK - string has length
    logLength([1, 2, 3]);      // OK - array has length
    logLength({ length: 10 }); // OK - object has length
    logLength(42);             // ❌ Error: number doesn't have length
    ```

    ### Real-World Generic Examples

    ```typescript
    // API response wrapper
    interface ApiResponse<T> {
      data: T;
      status: number;
      message: string;
    }

    interface User {
      id: number;
      name: string;
      email: string;
    }

    async function fetchUser(id: number): Promise<ApiResponse<User>> {
      const response = await fetch(`/api/users/${id}`);
      return response.json();
    }

    // Usage
    const userResponse = await fetchUser(1);
    console.log(userResponse.data.name);  // Type-safe: knows data is User

    // Generic cache
    class Cache<T> {
      private data: Map<string, T> = new Map();

      set(key: string, value: T): void {
        this.data.set(key, value);
      }

      get(key: string): T | undefined {
        return this.data.get(key);
      }

      has(key: string): boolean {
        return this.data.has(key);
      }
    }

    // Type-safe caches
    const userCache = new Cache<User>();
    userCache.set("user1", { id: 1, name: "Alice", email: "alice@example.com" });
    const user = userCache.get("user1");  // Type: User | undefined

    const numberCache = new Cache<number>();
    numberCache.set("count", 42);
    const count = numberCache.get("count");  // Type: number | undefined
    ```

    ## Generic Interfaces and Classes

    ```typescript
    // Generic interface
    interface Repository<T> {
      findById(id: string): T | null;
      findAll(): T[];
      create(item: T): T;
      update(id: string, item: Partial<T>): T | null;
      delete(id: string): boolean;
    }

    // Implementation
    class UserRepository implements Repository<User> {
      private users: User[] = [];

      findById(id: string): User | null {
        return this.users.find(u => u.id === parseInt(id)) || null;
      }

      findAll(): User[] {
        return this.users;
      }

      create(user: User): User {
        this.users.push(user);
        return user;
      }

      update(id: string, updates: Partial<User>): User | null {
        const user = this.findById(id);
        if (!user) return null;
        Object.assign(user, updates);
        return user;
      }

      delete(id: string): boolean {
        const index = this.users.findIndex(u => u.id === parseInt(id));
        if (index === -1) return false;
        this.users.splice(index, 1);
        return true;
      }
    }

    // Generic class
    class Result<T, E = Error> {
      private constructor(
        private value?: T,
        private error?: E
      ) {}

      static ok<T, E = Error>(value: T): Result<T, E> {
        return new Result(value);
      }

      static err<T, E = Error>(error: E): Result<T, E> {
        return new Result(undefined, error);
      }

      isOk(): boolean {
        return this.value !== undefined;
      }

      isErr(): boolean {
        return this.error !== undefined;
      }

      unwrap(): T {
        if (this.value === undefined) {
          throw new Error("Called unwrap on an error result");
        }
        return this.value;
      }
    }

    // Usage
    function divide(a: number, b: number): Result<number, string> {
      if (b === 0) {
        return Result.err("Division by zero");
      }
      return Result.ok(a / b);
    }

    const result1 = divide(10, 2);
    if (result1.isOk()) {
      console.log(result1.unwrap());  // 5
    }

    const result2 = divide(10, 0);
    if (result2.isErr()) {
      console.log("Error occurred");
    }
    ```

    ## Union and Intersection Types

    ### Union Types

    ```typescript
    // Union: value can be ONE of the types
    type ID = string | number;

    function printId(id: ID) {
      console.log(`ID: ${id}`);
    }

    printId(101);      // OK
    printId("abc123"); // OK
    printId(true);     // ❌ Error: boolean not assignable

    // Discriminated unions (tagged unions)
    interface Circle {
      kind: "circle";
      radius: number;
    }

    interface Square {
      kind: "square";
      sideLength: number;
    }

    interface Rectangle {
      kind: "rectangle";
      width: number;
      height: number;
    }

    type Shape = Circle | Square | Rectangle;

    function getArea(shape: Shape): number {
      // TypeScript narrows the type based on 'kind'
      switch (shape.kind) {
        case "circle":
          return Math.PI * shape.radius ** 2;
        case "square":
          return shape.sideLength ** 2;
        case "rectangle":
          return shape.width * shape.height;
      }
    }

    // Exhaustiveness checking
    function assertNever(x: never): never {
      throw new Error("Unexpected value: " + x);
    }

    function getAreaExhaustive(shape: Shape): number {
      switch (shape.kind) {
        case "circle":
          return Math.PI * shape.radius ** 2;
        case "square":
          return shape.sideLength ** 2;
        case "rectangle":
          return shape.width * shape.height;
        default:
          return assertNever(shape);  // Ensures all cases handled
      }
    }
    ```

    ### Intersection Types

    ```typescript
    // Intersection: value must have ALL properties
    interface HasName {
      name: string;
    }

    interface HasAge {
      age: number;
    }

    type Person = HasName & HasAge;

    const person: Person = {
      name: "Alice",
      age: 30
    };

    // Combining multiple types
    interface Timestamped {
      createdAt: Date;
      updatedAt: Date;
    }

    interface Identifiable {
      id: string;
    }

    type Entity<T> = T & Identifiable & Timestamped;

    interface Product {
      name: string;
      price: number;
    }

    const product: Entity<Product> = {
      id: "prod-123",
      name: "Laptop",
      price: 999,
      createdAt: new Date(),
      updatedAt: new Date()
    };
    ```

    ## Type Guards and Narrowing

    ### typeof Type Guards

    ```typescript
    function processValue(value: string | number) {
      if (typeof value === "string") {
        // Type narrowed to string
        return value.toUpperCase();
      } else {
        // Type narrowed to number
        return value.toFixed(2);
      }
    }
    ```

    ### instanceof Type Guards

    ```typescript
    class Dog {
      bark() {
        console.log("Woof!");
      }
    }

    class Cat {
      meow() {
        console.log("Meow!");
      }
    }

    function makeSound(animal: Dog | Cat) {
      if (animal instanceof Dog) {
        animal.bark();  // Type: Dog
      } else {
        animal.meow();  // Type: Cat
      }
    }
    ```

    ### Custom Type Guards

    ```typescript
    interface User {
      name: string;
      email: string;
    }

    interface Admin extends User {
      permissions: string[];
    }

    // Type predicate
    function isAdmin(user: User): user is Admin {
      return "permissions" in user;
    }

    function processUser(user: User) {
      if (isAdmin(user)) {
        // Type narrowed to Admin
        console.log(user.permissions);
      } else {
        // Type: User
        console.log(user.email);
      }
    }

    // Nullish value guard
    function isDefined<T>(value: T | null | undefined): value is T {
      return value !== null && value !== undefined;
    }

    const values = [1, null, 2, undefined, 3];
    const defined = values.filter(isDefined);  // Type: number[]
    ```

    ### in Operator Narrowing

    ```typescript
    interface Bird {
      fly(): void;
      layEggs(): void;
    }

    interface Fish {
      swim(): void;
      layEggs(): void;
    }

    function move(animal: Bird | Fish) {
      if ("fly" in animal) {
        animal.fly();  // Type: Bird
      } else {
        animal.swim();  // Type: Fish
      }
    }
    ```

    ## Utility Types

    TypeScript provides built-in utility types for common type transformations.

    ### Partial<T>

    ```typescript
    // Makes all properties optional
    interface User {
      id: number;
      name: string;
      email: string;
      age: number;
    }

    // Only need to provide some properties
    function updateUser(id: number, updates: Partial<User>) {
      // Implementation
    }

    updateUser(1, { name: "Alice" });  // OK
    updateUser(1, { email: "alice@example.com", age: 30 });  // OK
    ```

    ### Required<T>

    ```typescript
    // Makes all properties required
    interface Config {
      host?: string;
      port?: number;
      debug?: boolean;
    }

    const defaultConfig: Required<Config> = {
      host: "localhost",  // Required!
      port: 3000,         // Required!
      debug: false        // Required!
    };
    ```

    ### Readonly<T>

    ```typescript
    // Makes all properties readonly
    interface MutableUser {
      name: string;
      age: number;
    }

    const user: Readonly<MutableUser> = {
      name: "Alice",
      age: 30
    };

    user.name = "Bob";  // ❌ Error: Cannot assign to 'name' (readonly)
    ```

    ### Pick<T, K>

    ```typescript
    // Pick specific properties
    interface User {
      id: number;
      name: string;
      email: string;
      password: string;
      createdAt: Date;
    }

    // Only expose safe properties
    type PublicUser = Pick<User, "id" | "name" | "email">;

    const publicUser: PublicUser = {
      id: 1,
      name: "Alice",
      email: "alice@example.com"
      // password not needed!
    };
    ```

    ### Omit<T, K>

    ```typescript
    // Omit specific properties
    type UserWithoutPassword = Omit<User, "password">;

    const user: UserWithoutPassword = {
      id: 1,
      name: "Alice",
      email: "alice@example.com",
      createdAt: new Date()
      // password omitted!
    };
    ```

    ### Record<K, T>

    ```typescript
    // Create object type with specific keys and value type
    type UserRoles = Record<string, string[]>;

    const roles: UserRoles = {
      admin: ["read", "write", "delete"],
      user: ["read"],
      guest: []
    };

    // Map user IDs to users
    type UserMap = Record<number, User>;

    const users: UserMap = {
      1: { id: 1, name: "Alice", email: "alice@example.com", password: "***", createdAt: new Date() },
      2: { id: 2, name: "Bob", email: "bob@example.com", password: "***", createdAt: new Date() }
    };
    ```

    ### ReturnType<T>

    ```typescript
    // Extract return type of function
    function getUser() {
      return {
        id: 1,
        name: "Alice",
        email: "alice@example.com"
      };
    }

    type User = ReturnType<typeof getUser>;
    // Type: { id: number; name: string; email: string; }
    ```

    ### Exclude<T, U> and Extract<T, U>

    ```typescript
    // Exclude: Remove types from union
    type Status = "pending" | "approved" | "rejected" | "cancelled";
    type ActiveStatus = Exclude<Status, "cancelled">;
    // Type: "pending" | "approved" | "rejected"

    // Extract: Keep only matching types
    type SuccessStatus = Extract<Status, "approved" | "completed">;
    // Type: "approved"
    ```

    ## Real-World Example: Type-Safe API Client

    ```typescript
    // API response types
    interface ApiResponse<T> {
      data: T;
      status: number;
      message: string;
    }

    type HttpMethod = "GET" | "POST" | "PUT" | "DELETE";

    // Generic API client
    class ApiClient {
      constructor(private baseUrl: string) {}

      private async request<T>(
        method: HttpMethod,
        endpoint: string,
        body?: unknown
      ): Promise<ApiResponse<T>> {
        const response = await fetch(`${this.baseUrl}${endpoint}`, {
          method,
          headers: { "Content-Type": "application/json" },
          body: body ? JSON.stringify(body) : undefined
        });

        return response.json();
      }

      async get<T>(endpoint: string): Promise<ApiResponse<T>> {
        return this.request<T>("GET", endpoint);
      }

      async post<T, U = unknown>(
        endpoint: string,
        body: U
      ): Promise<ApiResponse<T>> {
        return this.request<T>("POST", endpoint, body);
      }

      async put<T, U = unknown>(
        endpoint: string,
        body: U
      ): Promise<ApiResponse<T>> {
        return this.request<T>("PUT", endpoint, body);
      }

      async delete<T>(endpoint: string): Promise<ApiResponse<T>> {
        return this.request<T>("DELETE", endpoint);
      }
    }

    // Usage
    interface User {
      id: number;
      name: string;
      email: string;
    }

    interface CreateUserDTO {
      name: string;
      email: string;
      password: string;
    }

    const api = new ApiClient("https://api.example.com");

    // Fully type-safe!
    const usersResponse = await api.get<User[]>("/users");
    console.log(usersResponse.data[0].name);  // Type: string

    const newUserResponse = await api.post<User, CreateUserDTO>("/users", {
      name: "Alice",
      email: "alice@example.com",
      password: "secret123"
    });
    console.log(newUserResponse.data.id);  // Type: number
    ```

    ## Interview Tips

    1. **Generics enable reusable, type-safe code**
    2. **Use constraints** (`<T extends Type>`) to limit generic types
    3. **Discriminated unions** are powerful for state management
    4. **Type guards** enable type narrowing and safer code
    5. **Utility types** save time - learn the built-in ones
    6. **ReturnType, Parameters** are useful for extracting types
    7. **Generics in React**: `useState<Type>()`, `useRef<Type>()`

    **Next**: We'll learn TypeScript in practice with real-world scenarios!
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Lesson 3 ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 3',
  content: <<~MARKDOWN,
# Microlesson 🚀

# TypeScript in Practice

    Learn how to use TypeScript in real-world projects with React, Node.js, and proper configuration.

    ## Project Configuration

    ### tsconfig.json

    **The TypeScript compiler configuration file**

    ```json
    {
      "compilerOptions": {
        // Language and Environment
        "target": "ES2020",                    // Output JavaScript version
        "lib": ["ES2020", "DOM"],              // Available APIs
        "jsx": "react-jsx",                    // JSX support for React

        // Modules
        "module": "ESNext",                    // Module system
        "moduleResolution": "node",            // How to resolve modules
        "resolveJsonModule": true,             // Import JSON files
        "baseUrl": ".",                        // Base directory for imports
        "paths": {                             // Path aliases
          "@components/*": ["src/components/*"],
          "@utils/*": ["src/utils/*"]
        },

        // Emit
        "outDir": "./dist",                    // Output directory
        "declaration": true,                   // Generate .d.ts files
        "declarationMap": true,                // Sourcemaps for .d.ts
        "sourceMap": true,                     // Generate .map files
        "removeComments": true,                // Remove comments in output

        // Type Checking (STRICT MODE - RECOMMENDED!)
        "strict": true,                        // Enable all strict checks
        "noImplicitAny": true,                 // Error on implicit 'any'
        "strictNullChecks": true,              // null/undefined are not valid values
        "strictFunctionTypes": true,           // Strict function type checking
        "strictBindCallApply": true,           // Strict bind/call/apply
        "noImplicitThis": true,                // Error on implicit 'this'
        "alwaysStrict": true,                  // Use strict mode

        // Additional Checks
        "noUnusedLocals": true,                // Error on unused variables
        "noUnusedParameters": true,            // Error on unused parameters
        "noImplicitReturns": true,             // Error if not all paths return
        "noFallthroughCasesInSwitch": true,    // Error on switch fallthrough

        // Interop
        "esModuleInterop": true,               // CommonJS/ES6 interop
        "allowSyntheticDefaultImports": true,  // Allow default imports
        "forceConsistentCasingInFileNames": true,  // Consistent file casing
        "skipLibCheck": true                   // Skip type checking of .d.ts files
      },
      "include": [
        "src/**/*"                             // Files to compile
      ],
      "exclude": [
        "node_modules",                        // Ignore node_modules
        "dist",                                // Ignore output
        "**/*.spec.ts"                         // Ignore test files
      ]
    }
    ```

    ### Project Setup

    ```bash
    # Initialize TypeScript project
    npm init -y
    npm install --save-dev typescript @types/node

    # Generate tsconfig.json
    npx tsc --init

    # Install type definitions
    npm install --save-dev @types/express @types/react @types/jest

    # Compile TypeScript
    npx tsc

    # Watch mode
    npx tsc --watch
    ```

    ## TypeScript with React

    ### Component Types

    ```typescript
    import React, { useState, useEffect, useRef } from 'react';

    // Props interface
    interface UserCardProps {
      name: string;
      age: number;
      email: string;
      onEdit?: (id: string) => void;  // Optional callback
      children?: React.ReactNode;     // Children prop
    }

    // Function component (preferred)
    const UserCard: React.FC<UserCardProps> = ({
      name,
      age,
      email,
      onEdit,
      children
    }) => {
      const [isEditing, setIsEditing] = useState<boolean>(false);

      return (
        <div className="user-card">
          <h2>{name}</h2>
          <p>Age: {age}</p>
          <p>Email: {email}</p>
          {onEdit && (
            <button onClick={() => onEdit("123")}>Edit</button>
          )}
          {children}
        </div>
      );
    };

    // Alternative: Function without React.FC (more common now)
    function UserCard2(props: UserCardProps) {
      return <div>{props.name}</div>;
    }

    // Usage
    <UserCard
      name="Alice"
      age={30}
      email="alice@example.com"
      onEdit={(id) => console.log(id)}
    >
      <p>Additional info</p>
    </UserCard>
    ```

    ### Hooks with TypeScript

    ```typescript
    import React, { useState, useEffect, useRef, useContext } from 'react';

    // useState
    function Counter() {
      const [count, setCount] = useState<number>(0);
      const [user, setUser] = useState<User | null>(null);

      return (
        <button onClick={() => setCount(count + 1)}>
          Count: {count}
        </button>
      );
    }

    // useEffect
    function DataFetcher() {
      const [data, setData] = useState<User[]>([]);
      const [loading, setLoading] = useState<boolean>(true);
      const [error, setError] = useState<Error | null>(null);

      useEffect(() => {
        async function fetchData() {
          try {
            const response = await fetch('/api/users');
            const users: User[] = await response.json();
            setData(users);
          } catch (err) {
            setError(err as Error);
          } finally {
            setLoading(false);
          }
        }

        fetchData();
      }, []);  // Dependency array

      if (loading) return <div>Loading...</div>;
      if (error) return <div>Error: {error.message}</div>;

      return (
        <ul>
          {data.map(user => (
            <li key={user.id}>{user.name}</li>
          ))}
        </ul>
      );
    }

    // useRef
    function TextInput() {
      const inputRef = useRef<HTMLInputElement>(null);

      const focusInput = () => {
        inputRef.current?.focus();  // Optional chaining
      };

      return (
        <>
          <input ref={inputRef} type="text" />
          <button onClick={focusInput}>Focus Input</button>
        </>
      );
    }

    // useContext
    interface ThemeContextType {
      theme: 'light' | 'dark';
      toggleTheme: () => void;
    }

    const ThemeContext = React.createContext<ThemeContextType | undefined>(
      undefined
    );

    function useTheme() {
      const context = useContext(ThemeContext);
      if (!context) {
        throw new Error('useTheme must be used within ThemeProvider');
      }
      return context;
    }

    // Custom hook
    function useLocalStorage<T>(key: string, initialValue: T) {
      const [value, setValue] = useState<T>(() => {
        const item = window.localStorage.getItem(key);
        return item ? JSON.parse(item) : initialValue;
      });

      useEffect(() => {
        window.localStorage.setItem(key, JSON.stringify(value));
      }, [key, value]);

      return [value, setValue] as const;  // Tuple type
    }

    // Usage
    function Settings() {
      const [username, setUsername] = useLocalStorage<string>('username', '');

      return (
        <input
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
      );
    }
    ```

    ### Event Handling

    ```typescript
    import React from 'react';

    function Form() {
      const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        console.log('Form submitted');
      };

      const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        console.log(e.target.value);
      };

      const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
        console.log('Button clicked');
      };

      const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
        if (e.key === 'Enter') {
          console.log('Enter pressed');
        }
      };

      return (
        <form onSubmit={handleSubmit}>
          <input
            type="text"
            onChange={handleChange}
            onKeyDown={handleKeyDown}
          />
          <button onClick={handleClick}>Submit</button>
        </form>
      );
    }
    ```

    ## TypeScript with Node.js/Express

    ### Express Server

    ```typescript
    import express, { Request, Response, NextFunction } from 'express';

    const app = express();
    app.use(express.json());

    // Type-safe request handlers
    interface User {
      id: number;
      name: string;
      email: string;
    }

    // GET endpoint
    app.get('/api/users', (req: Request, res: Response) => {
      const users: User[] = [
        { id: 1, name: 'Alice', email: 'alice@example.com' },
        { id: 2, name: 'Bob', email: 'bob@example.com' }
      ];
      res.json(users);
    });

    // POST endpoint with typed body
    interface CreateUserBody {
      name: string;
      email: string;
      password: string;
    }

    app.post('/api/users', (req: Request<{}, {}, CreateUserBody>, res: Response) => {
      const { name, email, password } = req.body;

      // Validation
      if (!name || !email || !password) {
        return res.status(400).json({ error: 'Missing required fields' });
      }

      const newUser: User = {
        id: Date.now(),
        name,
        email
      };

      res.status(201).json(newUser);
    });

    // GET with params
    app.get('/api/users/:id', (
      req: Request<{ id: string }>,
      res: Response
    ) => {
      const userId = parseInt(req.id);
      // Find user logic
      res.json({ id: userId });
    });

    // Middleware
    const authMiddleware = (
      req: Request,
      res: Response,
      next: NextFunction
    ) => {
      const token = req.headers.authorization;

      if (!token) {
        return res.status(401).json({ error: 'No token provided' });
      }

      // Verify token logic
      next();
    };

    app.use('/api/protected', authMiddleware);

    // Error handling middleware
    app.use((
      err: Error,
      req: Request,
      res: Response,
      next: NextFunction
    ) => {
      console.error(err.stack);
      res.status(500).json({ error: 'Internal server error' });
    });

    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });
    ```

    ### Async/Await with TypeScript

    ```typescript
    // Database operations
    interface DbUser {
      id: number;
      name: string;
      email: string;
      createdAt: Date;
    }

    class UserService {
      async findById(id: number): Promise<DbUser | null> {
        try {
          // Simulated database query
          const user = await db.query<DbUser>(
            'SELECT * FROM users WHERE id = $1',
            [id]
          );
          return user || null;
        } catch (error) {
          console.error('Database error:', error);
          throw new Error('Failed to fetch user');
        }
      }

      async create(data: Omit<DbUser, 'id' | 'createdAt'>): Promise<DbUser> {
        const now = new Date();
        const user = await db.query<DbUser>(
          'INSERT INTO users (name, email, created_at) VALUES ($1, $2, $3) RETURNING *',
          [data.name, data.email, now]
        );
        return user;
      }

      async findAll(): Promise<DbUser[]> {
        const users = await db.query<DbUser[]>('SELECT * FROM users');
        return users;
      }
    }
    ```

    ## Migration Strategies

    ### Gradual Migration from JavaScript

    ```typescript
    // Step 1: Rename .js to .ts (start with leaf files)
    // user.js → user.ts

    // Step 2: Allow implicit any (temporarily)
    // tsconfig.json: "noImplicitAny": false

    // Step 3: Add basic types
    // Before (JavaScript)
    function getUser(id) {
      return users.find(u => u.id === id);
    }

    // After (TypeScript - basic)
    function getUser(id: number): User | undefined {
      return users.find(u => u.id === id);
    }

    // Step 4: Add strict null checks gradually
    // tsconfig.json: "strictNullChecks": true

    // Step 5: Enable all strict checks
    // tsconfig.json: "strict": true

    // Step 6: Fix errors one by one
    // Use @ts-ignore sparingly for legacy code:
    // @ts-ignore
    const legacy = oldLibrary.method();
    ```

    ### Type Definitions for JavaScript Libraries

    ```typescript
    // Install type definitions
    npm install --save-dev @types/lodash
    npm install --save-dev @types/express
    npm install --save-dev @types/node

    // If types don't exist, create declaration file
    // types/my-library.d.ts
    declare module 'my-library' {
      export function doSomething(value: string): number;
      export interface Config {
        apiKey: string;
        timeout: number;
      }
    }

    // Ambient declarations for global variables
    // globals.d.ts
    declare global {
      interface Window {
        myCustomProperty: string;
      }

      const API_URL: string;
    }

    export {};
    ```

    ## Best Practices

    ### 1. Use Strict Mode

    ```json
    {
      "compilerOptions": {
        "strict": true,
        "noImplicitAny": true,
        "strictNullChecks": true
      }
    }
    ```

    ### 2. Avoid any, Use unknown

    ```typescript
    // Bad
    function process(data: any) {
      return data.value;  // No type checking!
    }

    // Good
    function process(data: unknown) {
      if (typeof data === 'object' && data !== null && 'value' in data) {
        return (data as { value: string }).value;
      }
      throw new Error('Invalid data');
    }
    ```

    ### 3. Use const assertions

    ```typescript
    // Without const assertion
    const config = {
      apiUrl: 'https://api.example.com',
      timeout: 5000
    };
    // Type: { apiUrl: string; timeout: number; }

    // With const assertion
    const config = {
      apiUrl: 'https://api.example.com',
      timeout: 5000
    } as const;
    // Type: { readonly apiUrl: "https://api.example.com"; readonly timeout: 5000; }

    // Const assertion for arrays
    const colors = ['red', 'green', 'blue'] as const;
    // Type: readonly ["red", "green", "blue"]
    type Color = typeof colors[number];  // "red" | "green" | "blue"
    ```

    ### 4. Use Template Literal Types

    ```typescript
    // Create type-safe string patterns
    type EventName = 'click' | 'focus' | 'blur';
    type EventHandlerName = `on${Capitalize<EventName>}`;
    // Type: "onClick" | "onFocus" | "onBlur"

    // HTTP methods with paths
    type HttpMethod = 'GET' | 'POST' | 'PUT' | 'DELETE';
    type Route = '/users' | '/posts' | '/comments';
    type Endpoint = `${HttpMethod} ${Route}`;
    // Type: "GET /users" | "GET /posts" | ... (12 combinations)
    ```

    ### 5. Organize Types

    ```typescript
    // types/user.ts
    export interface User {
      id: number;
      name: string;
      email: string;
    }

    export type CreateUserDTO = Omit<User, 'id'>;
    export type UpdateUserDTO = Partial<CreateUserDTO>;

    // types/api.ts
    export interface ApiResponse<T> {
      data: T;
      status: number;
      message: string;
    }

    export type ApiError = {
      status: number;
      message: string;
      errors?: Record<string, string[]>;
    };

    // Import in other files
    import { User, CreateUserDTO } from './types/user';
    import { ApiResponse } from './types/api';
    ```

    ### 6. Use Discriminated Unions for State

    ```typescript
    // Type-safe state management
    type LoadingState<T> =
      | { status: 'idle' }
      | { status: 'loading' }
      | { status: 'success'; data: T }
      | { status: 'error'; error: Error };

    function DataComponent() {
      const [state, setState] = useState<LoadingState<User[]>>({
        status: 'idle'
      });

      // TypeScript narrows the type based on status
      if (state.status === 'loading') {
        return <div>Loading...</div>;
      }

      if (state.status === 'error') {
        return <div>Error: {state.error.message}</div>;
      }

      if (state.status === 'success') {
        return (
          <ul>
            {state.data.map(user => (
              <li key={user.id}>{user.name}</li>
            ))}
          </ul>
        );
      }

      return <button onClick={fetchData}>Load Data</button>;
    }
    ```

    ## Common Pitfalls and Solutions

    ### 1. Optional Chaining

    ```typescript
    // Before
    const city = user && user.address && user.address.city;

    // After (TypeScript 3.7+)
    const city = user?.address?.city;
    ```

    ### 2. Nullish Coalescing

    ```typescript
    // Before (falsy values treated as null)
    const value = user.count || 10;  // Problem: 0 is falsy!

    // After (only null/undefined)
    const value = user.count ?? 10;  // Only replaces null/undefined
    ```

    ### 3. Type vs Interface

    ```typescript
    // Use interface for object shapes
    interface User {
      id: number;
      name: string;
    }

    // Use type for unions, intersections, primitives
    type ID = string | number;
    type Result = Success | Error;
    ```

    ## Interview Tips

    1. **Know tsconfig.json options** - especially strict mode
    2. **Generics are powerful** - use them for reusable code
    3. **Type guards enable narrowing** - typeof, instanceof, custom
    4. **Utility types save time** - Partial, Pick, Omit, Record
    5. **React: avoid React.FC** - modern apps use direct function types
    6. **Express: type Request generics** - Request<Params, ResBody, ReqBody>
    7. **Migration: gradual is ok** - start with allowJs, add types incrementally
    8. **Avoid any** - use unknown when type is truly unknown
    9. **Use const assertions** - for literal types and readonly
    10. **Discriminated unions** - perfect for state management

    ## Resources

    - **Official Docs**: https://www.typescriptlang.org/docs/
    - **TypeScript Playground**: https://www.typescriptlang.org/play
    - **React TypeScript Cheatsheet**: https://react-typescript-cheatsheet.netlify.app/
    - **Type Challenges**: https://github.com/type-challenges/type-challenges

    **You now have the TypeScript skills to build type-safe, scalable applications!**
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 4: Lesson 4 ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 4',
  content: <<~MARKDOWN,
# Microlesson 🚀

# TypeScript Fundamentals and Type System

    **TypeScript** is JavaScript with syntax for types. It's a strongly typed superset of JavaScript that compiles to plain JavaScript.

    ## Why TypeScript?

    ### JavaScript Pain Points

    ```javascript
    // JavaScript - No type safety
    function add(a, b) {
      return a + b;
    }

    add(5, 10);        // 15 ✓
    add("5", "10");    // "510" - String concatenation!
    add(5, "10");      // "510" - Type coercion!
    add({}, []);       // "[object Object]" - WTF?
    ```

    ### TypeScript Solution

    ```typescript
    // TypeScript - Type safety
    function add(a: number, b: number): number {
      return a + b;
    }

    add(5, 10);        // 15 ✓
    add("5", "10");    // ❌ Error: Argument of type 'string' not assignable to 'number'
    add(5, "10");      // ❌ Error: Argument of type 'string' not assignable to 'number'
    ```

    **Benefits:**
    - Catch errors at compile time (not runtime!)
    - Better IDE support (autocomplete, refactoring)
    - Self-documenting code
    - Easier refactoring and maintenance

    ## Basic Types

    ### Primitive Types

    ```typescript
    // String
    let name: string = "Alice";
    let greeting: string = `Hello, ${name}`;

    // Number (int, float, hex, binary all are number)
    let age: number = 30;
    let price: number = 99.99;
    let hex: number = 0xf00d;
    let binary: number = 0b1010;

    // Boolean
    let isDone: boolean = false;
    let isActive: boolean = true;

    // Null and Undefined
    let nothing: null = null;
    let notDefined: undefined = undefined;

    // Any (avoid when possible!)
    let anything: any = "string";
    anything = 42;        // OK
    anything = true;      // OK
    anything = {};        // OK - defeats purpose of TypeScript!
    ```

    ### Arrays

    ```typescript
    // Array of numbers
    let numbers: number[] = [1, 2, 3, 4, 5];
    let nums: Array<number> = [1, 2, 3];  // Alternative syntax

    // Array of strings
    let names: string[] = ["Alice", "Bob", "Charlie"];

    // Mixed array (avoid!)
    let mixed: any[] = [1, "two", true];

    // Array methods are type-safe
    numbers.push(6);        // OK
    numbers.push("7");      // ❌ Error: Argument of type 'string' not assignable

    // Array operations
    const doubled = numbers.map(n => n * 2);  // Type: number[]
    const evens = numbers.filter(n => n % 2 === 0);  // Type: number[]
    ```

    ### Tuples

    **Fixed-length arrays with specific types**

    ```typescript
    // Tuple: [string, number]
    let person: [string, number] = ["Alice", 30];

    console.log(person[0].toUpperCase());  // "ALICE" - knows it's a string
    console.log(person[1].toFixed(2));     // "30.00" - knows it's a number

    // Error: Wrong types
    person = [30, "Alice"];  // ❌ Error: Type 'number' not assignable to 'string'

    // Error: Wrong length
    person = ["Alice", 30, true];  // ❌ Error: Type '[string, number, boolean]' not assignable

    // Common use case: React hooks
    const [count, setCount]: [number, (n: number) => void] = useState(0);

    // Multiple return values
    function getCoordinates(): [number, number] {
      return [10, 20];
    }

    const [x, y] = getCoordinates();  // x: number, y: number
    ```

    ### Enums

    **Named constants**

    ```typescript
    // Numeric enum (default)
    enum Direction {
      Up,      // 0
      Down,    // 1
      Left,    // 2
      Right    // 3
    }

    let dir: Direction = Direction.Up;
    console.log(dir);  // 0

    // String enum (recommended)
    enum Status {
      Pending = "PENDING",
      Approved = "APPROVED",
      Rejected = "REJECTED"
    }

    function updateStatus(status: Status) {
      console.log(`Status updated to: ${status}`);
    }

    updateStatus(Status.Approved);  // "Status updated to: APPROVED"
    updateStatus("APPROVED");       // ❌ Error: Argument type '"APPROVED"' not assignable

    // Enum with custom values
    enum HttpStatus {
      OK = 200,
      BadRequest = 400,
      Unauthorized = 401,
      NotFound = 404,
      ServerError = 500
    }

    // Const enum (better performance - inlined at compile time)
    const enum Color {
      Red = "#FF0000",
      Green = "#00FF00",
      Blue = "#0000FF"
    }
    ```

    ## Type Inference

    **TypeScript infers types automatically**

    ```typescript
    // Explicit type annotation
    let count: number = 10;

    // Type inference (preferred when obvious)
    let inferredCount = 10;  // Type: number (inferred)

    // Function return type inference
    function add(a: number, b: number) {
      return a + b;  // Return type inferred as number
    }

    // Array type inference
    let numbers = [1, 2, 3];  // Type: number[]
    let mixed = [1, "two"];   // Type: (string | number)[]

    // Object type inference
    let user = {
      name: "Alice",
      age: 30
    };
    // Type: { name: string; age: number; }

    user.name = "Bob";     // OK
    user.age = "thirty";   // ❌ Error: Type 'string' not assignable to 'number'
    ```

    **When to use explicit types:**
    - Function parameters (required)
    - Public API boundaries
    - When inference is unclear
    - When you want to enforce a specific type

    ## Type Annotations

    ### Function Types

    ```typescript
    // Function with type annotations
    function greet(name: string): string {
      return `Hello, ${name}!`;
    }

    // Arrow function
    const greet2 = (name: string): string => `Hello, ${name}!`;

    // Optional parameters
    function greet3(name: string, greeting?: string): string {
      return `${greeting || "Hello"}, ${name}!`;
    }

    greet3("Alice");           // "Hello, Alice!"
    greet3("Alice", "Hi");     // "Hi, Alice!"

    // Default parameters
    function greet4(name: string, greeting: string = "Hello"): string {
      return `${greeting}, ${name}!`;
    }

    // Rest parameters
    function sum(...numbers: number[]): number {
      return numbers.reduce((total, n) => total + n, 0);
    }

    sum(1, 2, 3, 4, 5);  // 15

    // Void return type (no return value)
    function log(message: string): void {
      console.log(message);
    }

    // Never return type (function never returns)
    function throwError(message: string): never {
      throw new Error(message);
    }

    function infiniteLoop(): never {
      while (true) {}
    }
    ```

    ### Object Types

    ```typescript
    // Object type annotation
    let user: { name: string; age: number; email?: string } = {
      name: "Alice",
      age: 30
    };

    // Optional property (email?)
    user.email = "alice@example.com";  // OK
    delete user.email;                 // OK

    // Readonly properties
    let config: { readonly apiKey: string; timeout: number } = {
      apiKey: "secret123",
      timeout: 5000
    };

    config.timeout = 10000;  // OK
    config.apiKey = "new";   // ❌ Error: Cannot assign to 'apiKey' (readonly)

    // Index signature (dynamic keys)
    let scores: { [key: string]: number } = {
      math: 95,
      english: 87,
      science: 92
    };

    scores.history = 88;  // OK - any string key allowed
    scores.math = "A";    // ❌ Error: Type 'string' not assignable to 'number'
    ```

    ## Interfaces vs Types

    ### Interfaces

    ```typescript
    // Interface definition
    interface User {
      id: number;
      name: string;
      email: string;
      age?: number;  // Optional
    }

    const user1: User = {
      id: 1,
      name: "Alice",
      email: "alice@example.com"
    };

    // Interface with methods
    interface Product {
      id: number;
      name: string;
      price: number;
      calculateDiscount(percentage: number): number;
    }

    const product: Product = {
      id: 1,
      name: "Laptop",
      price: 1000,
      calculateDiscount(percentage: number): number {
        return this.price * (percentage / 100);
      }
    };

    // Extending interfaces
    interface Employee {
      id: number;
      name: string;
    }

    interface Manager extends Employee {
      department: string;
      subordinates: Employee[];
    }

    const manager: Manager = {
      id: 1,
      name: "Bob",
      department: "Engineering",
      subordinates: []
    };

    // Interface merging (declaration merging)
    interface Window {
      customProperty: string;
    }

    interface Window {
      anotherProperty: number;
    }

    // Now Window has both properties
    window.customProperty = "value";
    window.anotherProperty = 42;
    ```

    ### Type Aliases

    ```typescript
    // Type alias
    type User = {
      id: number;
      name: string;
      email: string;
      age?: number;
    };

    // Union types (types only!)
    type ID = string | number;

    let userId: ID = 123;     // OK
    userId = "abc-123";       // OK

    // Intersection types
    type Person = {
      name: string;
      age: number;
    };

    type Employee = {
      employeeId: number;
      department: string;
    };

    type EmployeePerson = Person & Employee;

    const emp: EmployeePerson = {
      name: "Alice",
      age: 30,
      employeeId: 123,
      department: "Engineering"
    };

    // Literal types
    type Status = "pending" | "approved" | "rejected";
    type Direction = "north" | "south" | "east" | "west";

    let status: Status = "pending";    // OK
    status = "approved";               // OK
    status = "cancelled";              // ❌ Error: Type '"cancelled"' not assignable

    // Function type
    type MathOperation = (a: number, b: number) => number;

    const add: MathOperation = (a, b) => a + b;
    const subtract: MathOperation = (a, b) => a - b;
    ```

    ## Interfaces vs Types: When to Use What?

    ### Use Interfaces When:

    ```typescript
    // 1. Defining object shapes
    interface User {
      id: number;
      name: string;
    }

    // 2. Need to extend/inherit
    interface Admin extends User {
      permissions: string[];
    }

    // 3. Working with classes
    class UserAccount implements User {
      constructor(public id: number, public name: string) {}
    }

    // 4. Want declaration merging
    interface Config {
      apiUrl: string;
    }

    interface Config {
      timeout: number;
    }
    ```

    ### Use Types When:

    ```typescript
    // 1. Union types
    type Result = Success | Error;

    // 2. Intersection types
    type Combined = TypeA & TypeB;

    // 3. Primitive aliases
    type ID = string | number;

    // 4. Tuple types
    type Point = [number, number];

    // 5. Function types
    type Callback = (data: string) => void;

    // 6. Mapped types
    type Readonly<T> = {
      readonly [P in keyof T]: T[P];
    };
    ```

    **General rule:** Use `interface` for object shapes and public APIs. Use `type` for unions, intersections, and utility types.

    ## Real-World Example: User Management

    ```typescript
    // Types and interfaces
    type UserRole = "admin" | "user" | "guest";

    interface BaseUser {
      id: string;
      email: string;
      createdAt: Date;
    }

    interface User extends BaseUser {
      name: string;
      role: UserRole;
      isActive: boolean;
    }

    interface UserWithProfile extends User {
      profile: {
        bio?: string;
        avatar?: string;
        location?: string;
      };
    }

    // Function implementations
    function createUser(
      email: string,
      name: string,
      role: UserRole = "user"
    ): User {
      return {
        id: generateId(),
        email,
        name,
        role,
        isActive: true,
        createdAt: new Date()
      };
    }

    function updateUser(
      userId: string,
      updates: Partial<User>
    ): User | null {
      // Implementation
      const user = findUserById(userId);
      if (!user) return null;

      return { ...user, ...updates };
    }

    function findUsersByRole(role: UserRole): User[] {
      // Type-safe database query
      return users.filter(u => u.role === role);
    }

    // Usage
    const newUser = createUser("alice@example.com", "Alice", "admin");
    const updated = updateUser(newUser.id, { isActive: false });
    const admins = findUsersByRole("admin");
    ```

    ## Type Assertions

    ```typescript
    // Type assertion (when you know more than TypeScript)
    let someValue: any = "this is a string";

    // Angle-bracket syntax
    let strLength1: number = (<string>someValue).length;

    // As syntax (preferred, required in JSX)
    let strLength2: number = (someValue as string).length;

    // Common use case: DOM elements
    const input = document.getElementById("email") as HTMLInputElement;
    input.value = "alice@example.com";  // OK - knows it's an input

    // Non-null assertion (!)
    function processUser(user: User | null) {
      // If you're SURE it's not null
      console.log(user!.name);  // Tell TS: trust me, it's not null
    }
    ```

    ## Interview Tips

    1. **Always prefer type inference when obvious**
    2. **Use strict mode** (`strict: true` in tsconfig.json)
    3. **Avoid `any`** - use `unknown` if type is truly unknown
    4. **Interfaces for objects, types for everything else**
    5. **Enums vs union types**: String unions are often simpler
    6. **Optional chaining**: `user?.profile?.bio`
    7. **Nullish coalescing**: `value ?? defaultValue`

    **Next**: We'll explore generics and advanced type features!
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 5: Lesson 5 ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 5',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Generics and Advanced Types

    **Generics** allow you to write reusable, type-safe code that works with multiple types.

    ## Why Generics?

    ### Without Generics

    ```typescript
    // Specific to numbers
    function identityNumber(arg: number): number {
      return arg;
    }

    // Specific to strings
    function identityString(arg: string): string {
      return arg;
    }

    // Using any (loses type safety!)
    function identityAny(arg: any): any {
      return arg;
    }

    const result = identityAny("hello");
    result.toUpperCase();  // No autocomplete, no type checking!
    ```

    ### With Generics

    ```typescript
    // Generic function - works with any type
    function identity<T>(arg: T): T {
      return arg;
    }

    // Type is inferred
    const num = identity(42);           // Type: number
    const str = identity("hello");      // Type: string
    const bool = identity(true);        // Type: boolean

    // Explicit type parameter
    const explicit = identity<string>("hello");

    // Full type safety!
    str.toUpperCase();  // ✓ Autocomplete works
    str.toFixed();      // ❌ Error: Property 'toFixed' does not exist on string
    ```

    ## Generic Functions

    ### Basic Generic Function

    ```typescript
    // Generic array reversal
    function reverse<T>(items: T[]): T[] {
      return items.reverse();
    }

    const numbers = reverse([1, 2, 3]);      // Type: number[]
    const strings = reverse(["a", "b", "c"]);  // Type: string[]

    // Generic with multiple type parameters
    function pair<T, U>(first: T, second: U): [T, U] {
      return [first, second];
    }

    const p1 = pair("age", 30);           // Type: [string, number]
    const p2 = pair(true, "active");      // Type: [boolean, string]

    // Generic with constraints
    interface HasLength {
      length: number;
    }

    function logLength<T extends HasLength>(arg: T): T {
      console.log(arg.length);  // OK - T guaranteed to have length
      return arg;
    }

    logLength("hello");        // OK - string has length
    logLength([1, 2, 3]);      // OK - array has length
    logLength({ length: 10 }); // OK - object has length
    logLength(42);             // ❌ Error: number doesn't have length
    ```

    ### Real-World Generic Examples

    ```typescript
    // API response wrapper
    interface ApiResponse<T> {
      data: T;
      status: number;
      message: string;
    }

    interface User {
      id: number;
      name: string;
      email: string;
    }

    async function fetchUser(id: number): Promise<ApiResponse<User>> {
      const response = await fetch(`/api/users/${id}`);
      return response.json();
    }

    // Usage
    const userResponse = await fetchUser(1);
    console.log(userResponse.data.name);  // Type-safe: knows data is User

    // Generic cache
    class Cache<T> {
      private data: Map<string, T> = new Map();

      set(key: string, value: T): void {
        this.data.set(key, value);
      }

      get(key: string): T | undefined {
        return this.data.get(key);
      }

      has(key: string): boolean {
        return this.data.has(key);
      }
    }

    // Type-safe caches
    const userCache = new Cache<User>();
    userCache.set("user1", { id: 1, name: "Alice", email: "alice@example.com" });
    const user = userCache.get("user1");  // Type: User | undefined

    const numberCache = new Cache<number>();
    numberCache.set("count", 42);
    const count = numberCache.get("count");  // Type: number | undefined
    ```

    ## Generic Interfaces and Classes

    ```typescript
    // Generic interface
    interface Repository<T> {
      findById(id: string): T | null;
      findAll(): T[];
      create(item: T): T;
      update(id: string, item: Partial<T>): T | null;
      delete(id: string): boolean;
    }

    // Implementation
    class UserRepository implements Repository<User> {
      private users: User[] = [];

      findById(id: string): User | null {
        return this.users.find(u => u.id === parseInt(id)) || null;
      }

      findAll(): User[] {
        return this.users;
      }

      create(user: User): User {
        this.users.push(user);
        return user;
      }

      update(id: string, updates: Partial<User>): User | null {
        const user = this.findById(id);
        if (!user) return null;
        Object.assign(user, updates);
        return user;
      }

      delete(id: string): boolean {
        const index = this.users.findIndex(u => u.id === parseInt(id));
        if (index === -1) return false;
        this.users.splice(index, 1);
        return true;
      }
    }

    // Generic class
    class Result<T, E = Error> {
      private constructor(
        private value?: T,
        private error?: E
      ) {}

      static ok<T, E = Error>(value: T): Result<T, E> {
        return new Result(value);
      }

      static err<T, E = Error>(error: E): Result<T, E> {
        return new Result(undefined, error);
      }

      isOk(): boolean {
        return this.value !== undefined;
      }

      isErr(): boolean {
        return this.error !== undefined;
      }

      unwrap(): T {
        if (this.value === undefined) {
          throw new Error("Called unwrap on an error result");
        }
        return this.value;
      }
    }

    // Usage
    function divide(a: number, b: number): Result<number, string> {
      if (b === 0) {
        return Result.err("Division by zero");
      }
      return Result.ok(a / b);
    }

    const result1 = divide(10, 2);
    if (result1.isOk()) {
      console.log(result1.unwrap());  // 5
    }

    const result2 = divide(10, 0);
    if (result2.isErr()) {
      console.log("Error occurred");
    }
    ```

    ## Union and Intersection Types

    ### Union Types

    ```typescript
    // Union: value can be ONE of the types
    type ID = string | number;

    function printId(id: ID) {
      console.log(`ID: ${id}`);
    }

    printId(101);      // OK
    printId("abc123"); // OK
    printId(true);     // ❌ Error: boolean not assignable

    // Discriminated unions (tagged unions)
    interface Circle {
      kind: "circle";
      radius: number;
    }

    interface Square {
      kind: "square";
      sideLength: number;
    }

    interface Rectangle {
      kind: "rectangle";
      width: number;
      height: number;
    }

    type Shape = Circle | Square | Rectangle;

    function getArea(shape: Shape): number {
      // TypeScript narrows the type based on 'kind'
      switch (shape.kind) {
        case "circle":
          return Math.PI * shape.radius ** 2;
        case "square":
          return shape.sideLength ** 2;
        case "rectangle":
          return shape.width * shape.height;
      }
    }

    // Exhaustiveness checking
    function assertNever(x: never): never {
      throw new Error("Unexpected value: " + x);
    }

    function getAreaExhaustive(shape: Shape): number {
      switch (shape.kind) {
        case "circle":
          return Math.PI * shape.radius ** 2;
        case "square":
          return shape.sideLength ** 2;
        case "rectangle":
          return shape.width * shape.height;
        default:
          return assertNever(shape);  // Ensures all cases handled
      }
    }
    ```

    ### Intersection Types

    ```typescript
    // Intersection: value must have ALL properties
    interface HasName {
      name: string;
    }

    interface HasAge {
      age: number;
    }

    type Person = HasName & HasAge;

    const person: Person = {
      name: "Alice",
      age: 30
    };

    // Combining multiple types
    interface Timestamped {
      createdAt: Date;
      updatedAt: Date;
    }

    interface Identifiable {
      id: string;
    }

    type Entity<T> = T & Identifiable & Timestamped;

    interface Product {
      name: string;
      price: number;
    }

    const product: Entity<Product> = {
      id: "prod-123",
      name: "Laptop",
      price: 999,
      createdAt: new Date(),
      updatedAt: new Date()
    };
    ```

    ## Type Guards and Narrowing

    ### typeof Type Guards

    ```typescript
    function processValue(value: string | number) {
      if (typeof value === "string") {
        // Type narrowed to string
        return value.toUpperCase();
      } else {
        // Type narrowed to number
        return value.toFixed(2);
      }
    }
    ```

    ### instanceof Type Guards

    ```typescript
    class Dog {
      bark() {
        console.log("Woof!");
      }
    }

    class Cat {
      meow() {
        console.log("Meow!");
      }
    }

    function makeSound(animal: Dog | Cat) {
      if (animal instanceof Dog) {
        animal.bark();  // Type: Dog
      } else {
        animal.meow();  // Type: Cat
      }
    }
    ```

    ### Custom Type Guards

    ```typescript
    interface User {
      name: string;
      email: string;
    }

    interface Admin extends User {
      permissions: string[];
    }

    // Type predicate
    function isAdmin(user: User): user is Admin {
      return "permissions" in user;
    }

    function processUser(user: User) {
      if (isAdmin(user)) {
        // Type narrowed to Admin
        console.log(user.permissions);
      } else {
        // Type: User
        console.log(user.email);
      }
    }

    // Nullish value guard
    function isDefined<T>(value: T | null | undefined): value is T {
      return value !== null && value !== undefined;
    }

    const values = [1, null, 2, undefined, 3];
    const defined = values.filter(isDefined);  // Type: number[]
    ```

    ### in Operator Narrowing

    ```typescript
    interface Bird {
      fly(): void;
      layEggs(): void;
    }

    interface Fish {
      swim(): void;
      layEggs(): void;
    }

    function move(animal: Bird | Fish) {
      if ("fly" in animal) {
        animal.fly();  // Type: Bird
      } else {
        animal.swim();  // Type: Fish
      }
    }
    ```

    ## Utility Types

    TypeScript provides built-in utility types for common type transformations.

    ### Partial<T>

    ```typescript
    // Makes all properties optional
    interface User {
      id: number;
      name: string;
      email: string;
      age: number;
    }

    // Only need to provide some properties
    function updateUser(id: number, updates: Partial<User>) {
      // Implementation
    }

    updateUser(1, { name: "Alice" });  // OK
    updateUser(1, { email: "alice@example.com", age: 30 });  // OK
    ```

    ### Required<T>

    ```typescript
    // Makes all properties required
    interface Config {
      host?: string;
      port?: number;
      debug?: boolean;
    }

    const defaultConfig: Required<Config> = {
      host: "localhost",  // Required!
      port: 3000,         // Required!
      debug: false        // Required!
    };
    ```

    ### Readonly<T>

    ```typescript
    // Makes all properties readonly
    interface MutableUser {
      name: string;
      age: number;
    }

    const user: Readonly<MutableUser> = {
      name: "Alice",
      age: 30
    };

    user.name = "Bob";  // ❌ Error: Cannot assign to 'name' (readonly)
    ```

    ### Pick<T, K>

    ```typescript
    // Pick specific properties
    interface User {
      id: number;
      name: string;
      email: string;
      password: string;
      createdAt: Date;
    }

    // Only expose safe properties
    type PublicUser = Pick<User, "id" | "name" | "email">;

    const publicUser: PublicUser = {
      id: 1,
      name: "Alice",
      email: "alice@example.com"
      // password not needed!
    };
    ```

    ### Omit<T, K>

    ```typescript
    // Omit specific properties
    type UserWithoutPassword = Omit<User, "password">;

    const user: UserWithoutPassword = {
      id: 1,
      name: "Alice",
      email: "alice@example.com",
      createdAt: new Date()
      // password omitted!
    };
    ```

    ### Record<K, T>

    ```typescript
    // Create object type with specific keys and value type
    type UserRoles = Record<string, string[]>;

    const roles: UserRoles = {
      admin: ["read", "write", "delete"],
      user: ["read"],
      guest: []
    };

    // Map user IDs to users
    type UserMap = Record<number, User>;

    const users: UserMap = {
      1: { id: 1, name: "Alice", email: "alice@example.com", password: "***", createdAt: new Date() },
      2: { id: 2, name: "Bob", email: "bob@example.com", password: "***", createdAt: new Date() }
    };
    ```

    ### ReturnType<T>

    ```typescript
    // Extract return type of function
    function getUser() {
      return {
        id: 1,
        name: "Alice",
        email: "alice@example.com"
      };
    }

    type User = ReturnType<typeof getUser>;
    // Type: { id: number; name: string; email: string; }
    ```

    ### Exclude<T, U> and Extract<T, U>

    ```typescript
    // Exclude: Remove types from union
    type Status = "pending" | "approved" | "rejected" | "cancelled";
    type ActiveStatus = Exclude<Status, "cancelled">;
    // Type: "pending" | "approved" | "rejected"

    // Extract: Keep only matching types
    type SuccessStatus = Extract<Status, "approved" | "completed">;
    // Type: "approved"
    ```

    ## Real-World Example: Type-Safe API Client

    ```typescript
    // API response types
    interface ApiResponse<T> {
      data: T;
      status: number;
      message: string;
    }

    type HttpMethod = "GET" | "POST" | "PUT" | "DELETE";

    // Generic API client
    class ApiClient {
      constructor(private baseUrl: string) {}

      private async request<T>(
        method: HttpMethod,
        endpoint: string,
        body?: unknown
      ): Promise<ApiResponse<T>> {
        const response = await fetch(`${this.baseUrl}${endpoint}`, {
          method,
          headers: { "Content-Type": "application/json" },
          body: body ? JSON.stringify(body) : undefined
        });

        return response.json();
      }

      async get<T>(endpoint: string): Promise<ApiResponse<T>> {
        return this.request<T>("GET", endpoint);
      }

      async post<T, U = unknown>(
        endpoint: string,
        body: U
      ): Promise<ApiResponse<T>> {
        return this.request<T>("POST", endpoint, body);
      }

      async put<T, U = unknown>(
        endpoint: string,
        body: U
      ): Promise<ApiResponse<T>> {
        return this.request<T>("PUT", endpoint, body);
      }

      async delete<T>(endpoint: string): Promise<ApiResponse<T>> {
        return this.request<T>("DELETE", endpoint);
      }
    }

    // Usage
    interface User {
      id: number;
      name: string;
      email: string;
    }

    interface CreateUserDTO {
      name: string;
      email: string;
      password: string;
    }

    const api = new ApiClient("https://api.example.com");

    // Fully type-safe!
    const usersResponse = await api.get<User[]>("/users");
    console.log(usersResponse.data[0].name);  // Type: string

    const newUserResponse = await api.post<User, CreateUserDTO>("/users", {
      name: "Alice",
      email: "alice@example.com",
      password: "secret123"
    });
    console.log(newUserResponse.data.id);  // Type: number
    ```

    ## Interview Tips

    1. **Generics enable reusable, type-safe code**
    2. **Use constraints** (`<T extends Type>`) to limit generic types
    3. **Discriminated unions** are powerful for state management
    4. **Type guards** enable type narrowing and safer code
    5. **Utility types** save time - learn the built-in ones
    6. **ReturnType, Parameters** are useful for extracting types
    7. **Generics in React**: `useState<Type>()`, `useRef<Type>()`

    **Next**: We'll learn TypeScript in practice with real-world scenarios!
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 6: Lesson 6 ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 6',
  content: <<~MARKDOWN,
# Microlesson 🚀

# TypeScript in Practice

    Learn how to use TypeScript in real-world projects with React, Node.js, and proper configuration.

    ## Project Configuration

    ### tsconfig.json

    **The TypeScript compiler configuration file**

    ```json
    {
      "compilerOptions": {
        // Language and Environment
        "target": "ES2020",                    // Output JavaScript version
        "lib": ["ES2020", "DOM"],              // Available APIs
        "jsx": "react-jsx",                    // JSX support for React

        // Modules
        "module": "ESNext",                    // Module system
        "moduleResolution": "node",            // How to resolve modules
        "resolveJsonModule": true,             // Import JSON files
        "baseUrl": ".",                        // Base directory for imports
        "paths": {                             // Path aliases
          "@components/*": ["src/components/*"],
          "@utils/*": ["src/utils/*"]
        },

        // Emit
        "outDir": "./dist",                    // Output directory
        "declaration": true,                   // Generate .d.ts files
        "declarationMap": true,                // Sourcemaps for .d.ts
        "sourceMap": true,                     // Generate .map files
        "removeComments": true,                // Remove comments in output

        // Type Checking (STRICT MODE - RECOMMENDED!)
        "strict": true,                        // Enable all strict checks
        "noImplicitAny": true,                 // Error on implicit 'any'
        "strictNullChecks": true,              // null/undefined are not valid values
        "strictFunctionTypes": true,           // Strict function type checking
        "strictBindCallApply": true,           // Strict bind/call/apply
        "noImplicitThis": true,                // Error on implicit 'this'
        "alwaysStrict": true,                  // Use strict mode

        // Additional Checks
        "noUnusedLocals": true,                // Error on unused variables
        "noUnusedParameters": true,            // Error on unused parameters
        "noImplicitReturns": true,             // Error if not all paths return
        "noFallthroughCasesInSwitch": true,    // Error on switch fallthrough

        // Interop
        "esModuleInterop": true,               // CommonJS/ES6 interop
        "allowSyntheticDefaultImports": true,  // Allow default imports
        "forceConsistentCasingInFileNames": true,  // Consistent file casing
        "skipLibCheck": true                   // Skip type checking of .d.ts files
      },
      "include": [
        "src/**/*"                             // Files to compile
      ],
      "exclude": [
        "node_modules",                        // Ignore node_modules
        "dist",                                // Ignore output
        "**/*.spec.ts"                         // Ignore test files
      ]
    }
    ```

    ### Project Setup

    ```bash
    # Initialize TypeScript project
    npm init -y
    npm install --save-dev typescript @types/node

    # Generate tsconfig.json
    npx tsc --init

    # Install type definitions
    npm install --save-dev @types/express @types/react @types/jest

    # Compile TypeScript
    npx tsc

    # Watch mode
    npx tsc --watch
    ```

    ## TypeScript with React

    ### Component Types

    ```typescript
    import React, { useState, useEffect, useRef } from 'react';

    // Props interface
    interface UserCardProps {
      name: string;
      age: number;
      email: string;
      onEdit?: (id: string) => void;  // Optional callback
      children?: React.ReactNode;     // Children prop
    }

    // Function component (preferred)
    const UserCard: React.FC<UserCardProps> = ({
      name,
      age,
      email,
      onEdit,
      children
    }) => {
      const [isEditing, setIsEditing] = useState<boolean>(false);

      return (
        <div className="user-card">
          <h2>{name}</h2>
          <p>Age: {age}</p>
          <p>Email: {email}</p>
          {onEdit && (
            <button onClick={() => onEdit("123")}>Edit</button>
          )}
          {children}
        </div>
      );
    };

    // Alternative: Function without React.FC (more common now)
    function UserCard2(props: UserCardProps) {
      return <div>{props.name}</div>;
    }

    // Usage
    <UserCard
      name="Alice"
      age={30}
      email="alice@example.com"
      onEdit={(id) => console.log(id)}
    >
      <p>Additional info</p>
    </UserCard>
    ```

    ### Hooks with TypeScript

    ```typescript
    import React, { useState, useEffect, useRef, useContext } from 'react';

    // useState
    function Counter() {
      const [count, setCount] = useState<number>(0);
      const [user, setUser] = useState<User | null>(null);

      return (
        <button onClick={() => setCount(count + 1)}>
          Count: {count}
        </button>
      );
    }

    // useEffect
    function DataFetcher() {
      const [data, setData] = useState<User[]>([]);
      const [loading, setLoading] = useState<boolean>(true);
      const [error, setError] = useState<Error | null>(null);

      useEffect(() => {
        async function fetchData() {
          try {
            const response = await fetch('/api/users');
            const users: User[] = await response.json();
            setData(users);
          } catch (err) {
            setError(err as Error);
          } finally {
            setLoading(false);
          }
        }

        fetchData();
      }, []);  // Dependency array

      if (loading) return <div>Loading...</div>;
      if (error) return <div>Error: {error.message}</div>;

      return (
        <ul>
          {data.map(user => (
            <li key={user.id}>{user.name}</li>
          ))}
        </ul>
      );
    }

    // useRef
    function TextInput() {
      const inputRef = useRef<HTMLInputElement>(null);

      const focusInput = () => {
        inputRef.current?.focus();  // Optional chaining
      };

      return (
        <>
          <input ref={inputRef} type="text" />
          <button onClick={focusInput}>Focus Input</button>
        </>
      );
    }

    // useContext
    interface ThemeContextType {
      theme: 'light' | 'dark';
      toggleTheme: () => void;
    }

    const ThemeContext = React.createContext<ThemeContextType | undefined>(
      undefined
    );

    function useTheme() {
      const context = useContext(ThemeContext);
      if (!context) {
        throw new Error('useTheme must be used within ThemeProvider');
      }
      return context;
    }

    // Custom hook
    function useLocalStorage<T>(key: string, initialValue: T) {
      const [value, setValue] = useState<T>(() => {
        const item = window.localStorage.getItem(key);
        return item ? JSON.parse(item) : initialValue;
      });

      useEffect(() => {
        window.localStorage.setItem(key, JSON.stringify(value));
      }, [key, value]);

      return [value, setValue] as const;  // Tuple type
    }

    // Usage
    function Settings() {
      const [username, setUsername] = useLocalStorage<string>('username', '');

      return (
        <input
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
      );
    }
    ```

    ### Event Handling

    ```typescript
    import React from 'react';

    function Form() {
      const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        console.log('Form submitted');
      };

      const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        console.log(e.target.value);
      };

      const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
        console.log('Button clicked');
      };

      const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
        if (e.key === 'Enter') {
          console.log('Enter pressed');
        }
      };

      return (
        <form onSubmit={handleSubmit}>
          <input
            type="text"
            onChange={handleChange}
            onKeyDown={handleKeyDown}
          />
          <button onClick={handleClick}>Submit</button>
        </form>
      );
    }
    ```

    ## TypeScript with Node.js/Express

    ### Express Server

    ```typescript
    import express, { Request, Response, NextFunction } from 'express';

    const app = express();
    app.use(express.json());

    // Type-safe request handlers
    interface User {
      id: number;
      name: string;
      email: string;
    }

    // GET endpoint
    app.get('/api/users', (req: Request, res: Response) => {
      const users: User[] = [
        { id: 1, name: 'Alice', email: 'alice@example.com' },
        { id: 2, name: 'Bob', email: 'bob@example.com' }
      ];
      res.json(users);
    });

    // POST endpoint with typed body
    interface CreateUserBody {
      name: string;
      email: string;
      password: string;
    }

    app.post('/api/users', (req: Request<{}, {}, CreateUserBody>, res: Response) => {
      const { name, email, password } = req.body;

      // Validation
      if (!name || !email || !password) {
        return res.status(400).json({ error: 'Missing required fields' });
      }

      const newUser: User = {
        id: Date.now(),
        name,
        email
      };

      res.status(201).json(newUser);
    });

    // GET with params
    app.get('/api/users/:id', (
      req: Request<{ id: string }>,
      res: Response
    ) => {
      const userId = parseInt(req.id);
      // Find user logic
      res.json({ id: userId });
    });

    // Middleware
    const authMiddleware = (
      req: Request,
      res: Response,
      next: NextFunction
    ) => {
      const token = req.headers.authorization;

      if (!token) {
        return res.status(401).json({ error: 'No token provided' });
      }

      // Verify token logic
      next();
    };

    app.use('/api/protected', authMiddleware);

    // Error handling middleware
    app.use((
      err: Error,
      req: Request,
      res: Response,
      next: NextFunction
    ) => {
      console.error(err.stack);
      res.status(500).json({ error: 'Internal server error' });
    });

    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });
    ```

    ### Async/Await with TypeScript

    ```typescript
    // Database operations
    interface DbUser {
      id: number;
      name: string;
      email: string;
      createdAt: Date;
    }

    class UserService {
      async findById(id: number): Promise<DbUser | null> {
        try {
          // Simulated database query
          const user = await db.query<DbUser>(
            'SELECT * FROM users WHERE id = $1',
            [id]
          );
          return user || null;
        } catch (error) {
          console.error('Database error:', error);
          throw new Error('Failed to fetch user');
        }
      }

      async create(data: Omit<DbUser, 'id' | 'createdAt'>): Promise<DbUser> {
        const now = new Date();
        const user = await db.query<DbUser>(
          'INSERT INTO users (name, email, created_at) VALUES ($1, $2, $3) RETURNING *',
          [data.name, data.email, now]
        );
        return user;
      }

      async findAll(): Promise<DbUser[]> {
        const users = await db.query<DbUser[]>('SELECT * FROM users');
        return users;
      }
    }
    ```

    ## Migration Strategies

    ### Gradual Migration from JavaScript

    ```typescript
    // Step 1: Rename .js to .ts (start with leaf files)
    // user.js → user.ts

    // Step 2: Allow implicit any (temporarily)
    // tsconfig.json: "noImplicitAny": false

    // Step 3: Add basic types
    // Before (JavaScript)
    function getUser(id) {
      return users.find(u => u.id === id);
    }

    // After (TypeScript - basic)
    function getUser(id: number): User | undefined {
      return users.find(u => u.id === id);
    }

    // Step 4: Add strict null checks gradually
    // tsconfig.json: "strictNullChecks": true

    // Step 5: Enable all strict checks
    // tsconfig.json: "strict": true

    // Step 6: Fix errors one by one
    // Use @ts-ignore sparingly for legacy code:
    // @ts-ignore
    const legacy = oldLibrary.method();
    ```

    ### Type Definitions for JavaScript Libraries

    ```typescript
    // Install type definitions
    npm install --save-dev @types/lodash
    npm install --save-dev @types/express
    npm install --save-dev @types/node

    // If types don't exist, create declaration file
    // types/my-library.d.ts
    declare module 'my-library' {
      export function doSomething(value: string): number;
      export interface Config {
        apiKey: string;
        timeout: number;
      }
    }

    // Ambient declarations for global variables
    // globals.d.ts
    declare global {
      interface Window {
        myCustomProperty: string;
      }

      const API_URL: string;
    }

    export {};
    ```

    ## Best Practices

    ### 1. Use Strict Mode

    ```json
    {
      "compilerOptions": {
        "strict": true,
        "noImplicitAny": true,
        "strictNullChecks": true
      }
    }
    ```

    ### 2. Avoid any, Use unknown

    ```typescript
    // Bad
    function process(data: any) {
      return data.value;  // No type checking!
    }

    // Good
    function process(data: unknown) {
      if (typeof data === 'object' && data !== null && 'value' in data) {
        return (data as { value: string }).value;
      }
      throw new Error('Invalid data');
    }
    ```

    ### 3. Use const assertions

    ```typescript
    // Without const assertion
    const config = {
      apiUrl: 'https://api.example.com',
      timeout: 5000
    };
    // Type: { apiUrl: string; timeout: number; }

    // With const assertion
    const config = {
      apiUrl: 'https://api.example.com',
      timeout: 5000
    } as const;
    // Type: { readonly apiUrl: "https://api.example.com"; readonly timeout: 5000; }

    // Const assertion for arrays
    const colors = ['red', 'green', 'blue'] as const;
    // Type: readonly ["red", "green", "blue"]
    type Color = typeof colors[number];  // "red" | "green" | "blue"
    ```

    ### 4. Use Template Literal Types

    ```typescript
    // Create type-safe string patterns
    type EventName = 'click' | 'focus' | 'blur';
    type EventHandlerName = `on${Capitalize<EventName>}`;
    // Type: "onClick" | "onFocus" | "onBlur"

    // HTTP methods with paths
    type HttpMethod = 'GET' | 'POST' | 'PUT' | 'DELETE';
    type Route = '/users' | '/posts' | '/comments';
    type Endpoint = `${HttpMethod} ${Route}`;
    // Type: "GET /users" | "GET /posts" | ... (12 combinations)
    ```

    ### 5. Organize Types

    ```typescript
    // types/user.ts
    export interface User {
      id: number;
      name: string;
      email: string;
    }

    export type CreateUserDTO = Omit<User, 'id'>;
    export type UpdateUserDTO = Partial<CreateUserDTO>;

    // types/api.ts
    export interface ApiResponse<T> {
      data: T;
      status: number;
      message: string;
    }

    export type ApiError = {
      status: number;
      message: string;
      errors?: Record<string, string[]>;
    };

    // Import in other files
    import { User, CreateUserDTO } from './types/user';
    import { ApiResponse } from './types/api';
    ```

    ### 6. Use Discriminated Unions for State

    ```typescript
    // Type-safe state management
    type LoadingState<T> =
      | { status: 'idle' }
      | { status: 'loading' }
      | { status: 'success'; data: T }
      | { status: 'error'; error: Error };

    function DataComponent() {
      const [state, setState] = useState<LoadingState<User[]>>({
        status: 'idle'
      });

      // TypeScript narrows the type based on status
      if (state.status === 'loading') {
        return <div>Loading...</div>;
      }

      if (state.status === 'error') {
        return <div>Error: {state.error.message}</div>;
      }

      if (state.status === 'success') {
        return (
          <ul>
            {state.data.map(user => (
              <li key={user.id}>{user.name}</li>
            ))}
          </ul>
        );
      }

      return <button onClick={fetchData}>Load Data</button>;
    }
    ```

    ## Common Pitfalls and Solutions

    ### 1. Optional Chaining

    ```typescript
    // Before
    const city = user && user.address && user.address.city;

    // After (TypeScript 3.7+)
    const city = user?.address?.city;
    ```

    ### 2. Nullish Coalescing

    ```typescript
    // Before (falsy values treated as null)
    const value = user.count || 10;  // Problem: 0 is falsy!

    // After (only null/undefined)
    const value = user.count ?? 10;  // Only replaces null/undefined
    ```

    ### 3. Type vs Interface

    ```typescript
    // Use interface for object shapes
    interface User {
      id: number;
      name: string;
    }

    // Use type for unions, intersections, primitives
    type ID = string | number;
    type Result = Success | Error;
    ```

    ## Interview Tips

    1. **Know tsconfig.json options** - especially strict mode
    2. **Generics are powerful** - use them for reusable code
    3. **Type guards enable narrowing** - typeof, instanceof, custom
    4. **Utility types save time** - Partial, Pick, Omit, Record
    5. **React: avoid React.FC** - modern apps use direct function types
    6. **Express: type Request generics** - Request<Params, ResBody, ReqBody>
    7. **Migration: gradual is ok** - start with allowJs, add types incrementally
    8. **Avoid any** - use unknown when type is truly unknown
    9. **Use const assertions** - for literal types and readonly
    10. **Discriminated unions** - perfect for state management

    ## Resources

    - **Official Docs**: https://www.typescriptlang.org/docs/
    - **TypeScript Playground**: https://www.typescriptlang.org/play
    - **React TypeScript Cheatsheet**: https://react-typescript-cheatsheet.netlify.app/
    - **Type Challenges**: https://github.com/type-challenges/type-challenges

    **You now have the TypeScript skills to build type-safe, scalable applications!**
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 6 microlessons for Typescript Basics"
