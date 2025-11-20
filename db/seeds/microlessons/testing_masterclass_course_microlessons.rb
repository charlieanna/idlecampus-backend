# AUTO-GENERATED from testing_masterclass_course.rb
puts "Creating Microlessons for Testing Fundamentals..."

module_var = CourseModule.find_by(slug: 'testing-fundamentals')

# === MICROLESSON 1: Practice Question ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Integration and E2E Testing

    **Integration tests** verify that multiple components work together correctly. **E2E tests** verify complete user workflows from start to finish.

    ## API Testing

    ### Testing REST APIs with SuperTest (Node.js)

    ```javascript
    // app.js
    const express = require('express');
    const app = express();
    app.use(express.json());

    const users = [];

    app.post('/api/users', (req, res) => {
      const { name, email } = req.body;

      if (!name || !email) {
        return res.status(400).json({ error: 'Name and email required' });
      }

      const user = { id: users.length + 1, name, email };
      users.push(user);
      res.status(201).json(user);
    });

    app.get('/api/users/:id', (req, res) => {
      const user = users.find(u => u.id === parseInt(req.params.id));
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      res.json(user);
    });

    module.exports = app;

    // app.test.js
    const request = require('supertest');
    const app = require('./app');

    describe('Users API', () => {
      describe('POST /api/users', () => {
        test('creates user with valid data', async () => {
          // ARRANGE
          const userData = { name: 'Alice', email: 'alice@example.com' };

          // ACT
          const response = await request(app)
            .post('/api/users')
            .send(userData)
            .expect(201);

          // ASSERT
          expect(response.body).toMatchObject({
            id: expect.any(Number),
            name: 'Alice',
            email: 'alice@example.com'
          });
        });

        test('returns 400 when name is missing', async () => {
          const response = await request(app)
            .post('/api/users')
            .send({ email: 'alice@example.com' })
            .expect(400);

          expect(response.body.error).toBe('Name and email required');
        });
      });

      describe('GET /api/users/:id', () => {
        test('returns user by id', async () => {
          // ARRANGE: Create user first
          const createResponse = await request(app)
            .post('/api/users')
            .send({ name: 'Bob', email: 'bob@example.com' });
          const userId = createResponse.body.id;

          // ACT
          const response = await request(app)
            .get(`/api/users/${userId}`)
            .expect(200);

          // ASSERT
          expect(response.body).toEqual({
            id: userId,
            name: 'Bob',
            email: 'bob@example.com'
          });
        });

        test('returns 404 for non-existent user', async () => {
          const response = await request(app)
            .get('/api/users/99999')
            .expect(404);

          expect(response.body.error).toBe('User not found');
        });
      });
    });
    ```

    ### Testing REST APIs with Pytest (Python)

    ```python
    # app.py (Flask)
    from flask import Flask, request, jsonify

    app = Flask(__name__)
    users = []

    @app.route('/api/users', methods=['POST'])
    def create_user():
        data = request.get_json()

        if not data.get('name') or not data.get('email'):
            return jsonify({'error': 'Name and email required'}), 400

        user = {
            'id': len(users) + 1,
            'name': data['name'],
            'email': data['email']
        }
        users.append(user)
        return jsonify(user), 201

    @app.route('/api/users/<int:user_id>', methods=['GET'])
    def get_user(user_id):
        user = next((u for u in users if u['id'] == user_id), None)
        if not user:
            return jsonify({'error': 'User not found'}), 404
        return jsonify(user)

    # test_app.py
    import pytest
    from app import app

    @pytest.fixture
    def client():
        app.config['TESTING'] = True
        with app.test_client() as client:
            yield client

    class TestUsersAPI:
        def test_create_user_with_valid_data(self, client):
            # ARRANGE
            user_data = {'name': 'Alice', 'email': 'alice@example.com'}

            # ACT
            response = client.post('/api/users', json=user_data)

            # ASSERT
            assert response.status_code == 201
            data = response.get_json()
            assert data['name'] == 'Alice'
            assert data['email'] == 'alice@example.com'
            assert 'id' in data

        def test_create_user_missing_name(self, client):
            # ACT
            response = client.post('/api/users', json={'email': 'alice@example.com'})

            # ASSERT
            assert response.status_code == 400
            data = response.get_json()
            assert data['error'] == 'Name and email required'

        def test_get_user_by_id(self, client):
            # ARRANGE: Create user first
            create_response = client.post('/api/users', json={
                'name': 'Bob',
                'email': 'bob@example.com'
            })
            user_id = create_response.get_json()['id']

            # ACT
            response = client.get(f'/api/users/{user_id}')

            # ASSERT
            assert response.status_code == 200
            data = response.get_json()
            assert data['name'] == 'Bob'
            assert data['email'] == 'bob@example.com'

        def test_get_nonexistent_user(self, client):
            # ACT
            response = client.get('/api/users/99999')

            # ASSERT
            assert response.status_code == 404
            assert response.get_json()['error'] == 'User not found'
    ```

    ## Database Testing

    ### Option 1: In-Memory Database (SQLite)

    ```javascript
    // database.js
    const { Sequelize, DataTypes } = require('sequelize');

    const sequelize = new Sequelize('sqlite::memory:');

    const User = sequelize.define('User', {
      name: {
        type: DataTypes.STRING,
        allowNull: false
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
      }
    });

    module.exports = { sequelize, User };

    // database.test.js
    const { sequelize, User } = require('./database');

    describe('User Model', () => {
      beforeAll(async () => {
        await sequelize.sync({ force: true });
      });

      afterEach(async () => {
        await User.destroy({ where: {} });
      });

      test('creates user successfully', async () => {
        // ARRANGE
        const userData = { name: 'Alice', email: 'alice@example.com' };

        // ACT
        const user = await User.create(userData);

        // ASSERT
        expect(user.id).toBeDefined();
        expect(user.name).toBe('Alice');
        expect(user.email).toBe('alice@example.com');
      });

      test('enforces unique email constraint', async () => {
        // ARRANGE
        await User.create({ name: 'Alice', email: 'alice@example.com' });

        // ACT & ASSERT
        await expect(
          User.create({ name: 'Bob', email: 'alice@example.com' })
        ).rejects.toThrow();
      });

      test('finds user by email', async () => {
        // ARRANGE
        await User.create({ name: 'Alice', email: 'alice@example.com' });

        // ACT
        const user = await User.findOne({ where: { email: 'alice@example.com' } });

        // ASSERT
        expect(user).toBeDefined();
        expect(user.name).toBe('Alice');
      });
    });
    ```

    ### Option 2: Test Containers (Real Database)

    ```javascript
    // database.test.js (with Testcontainers)
    const { GenericContainer } = require('testcontainers');
    const { Sequelize, DataTypes } = require('sequelize');

    describe('User Model with PostgreSQL', () => {
      let container;
      let sequelize;
      let User;

      beforeAll(async () => {
        // Start PostgreSQL container
        container = await new GenericContainer('postgres:15')
          .withEnvironment({ POSTGRES_PASSWORD: 'test' })
          .withExposedPorts(5432)
          .start();

        const host = container.getHost();
        const port = container.getMappedPort(5432);

        // Connect to PostgreSQL
        sequelize = new Sequelize({
          dialect: 'postgres',
          host,
          port,
          username: 'postgres',
          password: 'test',
          database: 'postgres',
          logging: false
        });

        User = sequelize.define('User', {
          name: DataTypes.STRING,
          email: { type: DataTypes.STRING, unique: true }
        });

        await sequelize.sync({ force: true });
      }, 60000);

      afterAll(async () => {
        await sequelize.close();
        await container.stop();
      });

      test('creates user in real PostgreSQL', async () => {
        const user = await User.create({
          name: 'Alice',
          email: 'alice@example.com'
        });

        expect(user.id).toBeDefined();

        // Verify in database
        const found = await User.findByPk(user.id);
        expect(found.name).toBe('Alice');
      });
    });
    ```

    ### Python with Testcontainers

    ```python
    # test_database.py
    import pytest
    from testcontainers.postgres import PostgresContainer
    from sqlalchemy import create_engine, Column, Integer, String
    from sqlalchemy.ext.declarative import declarative_base
    from sqlalchemy.orm import sessionmaker

    Base = declarative_base()

    class User(Base):
        __tablename__ = 'users'
        id = Column(Integer, primary_key=True)
        name = Column(String, nullable=False)
        email = Column(String, unique=True, nullable=False)

    @pytest.fixture(scope='module')
    def database():
        with PostgresContainer('postgres:15') as postgres:
            engine = create_engine(postgres.get_connection_url())
            Base.metadata.create_all(engine)
            Session = sessionmaker(bind=engine)
            yield Session()

    class TestUserModel:
        def test_create_user(self, database):
            # ARRANGE
            session = database

            # ACT
            user = User(name='Alice', email='alice@example.com')
            session.add(user)
            session.commit()

            # ASSERT
            assert user.id is not None

            # Verify in database
            found = session.query(User).filter_by(email='alice@example.com').first()
            assert found.name == 'Alice'

        def test_unique_email_constraint(self, database):
            # ARRANGE
            session = database
            user1 = User(name='Alice', email='alice@example.com')
            session.add(user1)
            session.commit()

            # ACT & ASSERT
            user2 = User(name='Bob', email='alice@example.com')
            session.add(user2)

            with pytest.raises(Exception):  # Unique constraint violation
                session.commit()
    ```

    ## End-to-End Testing with Cypress

    ### Setup Cypress

    ```bash
    npm install --save-dev cypress
    npx cypress open
    ```

    ### Example 1: User Registration Flow

    ```javascript
    // cypress/e2e/registration.cy.js
    describe('User Registration', () => {
      beforeEach(() => {
        // Reset database before each test
        cy.task('db:reset');
        cy.visit('/register');
      });

      it('successfully registers a new user', () => {
        // ARRANGE & ACT
        cy.get('input[name="name"]').type('Alice Johnson');
        cy.get('input[name="email"]').type('alice@example.com');
        cy.get('input[name="password"]').type('SecurePass123!');
        cy.get('input[name="confirmPassword"]').type('SecurePass123!');
        cy.get('button[type="submit"]').click();

        // ASSERT
        cy.url().should('include', '/dashboard');
        cy.contains('Welcome, Alice Johnson').should('be.visible');

        // Verify email was sent (check via API)
        cy.request('/api/test/emails').then((response) => {
          const emails = response.body;
          expect(emails).to.have.length(1);
          expect(emails[0].to).to.equal('alice@example.com');
          expect(emails[0].subject).to.include('Welcome');
        });
      });

      it('shows error for duplicate email', () => {
        // ARRANGE: Create user first
        cy.task('db:createUser', {
          name: 'Existing User',
          email: 'alice@example.com'
        });

        // ACT
        cy.get('input[name="name"]').type('Alice Johnson');
        cy.get('input[name="email"]').type('alice@example.com');
        cy.get('input[name="password"]').type('SecurePass123!');
        cy.get('input[name="confirmPassword"]').type('SecurePass123!');
        cy.get('button[type="submit"]').click();

        // ASSERT
        cy.contains('Email already exists').should('be.visible');
        cy.url().should('include', '/register');
      });

      it('validates password requirements', () => {
        // ACT
        cy.get('input[name="name"]').type('Alice Johnson');
        cy.get('input[name="email"]').type('alice@example.com');
        cy.get('input[name="password"]').type('weak');
        cy.get('input[name="confirmPassword"]').type('weak');
        cy.get('button[type="submit"]').click();

        // ASSERT
        cy.contains('Password must be at least 8 characters').should('be.visible');
      });
    });
    ```

    ### Example 2: Shopping Cart E2E Test

    ```javascript
    // cypress/e2e/shopping-cart.cy.js
    describe('Shopping Cart', () => {
      beforeEach(() => {
        cy.task('db:reset');
        cy.task('db:seedProducts');
        cy.visit('/');
      });

      it('adds items to cart and completes checkout', () => {
        // Browse products
        cy.contains('MacBook Pro').click();
        cy.contains('Add to Cart').click();
        cy.contains('Added to cart').should('be.visible');

        // View cart
        cy.get('[data-testid="cart-icon"]').click();
        cy.url().should('include', '/cart');

        // Verify item in cart
        cy.contains('MacBook Pro').should('be.visible');
        cy.contains('$2,399.00').should('be.visible');

        // Update quantity
        cy.get('input[type="number"]').clear().type('2');
        cy.contains('$4,798.00').should('be.visible');

        // Proceed to checkout
        cy.contains('Checkout').click();
        cy.url().should('include', '/checkout');

        // Fill shipping info
        cy.get('input[name="fullName"]').type('Alice Johnson');
        cy.get('input[name="address"]').type('123 Main St');
        cy.get('input[name="city"]').type('San Francisco');
        cy.get('select[name="state"]').select('CA');
        cy.get('input[name="zip"]').type('94102');

        // Fill payment info
        cy.get('input[name="cardNumber"]').type('4111111111111111');
        cy.get('input[name="expiry"]').type('12/25');
        cy.get('input[name="cvv"]').type('123');

        // Submit order
        cy.contains('Place Order').click();

        // Verify success
        cy.url().should('include', '/order/confirmation');
        cy.contains('Order confirmed').should('be.visible');
        cy.contains('Order #').should('be.visible');

        // Verify email sent
        cy.request('/api/test/emails').then((response) => {
          const emails = response.body;
          const confirmationEmail = emails.find(e =>
            e.subject.includes('Order Confirmation')
          );
          expect(confirmationEmail).to.exist;
        });
      });

      it('applies discount code', () => {
        // Add item to cart
        cy.contains('MacBook Pro').click();
        cy.contains('Add to Cart').click();
        cy.get('[data-testid="cart-icon"]').click();

        // Apply discount
        cy.get('input[name="discountCode"]').type('SAVE20');
        cy.contains('Apply').click();

        // Verify discount applied
        cy.contains('Discount (20%)').should('be.visible');
        cy.contains('$1,919.20').should('be.visible'); // $2,399 - 20%
      });
    });
    ```

    ## End-to-End Testing with Selenium

    ```python
    # test_e2e.py (Python + Selenium)
    import pytest
    from selenium import webdriver
    from selenium.webdriver.common.by import By
    from selenium.webdriver.support.ui import WebDriverWait
    from selenium.webdriver.support import expected_conditions as EC

    @pytest.fixture
    def driver():
        driver = webdriver.Chrome()
        driver.implicitly_wait(10)
        yield driver
        driver.quit()

    class TestUserRegistration:
        def test_successful_registration(self, driver):
            # ARRANGE
            driver.get('http://localhost:3000/register')

            # ACT
            driver.find_element(By.NAME, 'name').send_keys('Alice Johnson')
            driver.find_element(By.NAME, 'email').send_keys('alice@example.com')
            driver.find_element(By.NAME, 'password').send_keys('SecurePass123!')
            driver.find_element(By.NAME, 'confirmPassword').send_keys('SecurePass123!')
            driver.find_element(By.CSS_SELECTOR, 'button[type="submit"]').click()

            # ASSERT
            WebDriverWait(driver, 10).until(
                EC.url_contains('/dashboard')
            )
            assert 'Welcome, Alice Johnson' in driver.page_source

        def test_duplicate_email_error(self, driver):
            # ARRANGE: User already exists
            # (Assume database seeded with user)

            # ACT
            driver.get('http://localhost:3000/register')
            driver.find_element(By.NAME, 'name').send_keys('Alice Johnson')
            driver.find_element(By.NAME, 'email').send_keys('existing@example.com')
            driver.find_element(By.NAME, 'password').send_keys('SecurePass123!')
            driver.find_element(By.NAME, 'confirmPassword').send_keys('SecurePass123!')
            driver.find_element(By.CSS_SELECTOR, 'button[type="submit"]').click()

            # ASSERT
            error_message = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CLASS_NAME, 'error-message'))
            )
            assert 'Email already exists' in error_message.text

    class TestLoginFlow:
        def test_successful_login(self, driver):
            # ACT
            driver.get('http://localhost:3000/login')
            driver.find_element(By.NAME, 'email').send_keys('user@example.com')
            driver.find_element(By.NAME, 'password').send_keys('password123')
            driver.find_element(By.CSS_SELECTOR, 'button[type="submit"]').click()

            # ASSERT
            WebDriverWait(driver, 10).until(
                EC.url_contains('/dashboard')
            )
            profile_button = driver.find_element(By.ID, 'user-profile')
            assert profile_button.is_displayed()

        def test_invalid_credentials(self, driver):
            # ACT
            driver.get('http://localhost:3000/login')
            driver.find_element(By.NAME, 'email').send_keys('user@example.com')
            driver.find_element(By.NAME, 'password').send_keys('wrongpassword')
            driver.find_element(By.CSS_SELECTOR, 'button[type="submit"]').click()

            # ASSERT
            error_message = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CLASS_NAME, 'error'))
            )
            assert 'Invalid email or password' in error_message.text
    ```

    ## Cypress vs Selenium

    | Feature | Cypress | Selenium |
    |---------|---------|----------|
    | **Speed** | Fast (runs in browser) | Slower (WebDriver protocol) |
    | **Setup** | Easy (npm install) | Complex (drivers, grid) |
    | **Debugging** | Excellent (time travel, snapshots) | Basic |
    | **Languages** | JavaScript only | Multiple (Python, Java, JS, etc.) |
    | **Real browser** | Chrome/Firefox/Edge | All browsers |
    | **Cross-browser** | Limited | Excellent |
    | **Mobile** | No | Yes (Appium) |
    | **Community** | Growing | Mature |

    **Choose Cypress if:**
    - JavaScript project
    - Focus on modern browsers
    - Want fast feedback and great DX

    **Choose Selenium if:**
    - Need multiple languages
    - Need all browsers (Safari, IE)
    - Need mobile testing
    - Large existing Selenium investment

    ## Best Practices for Integration/E2E Tests

    ### 1. Use Test Data Builders

    ```javascript
    // test-helpers/builders.js
    class UserBuilder {
      constructor() {
        this.user = {
          name: 'Test User',
          email: `test${Date.now()}@example.com`,
          password: 'TestPass123!'
        };
      }

      withName(name) {
        this.user.name = name;
        return this;
      }

      withEmail(email) {
        this.user.email = email;
        return this;
      }

      build() {
        return this.user;
      }
    }

    // Usage in tests
    test('creates user', async () => {
      const user = new UserBuilder()
        .withName('Alice')
        .withEmail('alice@test.com')
        .build();

      const response = await request(app)
        .post('/api/users')
        .send(user);

      expect(response.status).toBe(201);
    });
    ```

    ### 2. Clean Up Test Data

    ```javascript
    describe('Users API', () => {
      const createdUserIds = [];

      afterEach(async () => {
        // Clean up created users
        for (const id of createdUserIds) {
          await User.destroy({ where: { id } });
        }
        createdUserIds.length = 0;
      });

      test('creates user', async () => {
        const response = await request(app)
          .post('/api/users')
          .send({ name: 'Alice', email: 'alice@test.com' });

        createdUserIds.push(response.body.id);
        expect(response.status).toBe(201);
      });
    });
    ```

    ### 3. Use Page Object Pattern (E2E)

    ```javascript
    // cypress/pages/LoginPage.js
    class LoginPage {
      visit() {
        cy.visit('/login');
      }

      fillEmail(email) {
        cy.get('input[name="email"]').type(email);
        return this;
      }

      fillPassword(password) {
        cy.get('input[name="password"]').type(password);
        return this;
      }

      submit() {
        cy.get('button[type="submit"]').click();
        return this;
      }

      shouldShowError(message) {
        cy.contains(message).should('be.visible');
        return this;
      }
    }

    // cypress/e2e/login.cy.js
    import LoginPage from '../pages/LoginPage';

    describe('Login', () => {
      const loginPage = new LoginPage();

      it('logs in successfully', () => {
        loginPage
          .visit()
          .fillEmail('user@example.com')
          .fillPassword('password123')
          .submit();

        cy.url().should('include', '/dashboard');
      });

      it('shows error for invalid credentials', () => {
        loginPage
          .visit()
          .fillEmail('user@example.com')
          .fillPassword('wrongpassword')
          .submit()
          .shouldShowError('Invalid email or password');
      });
    });
    ```

    ### 4. Wait for Async Operations

    ```javascript
    // ❌ Bad: Fixed timeout
    cy.wait(5000);

    // ✅ Good: Wait for specific condition
    cy.get('[data-testid="loading"]').should('not.exist');
    cy.get('[data-testid="user-profile"]').should('be.visible');

    // ✅ Good: Wait for network request
    cy.intercept('GET', '/api/users').as('getUsers');
    cy.visit('/users');
    cy.wait('@getUsers');
    cy.get('.user-list').should('be.visible');
    ```

    **Next**: We'll dive into Test-Driven Development (TDD) and testing best practices.
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

# TDD and Testing Best Practices

    **Test-Driven Development (TDD)** is a software development approach where you write tests before writing the implementation code.

    ## The Red-Green-Refactor Cycle

    ```
    🔴 RED      →    🟢 GREEN    →    🔵 REFACTOR
    Write failing   Make it pass    Improve code
       test                           quality
         ↑                               ↓
         └───────────────────────────────┘
    ```

    ### Step 1: Red - Write a Failing Test

    **Write the smallest test that fails**

    ```javascript
    // calculator.test.js
    const Calculator = require('./calculator');

    describe('Calculator', () => {
      test('adds two numbers', () => {
        const calc = new Calculator();
        expect(calc.add(2, 3)).toBe(5);
      });
    });

    // Running this test fails because Calculator doesn't exist yet
    // ❌ ReferenceError: Calculator is not defined
    ```

    ### Step 2: Green - Make It Pass

    **Write the minimal code to make the test pass**

    ```javascript
    // calculator.js
    class Calculator {
      add(a, b) {
        return a + b;
      }
    }

    module.exports = Calculator;

    // Now the test passes
    // ✅ Calculator › adds two numbers (3ms)
    ```

    ### Step 3: Refactor - Improve the Code

    **Improve code quality while keeping tests green**

    ```javascript
    // No refactoring needed yet (code is simple)
    // But let's add more functionality...

    test('subtracts two numbers', () => {
      const calc = new Calculator();
      expect(calc.subtract(5, 3)).toBe(2);
    });

    // ❌ Test fails - subtract method doesn't exist

    // Add subtract method
    class Calculator {
      add(a, b) {
        return a + b;
      }

      subtract(a, b) {
        return a - b;
      }
    }

    // ✅ Tests pass
    ```

    ## TDD Example: Building a Shopping Cart

    ### Iteration 1: Add Items

    ```javascript
    // ❌ RED: Write failing test
    describe('ShoppingCart', () => {
      test('starts empty', () => {
        const cart = new ShoppingCart();
        expect(cart.items).toEqual([]);
      });
    });

    // 🟢 GREEN: Minimal implementation
    class ShoppingCart {
      constructor() {
        this.items = [];
      }
    }

    // ✅ Test passes

    // ❌ RED: Add another test
    test('adds item to cart', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      expect(cart.items).toHaveLength(1);
    });

    // 🟢 GREEN: Implement addItem
    class ShoppingCart {
      constructor() {
        this.items = [];
      }

      addItem(item) {
        this.items.push(item);
      }
    }

    // ✅ Test passes
    ```

    ### Iteration 2: Calculate Total

    ```javascript
    // ❌ RED: Test total calculation
    test('calculates total price', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      cart.addItem({ id: 2, name: 'Pen', price: 5 });
      expect(cart.total()).toBe(15);
    });

    // 🟢 GREEN: Implement total
    class ShoppingCart {
      constructor() {
        this.items = [];
      }

      addItem(item) {
        this.items.push(item);
      }

      total() {
        return this.items.reduce((sum, item) => sum + item.price, 0);
      }
    }

    // ✅ Test passes

    // 🔵 REFACTOR: Add input validation
    addItem(item) {
      if (!item || typeof item.price !== 'number') {
        throw new Error('Invalid item');
      }
      this.items.push(item);
    }

    // Add test for validation
    test('throws error for invalid item', () => {
      const cart = new ShoppingCart();
      expect(() => cart.addItem(null)).toThrow('Invalid item');
    });

    // ✅ All tests still pass
    ```

    ### Iteration 3: Remove Items

    ```javascript
    // ❌ RED: Test removing items
    test('removes item by id', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      cart.addItem({ id: 2, name: 'Pen', price: 5 });

      cart.removeItem(1);

      expect(cart.items).toHaveLength(1);
      expect(cart.items[0].id).toBe(2);
    });

    // 🟢 GREEN: Implement removeItem
    class ShoppingCart {
      // ... previous methods ...

      removeItem(itemId) {
        this.items = this.items.filter(item => item.id !== itemId);
      }
    }

    // ✅ Test passes
    ```

    ## Benefits of TDD

    ✅ **Better Design**
    - Forces you to think about interfaces first
    - Encourages modular, testable code
    - YAGNI (You Aren't Gonna Need It) - only build what's needed

    ✅ **Documentation**
    - Tests serve as executable documentation
    - Shows how to use your code

    ✅ **Confidence**
    - Safe refactoring (tests catch regressions)
    - Less debugging time
    - Faster feature development (in long run)

    ✅ **Fewer Bugs**
    - Bugs caught early (cheap to fix)
    - Edge cases considered upfront

    ## Test Coverage

    **Test coverage measures how much of your code is executed by tests**

    ### Coverage Metrics

    ```javascript
    // Example function
    function calculateDiscount(price, userType) {
      if (price < 0) {
        throw new Error('Invalid price');
      }

      if (userType === 'VIP') {
        return price * 0.8; // 20% discount
      } else if (userType === 'regular') {
        return price * 0.95; // 5% discount
      } else {
        return price; // No discount
      }
    }
    ```

    **Coverage types:**

    1. **Line Coverage**: % of lines executed
    ```javascript
    // Test 1: covers lines 2-3
    test('throws error for negative price', () => {
      expect(() => calculateDiscount(-10, 'regular')).toThrow();
    });

    // Test 2: covers lines 6-7
    test('applies VIP discount', () => {
      expect(calculateDiscount(100, 'VIP')).toBe(80);
    });

    // Line coverage: 6/11 lines = 55%
    ```

    2. **Branch Coverage**: % of decision branches taken
    ```javascript
    // Need tests for all branches:
    // - price < 0 (true)
    // - userType === 'VIP' (true)
    // - userType === 'regular' (true)
    // - else branch (default)

    test('handles unknown user type', () => {
      expect(calculateDiscount(100, 'guest')).toBe(100);
    });

    // Branch coverage: 4/4 branches = 100%
    ```

    3. **Function Coverage**: % of functions called

    4. **Statement Coverage**: % of statements executed

    ### Measuring Coverage

    **Jest (JavaScript):**
    ```bash
    npm test -- --coverage

    # Output:
    -------------------|---------|----------|---------|---------|
    File               | % Stmts | % Branch | % Funcs | % Lines |
    -------------------|---------|----------|---------|---------|
    calculator.js      |     100 |      100 |     100 |     100 |
    shopping-cart.js   |    87.5 |       75 |     100 |    87.5 |
    -------------------|---------|----------|---------|---------|
    ```

    **Pytest (Python):**
    ```bash
    pytest --cov=src --cov-report=html

    # Generates HTML report showing uncovered lines
    ```

    ### What Coverage to Aim For?

    **General guidelines:**
    - **80-90% coverage**: Good target for most projects
    - **100% coverage**: Rarely worth the effort
    - **< 70% coverage**: Probably insufficient

    **Focus on:**
    ✅ Business logic (critical code)
    ✅ Complex algorithms
    ✅ Error handling
    ✅ Edge cases

    **Don't obsess over:**
    ❌ Trivial getters/setters
    ❌ Third-party library wrappers
    ❌ Generated code
    ❌ Configuration files

    ```javascript
    // ❌ Don't waste time testing this
    class User {
      getName() {
        return this.name;
      }

      setName(name) {
        this.name = name;
      }
    }

    // ✅ Focus on this instead
    class PaymentProcessor {
      processPayment(amount, card) {
        // Complex business logic
        // Multiple edge cases
        // Needs thorough testing!
      }
    }
    ```

    ## Testing Anti-Patterns

    ### 1. Testing Implementation Details

    ```javascript
    // ❌ BAD: Testing internal implementation
    test('uses array to store items', () => {
      const cart = new ShoppingCart();
      expect(Array.isArray(cart.items)).toBe(true);
    });

    // ✅ GOOD: Testing behavior
    test('stores added items', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      expect(cart.getItems()).toContainEqual({ id: 1, name: 'Book', price: 10 });
    });
    ```

    ### 2. Fragile Tests (Change Detector Tests)

    ```javascript
    // ❌ BAD: Breaks on any implementation change
    test('cart total calculation', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });

      // Testing internal implementation
      expect(cart._calculateSubtotal()).toBe(10);
      expect(cart._calculateTax()).toBe(0.8);
      expect(cart._applyDiscounts()).toBe(0);
      expect(cart.total()).toBe(10.8);
    });

    // ✅ GOOD: Tests public interface only
    test('cart calculates total correctly', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      expect(cart.total()).toBe(10.8);
    });
    ```

    ### 3. Interdependent Tests

    ```javascript
    // ❌ BAD: Tests depend on each other
    describe('User registration', () => {
      let userId;

      test('creates user', () => {
        userId = createUser({ name: 'Alice' });
        expect(userId).toBeDefined();
      });

      test('retrieves user', () => {
        const user = getUser(userId); // Depends on previous test!
        expect(user.name).toBe('Alice');
      });
    });

    // ✅ GOOD: Independent tests
    describe('User registration', () => {
      test('creates user', () => {
        const userId = createUser({ name: 'Alice' });
        expect(userId).toBeDefined();
      });

      test('retrieves user', () => {
        const userId = createUser({ name: 'Bob' });
        const user = getUser(userId);
        expect(user.name).toBe('Bob');
      });
    });
    ```

    ### 4. Excessive Mocking

    ```javascript
    // ❌ BAD: Mocking everything
    test('processes order', () => {
      const mockInventory = jest.fn().mockReturnValue(true);
      const mockPayment = jest.fn().mockReturnValue({ success: true });
      const mockShipping = jest.fn().mockReturnValue({ trackingId: '123' });
      const mockEmail = jest.fn();
      const mockDatabase = jest.fn();

      processOrder(mockInventory, mockPayment, mockShipping, mockEmail, mockDatabase);

      // Test verifies nothing about actual behavior!
    });

    // ✅ GOOD: Mock only external dependencies
    test('processes order', () => {
      const mockPaymentGateway = {
        charge: jest.fn().mockResolvedValue({ success: true })
      };

      const result = processOrder({
        items: [{ id: 1, price: 10 }],
        paymentGateway: mockPaymentGateway
      });

      expect(result.success).toBe(true);
      expect(mockPaymentGateway.charge).toHaveBeenCalledWith(10);
    });
    ```

    ### 5. Slow Tests

    ```python
    # ❌ BAD: Slow, unnecessary sleep
    def test_async_operation():
        start_operation()
        time.sleep(5)  # Wait for operation to complete
        assert operation_completed()

    # ✅ GOOD: Wait for condition
    def test_async_operation():
        start_operation()
        wait_until(lambda: operation_completed(), timeout=5)
        assert operation_completed()
    ```

    ## CI/CD Integration

    ### GitHub Actions Example

    ```yaml
    # .github/workflows/test.yml
    name: Run Tests

    on:
      push:
        branches: [ main, develop ]
      pull_request:
        branches: [ main ]

    jobs:
      test:
        runs-on: ubuntu-latest

        services:
          postgres:
            image: postgres:15
            env:
              POSTGRES_PASSWORD: test
            options: >-
              --health-cmd pg_isready
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5

        steps:
          - uses: actions/checkout@v3

          - name: Setup Node.js
            uses: actions/setup-node@v3
            with:
              node-version: '18'
              cache: 'npm'

          - name: Install dependencies
            run: npm ci

          - name: Run linter
            run: npm run lint

          - name: Run unit tests
            run: npm test -- --coverage

          - name: Run integration tests
            run: npm run test:integration
            env:
              DATABASE_URL: postgres://postgres:test@localhost:5432/testdb

          - name: Upload coverage
            uses: codecov/codecov-action@v3
            with:
              files: ./coverage/coverage-final.json

          - name: Run E2E tests
            run: npm run test:e2e

          - name: Archive test results
            if: failure()
            uses: actions/upload-artifact@v3
            with:
              name: test-results
              path: |
                coverage/
                test-results/
    ```

    ### GitLab CI Example

    ```yaml
    # .gitlab-ci.yml
    stages:
      - lint
      - test
      - build

    variables:
      POSTGRES_DB: testdb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: test

    lint:
      stage: lint
      image: node:18
      script:
        - npm ci
        - npm run lint

    unit-tests:
      stage: test
      image: node:18
      script:
        - npm ci
        - npm test -- --coverage
      coverage: '/Lines\s*:\s*(\d+\.\d+)%/'
      artifacts:
        reports:
          coverage_report:
            coverage_format: cobertura
            path: coverage/cobertura-coverage.xml

    integration-tests:
      stage: test
      image: node:18
      services:
        - postgres:15
      variables:
        DATABASE_URL: postgres://postgres:test@postgres:5432/testdb
      script:
        - npm ci
        - npm run test:integration

    e2e-tests:
      stage: test
      image: cypress/browsers:node18.12.0-chrome107
      script:
        - npm ci
        - npm run test:e2e
      artifacts:
        when: on_failure
        paths:
          - cypress/screenshots
          - cypress/videos
    ```

    ### Jenkins Pipeline Example

    ```groovy
    // Jenkinsfile
    pipeline {
      agent any

      stages {
        stage('Install') {
          steps {
            sh 'npm ci'
          }
        }

        stage('Lint') {
          steps {
            sh 'npm run lint'
          }
        }

        stage('Unit Tests') {
          steps {
            sh 'npm test -- --coverage'
          }
          post {
            always {
              publishHTML([
                reportDir: 'coverage',
                reportFiles: 'index.html',
                reportName: 'Coverage Report'
              ])
            }
          }
        }

        stage('Integration Tests') {
          steps {
            sh 'docker-compose up -d postgres'
            sh 'npm run test:integration'
          }
          post {
            always {
              sh 'docker-compose down'
            }
          }
        }

        stage('E2E Tests') {
          steps {
            sh 'npm run test:e2e'
          }
        }
      }

      post {
        always {
          junit 'test-results/**/*.xml'
        }
        success {
          echo 'All tests passed!'
        }
        failure {
          echo 'Tests failed!'
          mail to: 'team@example.com',
               subject: "Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
               body: "Check console output at ${env.BUILD_URL}"
        }
      }
    }
    ```

    ## Testing Best Practices Summary

    ### Do:
    ✅ Write tests first (TDD)
    ✅ Test behavior, not implementation
    ✅ Keep tests independent
    ✅ Use descriptive test names
    ✅ Follow AAA pattern
    ✅ Aim for 80-90% coverage
    ✅ Mock external dependencies
    ✅ Run tests in CI/CD
    ✅ Keep tests fast
    ✅ Treat test code like production code

    ### Don't:
    ❌ Test private methods directly
    ❌ Write interdependent tests
    ❌ Mock everything
    ❌ Obsess over 100% coverage
    ❌ Write slow tests
    ❌ Skip edge cases
    ❌ Test third-party libraries
    ❌ Ignore flaky tests
    ❌ Write tests after implementation (unless legacy code)

    ## Real-World Example: Testing Checklist

    **Before pushing code:**
    ```bash
    # 1. Run tests locally
    npm test

    # 2. Check coverage
    npm test -- --coverage

    # 3. Run linter
    npm run lint

    # 4. Run integration tests
    npm run test:integration

    # 5. Run E2E tests (critical paths)
    npm run test:e2e

    # 6. Push code
    git push

    # CI will run all tests again and block merge if any fail
    ```

    **Continuous improvement:**
    - Monitor test execution time (keep under 10 minutes)
    - Track flaky tests and fix them
    - Update tests when requirements change
    - Refactor tests to reduce duplication
    - Add tests for every bug fix

    **Next steps:** Apply these principles to your own projects. Start with TDD for new features, and gradually add tests to existing code.
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

# Unit Testing Fundamentals

    **Unit testing** is the practice of testing individual components of your code in isolation to ensure they work correctly.

    ## Types of Tests

    ### 1. Unit Tests
    **Test individual functions/methods in isolation**

    ```javascript
    // Function to test
    function add(a, b) {
      return a + b;
    }

    // Unit test
    test('add function adds two numbers', () => {
      expect(add(2, 3)).toBe(5);
      expect(add(-1, 1)).toBe(0);
      expect(add(0, 0)).toBe(0);
    });
    ```

    **Characteristics:**
    - Fast (milliseconds)
    - Isolated (no external dependencies)
    - Focused (one component)
    - Many (hundreds to thousands)

    ✅ **Pros:**
    - Quick feedback
    - Easy to debug (small scope)
    - Safe to run anywhere
    - Cheap to maintain

    ❌ **Cons:**
    - Don't test integration
    - Mocking can be complex
    - False confidence if too many mocks

    ### 2. Integration Tests
    **Test how components work together**

    ```javascript
    // Integration test: API + Database
    test('POST /users creates user in database', async () => {
      const response = await request(app)
        .post('/api/users')
        .send({ name: 'Alice', email: 'alice@example.com' });

      expect(response.status).toBe(201);

      // Verify database has the user
      const user = await db.users.findOne({ email: 'alice@example.com' });
      expect(user.name).toBe('Alice');
    });
    ```

    **Characteristics:**
    - Slower (seconds)
    - Tests real interactions
    - May require database/services
    - Moderate number (dozens to hundreds)

    ✅ **Pros:**
    - Tests real behavior
    - Catches integration issues
    - More confidence

    ❌ **Cons:**
    - Slower execution
    - More setup required
    - Harder to debug
    - Environment dependencies

    ### 3. End-to-End (E2E) Tests
    **Test complete user workflows**

    ```javascript
    // E2E test with Cypress
    describe('User Login Flow', () => {
      it('user can log in and see dashboard', () => {
        cy.visit('/login');
        cy.get('input[name="email"]').type('user@example.com');
        cy.get('input[name="password"]').type('password123');
        cy.get('button[type="submit"]').click();

        // Verify redirect to dashboard
        cy.url().should('include', '/dashboard');
        cy.contains('Welcome back').should('be.visible');
      });
    });
    ```

    **Characteristics:**
    - Slowest (seconds to minutes)
    - Tests from user perspective
    - Full stack involved
    - Few tests (dozens)

    ✅ **Pros:**
    - Tests real user scenarios
    - Highest confidence
    - Catches UI issues

    ❌ **Cons:**
    - Very slow
    - Brittle (UI changes break tests)
    - Expensive to maintain
    - Harder to debug

    ## The Test Pyramid

    ```
                    ╱╲
                   ╱  ╲
                  ╱ E2E ╲      ← Few (slow, expensive)
                 ╱────────╲
                ╱          ╲
               ╱            ╲
              ╱ Integration  ╲  ← Some (medium speed)
             ╱────────────────╲
            ╱                  ╲
           ╱                    ╱
          ╱    Unit Tests      ╱  ← Many (fast, cheap)
         ╱────────────────────╱
    ```

    **Ideal distribution:**
    - 70% Unit tests
    - 20% Integration tests
    - 10% E2E tests

    **Why this ratio?**

    ```python
    # Unit tests: Fast feedback loop
    Run 1000 unit tests: 5 seconds ✓
    Run 100 integration tests: 2 minutes
    Run 10 E2E tests: 5 minutes

    Total: ~7 minutes for comprehensive coverage
    ```

    ### Anti-Pattern: Ice Cream Cone

    ```
         ╱╲
        ╱  ╲
       ╱    ╲
      ╱ E2E  ╲      ← Too many! Slow, brittle
     ╱────────╲
    ╱          ╲
    ╲ Integration/    ← Some
     ╲──────────╱
      ╲        ╱
       ╲ Unit ╱       ← Too few! Miss bugs
        ╲────╱
    ```

    ❌ **Problems:**
    - Tests take hours to run
    - High maintenance cost
    - Slow feedback
    - Developers skip tests

    ## AAA Pattern (Arrange, Act, Assert)

    **Standard structure for writing clear tests**

    ### Example 1: JavaScript (Jest)

    ```javascript
    describe('ShoppingCart', () => {
      test('adds item to cart', () => {
        // ARRANGE: Set up test data
        const cart = new ShoppingCart();
        const item = { id: 1, name: 'Book', price: 10 };

        // ACT: Perform the action
        cart.addItem(item);

        // ASSERT: Verify the result
        expect(cart.items).toHaveLength(1);
        expect(cart.items[0]).toEqual(item);
        expect(cart.total()).toBe(10);
      });

      test('calculates total with multiple items', () => {
        // ARRANGE
        const cart = new ShoppingCart();
        const item1 = { id: 1, name: 'Book', price: 10 };
        const item2 = { id: 2, name: 'Pen', price: 5 };

        // ACT
        cart.addItem(item1);
        cart.addItem(item2);

        // ASSERT
        expect(cart.total()).toBe(15);
      });
    });
    ```

    ### Example 2: Python (Pytest)

    ```python
    import pytest
    from shopping_cart import ShoppingCart, Item

    class TestShoppingCart:
        def test_add_item_to_cart(self):
            # ARRANGE
            cart = ShoppingCart()
            item = Item(id=1, name='Book', price=10.0)

            # ACT
            cart.add_item(item)

            # ASSERT
            assert len(cart.items) == 1
            assert cart.items[0] == item
            assert cart.total() == 10.0

        def test_remove_item_from_cart(self):
            # ARRANGE
            cart = ShoppingCart()
            item = Item(id=1, name='Book', price=10.0)
            cart.add_item(item)

            # ACT
            cart.remove_item(item.id)

            # ASSERT
            assert len(cart.items) == 0
            assert cart.total() == 0.0
    ```

    ### Example 3: Java (JUnit)

    ```java
    import org.junit.jupiter.api.Test;
    import static org.junit.jupiter.api.Assertions.*;

    class ShoppingCartTest {
        @Test
        void testAddItemToCart() {
            // ARRANGE
            ShoppingCart cart = new ShoppingCart();
            Item item = new Item(1, "Book", 10.0);

            // ACT
            cart.addItem(item);

            // ASSERT
            assertEquals(1, cart.getItems().size());
            assertEquals(item, cart.getItems().get(0));
            assertEquals(10.0, cart.getTotal(), 0.01);
        }

        @Test
        void testApplyDiscount() {
            // ARRANGE
            ShoppingCart cart = new ShoppingCart();
            cart.addItem(new Item(1, "Book", 100.0));

            // ACT
            cart.applyDiscount(0.10); // 10% discount

            // ASSERT
            assertEquals(90.0, cart.getTotal(), 0.01);
        }
    }
    ```

    ## Mocking and Stubbing

    **Isolate units by replacing dependencies with test doubles**

    ### What are Test Doubles?

    - **Stub**: Returns predefined data
    - **Mock**: Verifies interactions were called
    - **Fake**: Working implementation (simpler)
    - **Spy**: Records calls for verification

    ### Example 1: Mocking in Jest

    ```javascript
    // user-service.js
    class UserService {
      constructor(database) {
        this.database = database;
      }

      async getUser(id) {
        return await this.database.query('SELECT * FROM users WHERE id = ?', id);
      }

      async createUser(userData) {
        const existingUser = await this.database.query(
          'SELECT * FROM users WHERE email = ?',
          userData.email
        );

        if (existingUser) {
          throw new Error('User already exists');
        }

        return await this.database.insert('users', userData);
      }
    }

    // user-service.test.js
    describe('UserService', () => {
      test('getUser returns user from database', async () => {
        // ARRANGE: Mock database
        const mockDatabase = {
          query: jest.fn().mockResolvedValue({ id: 1, name: 'Alice' })
        };
        const userService = new UserService(mockDatabase);

        // ACT
        const user = await userService.getUser(1);

        // ASSERT
        expect(mockDatabase.query).toHaveBeenCalledWith(
          'SELECT * FROM users WHERE id = ?',
          1
        );
        expect(user).toEqual({ id: 1, name: 'Alice' });
      });

      test('createUser throws error if user exists', async () => {
        // ARRANGE
        const mockDatabase = {
          query: jest.fn().mockResolvedValue({ id: 1, email: 'alice@test.com' }),
          insert: jest.fn()
        };
        const userService = new UserService(mockDatabase);

        // ACT & ASSERT
        await expect(
          userService.createUser({ email: 'alice@test.com', name: 'Alice' })
        ).rejects.toThrow('User already exists');

        expect(mockDatabase.insert).not.toHaveBeenCalled();
      });
    });
    ```

    ### Example 2: Mocking in Python (unittest.mock)

    ```python
    from unittest.mock import Mock, patch
    import pytest
    from user_service import UserService

    class TestUserService:
        def test_get_user_returns_user_from_database(self):
            # ARRANGE: Mock database
            mock_db = Mock()
            mock_db.query.return_value = {'id': 1, 'name': 'Alice'}
            user_service = UserService(mock_db)

            # ACT
            user = user_service.get_user(1)

            # ASSERT
            mock_db.query.assert_called_once_with(
                'SELECT * FROM users WHERE id = ?', 1
            )
            assert user == {'id': 1, 'name': 'Alice'}

        @patch('user_service.send_email')
        def test_create_user_sends_welcome_email(self, mock_send_email):
            # ARRANGE
            mock_db = Mock()
            mock_db.query.return_value = None  # No existing user
            mock_db.insert.return_value = {'id': 1, 'email': 'alice@test.com'}
            user_service = UserService(mock_db)

            # ACT
            user_service.create_user({'email': 'alice@test.com', 'name': 'Alice'})

            # ASSERT
            mock_send_email.assert_called_once_with(
                to='alice@test.com',
                subject='Welcome!',
                body='Welcome to our service'
            )
    ```

    ### Example 3: Mocking HTTP Requests

    ```javascript
    // weather-service.js
    const axios = require('axios');

    class WeatherService {
      async getTemperature(city) {
        const response = await axios.get(
          `https://api.weather.com/forecast?city=${city}`
        );
        return response.data.temperature;
      }
    }

    // weather-service.test.js
    jest.mock('axios');

    describe('WeatherService', () => {
      test('getTemperature returns temperature for city', async () => {
        // ARRANGE
        axios.get.mockResolvedValue({
          data: { temperature: 72, city: 'San Francisco' }
        });
        const weatherService = new WeatherService();

        // ACT
        const temp = await weatherService.getTemperature('San Francisco');

        // ASSERT
        expect(temp).toBe(72);
        expect(axios.get).toHaveBeenCalledWith(
          'https://api.weather.com/forecast?city=San Francisco'
        );
      });

      test('getTemperature handles API errors', async () => {
        // ARRANGE
        axios.get.mockRejectedValue(new Error('API Error'));
        const weatherService = new WeatherService();

        // ACT & ASSERT
        await expect(
          weatherService.getTemperature('InvalidCity')
        ).rejects.toThrow('API Error');
      });
    });
    ```

    ### Example 4: Spy Pattern

    ```python
    # payment_processor.py
    class PaymentProcessor:
        def __init__(self, payment_gateway):
            self.payment_gateway = payment_gateway
            self.logger = Logger()

        def process_payment(self, amount, card):
            self.logger.info(f'Processing payment: ${amount}')
            result = self.payment_gateway.charge(amount, card)

            if result.success:
                self.logger.info(f'Payment successful: {result.transaction_id}')
            else:
                self.logger.error(f'Payment failed: {result.error}')

            return result

    # test_payment_processor.py
    from unittest.mock import Mock, call
    import pytest

    def test_process_payment_logs_correctly():
        # ARRANGE
        mock_gateway = Mock()
        mock_gateway.charge.return_value = Mock(
            success=True,
            transaction_id='txn_123'
        )

        processor = PaymentProcessor(mock_gateway)
        processor.logger = Mock()  # Spy on logger

        # ACT
        processor.process_payment(100.0, {'number': '4111111111111111'})

        # ASSERT: Verify logger was called correctly
        assert processor.logger.info.call_count == 2
        processor.logger.info.assert_has_calls([
            call('Processing payment: $100.0'),
            call('Payment successful: txn_123')
        ])
    ```

    ## When to Mock vs Use Real Dependencies

    ### Mock These:
    - External APIs (slow, costs money, rate limits)
    - Databases (in unit tests)
    - File system operations
    - Email services
    - Payment gateways
    - Time/dates (for deterministic tests)

    ```python
    # Mock time for deterministic tests
    from unittest.mock import patch
    from datetime import datetime

    def test_is_business_hours():
        # Test at 2 PM (business hours)
        with patch('datetime.datetime') as mock_datetime:
            mock_datetime.now.return_value = datetime(2024, 1, 1, 14, 0)
            assert is_business_hours() == True

        # Test at 8 PM (after hours)
        with patch('datetime.datetime') as mock_datetime:
            mock_datetime.now.return_value = datetime(2024, 1, 1, 20, 0)
            assert is_business_hours() == False
    ```

    ### Use Real Dependencies:
    - Pure functions (no side effects)
    - Simple utilities
    - Value objects
    - Your own domain logic

    ```javascript
    // Don't mock these - test directly
    class Money {
      constructor(amount, currency) {
        this.amount = amount;
        this.currency = currency;
      }

      add(other) {
        if (this.currency !== other.currency) {
          throw new Error('Currency mismatch');
        }
        return new Money(this.amount + other.amount, this.currency);
      }
    }

    // Test with real objects
    test('Money.add combines amounts', () => {
      const m1 = new Money(10, 'USD');
      const m2 = new Money(20, 'USD');

      const result = m1.add(m2);

      expect(result.amount).toBe(30);
      expect(result.currency).toBe('USD');
    });
    ```

    ## Test Naming Conventions

    ### Good Test Names

    ```javascript
    // Pattern: test_[method]_[scenario]_[expected_result]

    // ✅ Good
    test('add_validNumbers_returnsSum')
    test('createUser_duplicateEmail_throwsError')
    test('calculateDiscount_vipCustomer_applies20PercentDiscount')

    // ❌ Bad (too vague)
    test('test1')
    test('addTest')
    test('userCreation')
    ```

    ### Describe Blocks for Organization

    ```javascript
    describe('ShoppingCart', () => {
      describe('addItem', () => {
        test('adds item to empty cart', () => { /* ... */ });
        test('adds item to cart with existing items', () => { /* ... */ });
        test('throws error if item is null', () => { /* ... */ });
      });

      describe('removeItem', () => {
        test('removes item by id', () => { /* ... */ });
        test('throws error if item not found', () => { /* ... */ });
      });

      describe('total', () => {
        test('returns zero for empty cart', () => { /* ... */ });
        test('sums all item prices', () => { /* ... */ });
        test('applies discount if applicable', () => { /* ... */ });
      });
    });
    ```

    ## Best Practices

    1. **One assertion per test** (when possible)
    ```javascript
    // ✅ Good
    test('cart total is correct', () => {
      expect(cart.total()).toBe(100);
    });

    // ❌ Avoid (testing multiple things)
    test('cart works', () => {
      expect(cart.items).toHaveLength(2);
      expect(cart.total()).toBe(100);
      expect(cart.isEmpty()).toBe(false);
    });
    ```

    2. **Tests should be independent**
    ```javascript
    // ❌ Bad: Tests depend on execution order
    let cart;
    test('test 1', () => {
      cart = new ShoppingCart();
      cart.addItem(item);
    });
    test('test 2', () => {
      expect(cart.items).toHaveLength(1); // Depends on test 1!
    });

    // ✅ Good: Each test is independent
    test('test 1', () => {
      const cart = new ShoppingCart();
      cart.addItem(item);
      expect(cart.items).toHaveLength(1);
    });
    test('test 2', () => {
      const cart = new ShoppingCart();
      expect(cart.items).toHaveLength(0);
    });
    ```

    3. **Use test fixtures/setup**
    ```python
    import pytest

    @pytest.fixture
    def cart():
        """Reusable cart fixture"""
        return ShoppingCart()

    @pytest.fixture
    def cart_with_items():
        """Cart pre-populated with items"""
        cart = ShoppingCart()
        cart.add_item(Item(1, 'Book', 10.0))
        cart.add_item(Item(2, 'Pen', 5.0))
        return cart

    def test_empty_cart_total(cart):
        assert cart.total() == 0.0

    def test_cart_with_items_total(cart_with_items):
        assert cart_with_items.total() == 15.0
    ```

    **Next**: We'll explore integration testing and E2E testing in depth.
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

# Integration and E2E Testing

    **Integration tests** verify that multiple components work together correctly. **E2E tests** verify complete user workflows from start to finish.

    ## API Testing

    ### Testing REST APIs with SuperTest (Node.js)

    ```javascript
    // app.js
    const express = require('express');
    const app = express();
    app.use(express.json());

    const users = [];

    app.post('/api/users', (req, res) => {
      const { name, email } = req.body;

      if (!name || !email) {
        return res.status(400).json({ error: 'Name and email required' });
      }

      const user = { id: users.length + 1, name, email };
      users.push(user);
      res.status(201).json(user);
    });

    app.get('/api/users/:id', (req, res) => {
      const user = users.find(u => u.id === parseInt(req.params.id));
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      res.json(user);
    });

    module.exports = app;

    // app.test.js
    const request = require('supertest');
    const app = require('./app');

    describe('Users API', () => {
      describe('POST /api/users', () => {
        test('creates user with valid data', async () => {
          // ARRANGE
          const userData = { name: 'Alice', email: 'alice@example.com' };

          // ACT
          const response = await request(app)
            .post('/api/users')
            .send(userData)
            .expect(201);

          // ASSERT
          expect(response.body).toMatchObject({
            id: expect.any(Number),
            name: 'Alice',
            email: 'alice@example.com'
          });
        });

        test('returns 400 when name is missing', async () => {
          const response = await request(app)
            .post('/api/users')
            .send({ email: 'alice@example.com' })
            .expect(400);

          expect(response.body.error).toBe('Name and email required');
        });
      });

      describe('GET /api/users/:id', () => {
        test('returns user by id', async () => {
          // ARRANGE: Create user first
          const createResponse = await request(app)
            .post('/api/users')
            .send({ name: 'Bob', email: 'bob@example.com' });
          const userId = createResponse.body.id;

          // ACT
          const response = await request(app)
            .get(`/api/users/${userId}`)
            .expect(200);

          // ASSERT
          expect(response.body).toEqual({
            id: userId,
            name: 'Bob',
            email: 'bob@example.com'
          });
        });

        test('returns 404 for non-existent user', async () => {
          const response = await request(app)
            .get('/api/users/99999')
            .expect(404);

          expect(response.body.error).toBe('User not found');
        });
      });
    });
    ```

    ### Testing REST APIs with Pytest (Python)

    ```python
    # app.py (Flask)
    from flask import Flask, request, jsonify

    app = Flask(__name__)
    users = []

    @app.route('/api/users', methods=['POST'])
    def create_user():
        data = request.get_json()

        if not data.get('name') or not data.get('email'):
            return jsonify({'error': 'Name and email required'}), 400

        user = {
            'id': len(users) + 1,
            'name': data['name'],
            'email': data['email']
        }
        users.append(user)
        return jsonify(user), 201

    @app.route('/api/users/<int:user_id>', methods=['GET'])
    def get_user(user_id):
        user = next((u for u in users if u['id'] == user_id), None)
        if not user:
            return jsonify({'error': 'User not found'}), 404
        return jsonify(user)

    # test_app.py
    import pytest
    from app import app

    @pytest.fixture
    def client():
        app.config['TESTING'] = True
        with app.test_client() as client:
            yield client

    class TestUsersAPI:
        def test_create_user_with_valid_data(self, client):
            # ARRANGE
            user_data = {'name': 'Alice', 'email': 'alice@example.com'}

            # ACT
            response = client.post('/api/users', json=user_data)

            # ASSERT
            assert response.status_code == 201
            data = response.get_json()
            assert data['name'] == 'Alice'
            assert data['email'] == 'alice@example.com'
            assert 'id' in data

        def test_create_user_missing_name(self, client):
            # ACT
            response = client.post('/api/users', json={'email': 'alice@example.com'})

            # ASSERT
            assert response.status_code == 400
            data = response.get_json()
            assert data['error'] == 'Name and email required'

        def test_get_user_by_id(self, client):
            # ARRANGE: Create user first
            create_response = client.post('/api/users', json={
                'name': 'Bob',
                'email': 'bob@example.com'
            })
            user_id = create_response.get_json()['id']

            # ACT
            response = client.get(f'/api/users/{user_id}')

            # ASSERT
            assert response.status_code == 200
            data = response.get_json()
            assert data['name'] == 'Bob'
            assert data['email'] == 'bob@example.com'

        def test_get_nonexistent_user(self, client):
            # ACT
            response = client.get('/api/users/99999')

            # ASSERT
            assert response.status_code == 404
            assert response.get_json()['error'] == 'User not found'
    ```

    ## Database Testing

    ### Option 1: In-Memory Database (SQLite)

    ```javascript
    // database.js
    const { Sequelize, DataTypes } = require('sequelize');

    const sequelize = new Sequelize('sqlite::memory:');

    const User = sequelize.define('User', {
      name: {
        type: DataTypes.STRING,
        allowNull: false
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
      }
    });

    module.exports = { sequelize, User };

    // database.test.js
    const { sequelize, User } = require('./database');

    describe('User Model', () => {
      beforeAll(async () => {
        await sequelize.sync({ force: true });
      });

      afterEach(async () => {
        await User.destroy({ where: {} });
      });

      test('creates user successfully', async () => {
        // ARRANGE
        const userData = { name: 'Alice', email: 'alice@example.com' };

        // ACT
        const user = await User.create(userData);

        // ASSERT
        expect(user.id).toBeDefined();
        expect(user.name).toBe('Alice');
        expect(user.email).toBe('alice@example.com');
      });

      test('enforces unique email constraint', async () => {
        // ARRANGE
        await User.create({ name: 'Alice', email: 'alice@example.com' });

        // ACT & ASSERT
        await expect(
          User.create({ name: 'Bob', email: 'alice@example.com' })
        ).rejects.toThrow();
      });

      test('finds user by email', async () => {
        // ARRANGE
        await User.create({ name: 'Alice', email: 'alice@example.com' });

        // ACT
        const user = await User.findOne({ where: { email: 'alice@example.com' } });

        // ASSERT
        expect(user).toBeDefined();
        expect(user.name).toBe('Alice');
      });
    });
    ```

    ### Option 2: Test Containers (Real Database)

    ```javascript
    // database.test.js (with Testcontainers)
    const { GenericContainer } = require('testcontainers');
    const { Sequelize, DataTypes } = require('sequelize');

    describe('User Model with PostgreSQL', () => {
      let container;
      let sequelize;
      let User;

      beforeAll(async () => {
        // Start PostgreSQL container
        container = await new GenericContainer('postgres:15')
          .withEnvironment({ POSTGRES_PASSWORD: 'test' })
          .withExposedPorts(5432)
          .start();

        const host = container.getHost();
        const port = container.getMappedPort(5432);

        // Connect to PostgreSQL
        sequelize = new Sequelize({
          dialect: 'postgres',
          host,
          port,
          username: 'postgres',
          password: 'test',
          database: 'postgres',
          logging: false
        });

        User = sequelize.define('User', {
          name: DataTypes.STRING,
          email: { type: DataTypes.STRING, unique: true }
        });

        await sequelize.sync({ force: true });
      }, 60000);

      afterAll(async () => {
        await sequelize.close();
        await container.stop();
      });

      test('creates user in real PostgreSQL', async () => {
        const user = await User.create({
          name: 'Alice',
          email: 'alice@example.com'
        });

        expect(user.id).toBeDefined();

        // Verify in database
        const found = await User.findByPk(user.id);
        expect(found.name).toBe('Alice');
      });
    });
    ```

    ### Python with Testcontainers

    ```python
    # test_database.py
    import pytest
    from testcontainers.postgres import PostgresContainer
    from sqlalchemy import create_engine, Column, Integer, String
    from sqlalchemy.ext.declarative import declarative_base
    from sqlalchemy.orm import sessionmaker

    Base = declarative_base()

    class User(Base):
        __tablename__ = 'users'
        id = Column(Integer, primary_key=True)
        name = Column(String, nullable=False)
        email = Column(String, unique=True, nullable=False)

    @pytest.fixture(scope='module')
    def database():
        with PostgresContainer('postgres:15') as postgres:
            engine = create_engine(postgres.get_connection_url())
            Base.metadata.create_all(engine)
            Session = sessionmaker(bind=engine)
            yield Session()

    class TestUserModel:
        def test_create_user(self, database):
            # ARRANGE
            session = database

            # ACT
            user = User(name='Alice', email='alice@example.com')
            session.add(user)
            session.commit()

            # ASSERT
            assert user.id is not None

            # Verify in database
            found = session.query(User).filter_by(email='alice@example.com').first()
            assert found.name == 'Alice'

        def test_unique_email_constraint(self, database):
            # ARRANGE
            session = database
            user1 = User(name='Alice', email='alice@example.com')
            session.add(user1)
            session.commit()

            # ACT & ASSERT
            user2 = User(name='Bob', email='alice@example.com')
            session.add(user2)

            with pytest.raises(Exception):  # Unique constraint violation
                session.commit()
    ```

    ## End-to-End Testing with Cypress

    ### Setup Cypress

    ```bash
    npm install --save-dev cypress
    npx cypress open
    ```

    ### Example 1: User Registration Flow

    ```javascript
    // cypress/e2e/registration.cy.js
    describe('User Registration', () => {
      beforeEach(() => {
        // Reset database before each test
        cy.task('db:reset');
        cy.visit('/register');
      });

      it('successfully registers a new user', () => {
        // ARRANGE & ACT
        cy.get('input[name="name"]').type('Alice Johnson');
        cy.get('input[name="email"]').type('alice@example.com');
        cy.get('input[name="password"]').type('SecurePass123!');
        cy.get('input[name="confirmPassword"]').type('SecurePass123!');
        cy.get('button[type="submit"]').click();

        // ASSERT
        cy.url().should('include', '/dashboard');
        cy.contains('Welcome, Alice Johnson').should('be.visible');

        // Verify email was sent (check via API)
        cy.request('/api/test/emails').then((response) => {
          const emails = response.body;
          expect(emails).to.have.length(1);
          expect(emails[0].to).to.equal('alice@example.com');
          expect(emails[0].subject).to.include('Welcome');
        });
      });

      it('shows error for duplicate email', () => {
        // ARRANGE: Create user first
        cy.task('db:createUser', {
          name: 'Existing User',
          email: 'alice@example.com'
        });

        // ACT
        cy.get('input[name="name"]').type('Alice Johnson');
        cy.get('input[name="email"]').type('alice@example.com');
        cy.get('input[name="password"]').type('SecurePass123!');
        cy.get('input[name="confirmPassword"]').type('SecurePass123!');
        cy.get('button[type="submit"]').click();

        // ASSERT
        cy.contains('Email already exists').should('be.visible');
        cy.url().should('include', '/register');
      });

      it('validates password requirements', () => {
        // ACT
        cy.get('input[name="name"]').type('Alice Johnson');
        cy.get('input[name="email"]').type('alice@example.com');
        cy.get('input[name="password"]').type('weak');
        cy.get('input[name="confirmPassword"]').type('weak');
        cy.get('button[type="submit"]').click();

        // ASSERT
        cy.contains('Password must be at least 8 characters').should('be.visible');
      });
    });
    ```

    ### Example 2: Shopping Cart E2E Test

    ```javascript
    // cypress/e2e/shopping-cart.cy.js
    describe('Shopping Cart', () => {
      beforeEach(() => {
        cy.task('db:reset');
        cy.task('db:seedProducts');
        cy.visit('/');
      });

      it('adds items to cart and completes checkout', () => {
        // Browse products
        cy.contains('MacBook Pro').click();
        cy.contains('Add to Cart').click();
        cy.contains('Added to cart').should('be.visible');

        // View cart
        cy.get('[data-testid="cart-icon"]').click();
        cy.url().should('include', '/cart');

        // Verify item in cart
        cy.contains('MacBook Pro').should('be.visible');
        cy.contains('$2,399.00').should('be.visible');

        // Update quantity
        cy.get('input[type="number"]').clear().type('2');
        cy.contains('$4,798.00').should('be.visible');

        // Proceed to checkout
        cy.contains('Checkout').click();
        cy.url().should('include', '/checkout');

        // Fill shipping info
        cy.get('input[name="fullName"]').type('Alice Johnson');
        cy.get('input[name="address"]').type('123 Main St');
        cy.get('input[name="city"]').type('San Francisco');
        cy.get('select[name="state"]').select('CA');
        cy.get('input[name="zip"]').type('94102');

        // Fill payment info
        cy.get('input[name="cardNumber"]').type('4111111111111111');
        cy.get('input[name="expiry"]').type('12/25');
        cy.get('input[name="cvv"]').type('123');

        // Submit order
        cy.contains('Place Order').click();

        // Verify success
        cy.url().should('include', '/order/confirmation');
        cy.contains('Order confirmed').should('be.visible');
        cy.contains('Order #').should('be.visible');

        // Verify email sent
        cy.request('/api/test/emails').then((response) => {
          const emails = response.body;
          const confirmationEmail = emails.find(e =>
            e.subject.includes('Order Confirmation')
          );
          expect(confirmationEmail).to.exist;
        });
      });

      it('applies discount code', () => {
        // Add item to cart
        cy.contains('MacBook Pro').click();
        cy.contains('Add to Cart').click();
        cy.get('[data-testid="cart-icon"]').click();

        // Apply discount
        cy.get('input[name="discountCode"]').type('SAVE20');
        cy.contains('Apply').click();

        // Verify discount applied
        cy.contains('Discount (20%)').should('be.visible');
        cy.contains('$1,919.20').should('be.visible'); // $2,399 - 20%
      });
    });
    ```

    ## End-to-End Testing with Selenium

    ```python
    # test_e2e.py (Python + Selenium)
    import pytest
    from selenium import webdriver
    from selenium.webdriver.common.by import By
    from selenium.webdriver.support.ui import WebDriverWait
    from selenium.webdriver.support import expected_conditions as EC

    @pytest.fixture
    def driver():
        driver = webdriver.Chrome()
        driver.implicitly_wait(10)
        yield driver
        driver.quit()

    class TestUserRegistration:
        def test_successful_registration(self, driver):
            # ARRANGE
            driver.get('http://localhost:3000/register')

            # ACT
            driver.find_element(By.NAME, 'name').send_keys('Alice Johnson')
            driver.find_element(By.NAME, 'email').send_keys('alice@example.com')
            driver.find_element(By.NAME, 'password').send_keys('SecurePass123!')
            driver.find_element(By.NAME, 'confirmPassword').send_keys('SecurePass123!')
            driver.find_element(By.CSS_SELECTOR, 'button[type="submit"]').click()

            # ASSERT
            WebDriverWait(driver, 10).until(
                EC.url_contains('/dashboard')
            )
            assert 'Welcome, Alice Johnson' in driver.page_source

        def test_duplicate_email_error(self, driver):
            # ARRANGE: User already exists
            # (Assume database seeded with user)

            # ACT
            driver.get('http://localhost:3000/register')
            driver.find_element(By.NAME, 'name').send_keys('Alice Johnson')
            driver.find_element(By.NAME, 'email').send_keys('existing@example.com')
            driver.find_element(By.NAME, 'password').send_keys('SecurePass123!')
            driver.find_element(By.NAME, 'confirmPassword').send_keys('SecurePass123!')
            driver.find_element(By.CSS_SELECTOR, 'button[type="submit"]').click()

            # ASSERT
            error_message = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CLASS_NAME, 'error-message'))
            )
            assert 'Email already exists' in error_message.text

    class TestLoginFlow:
        def test_successful_login(self, driver):
            # ACT
            driver.get('http://localhost:3000/login')
            driver.find_element(By.NAME, 'email').send_keys('user@example.com')
            driver.find_element(By.NAME, 'password').send_keys('password123')
            driver.find_element(By.CSS_SELECTOR, 'button[type="submit"]').click()

            # ASSERT
            WebDriverWait(driver, 10).until(
                EC.url_contains('/dashboard')
            )
            profile_button = driver.find_element(By.ID, 'user-profile')
            assert profile_button.is_displayed()

        def test_invalid_credentials(self, driver):
            # ACT
            driver.get('http://localhost:3000/login')
            driver.find_element(By.NAME, 'email').send_keys('user@example.com')
            driver.find_element(By.NAME, 'password').send_keys('wrongpassword')
            driver.find_element(By.CSS_SELECTOR, 'button[type="submit"]').click()

            # ASSERT
            error_message = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CLASS_NAME, 'error'))
            )
            assert 'Invalid email or password' in error_message.text
    ```

    ## Cypress vs Selenium

    | Feature | Cypress | Selenium |
    |---------|---------|----------|
    | **Speed** | Fast (runs in browser) | Slower (WebDriver protocol) |
    | **Setup** | Easy (npm install) | Complex (drivers, grid) |
    | **Debugging** | Excellent (time travel, snapshots) | Basic |
    | **Languages** | JavaScript only | Multiple (Python, Java, JS, etc.) |
    | **Real browser** | Chrome/Firefox/Edge | All browsers |
    | **Cross-browser** | Limited | Excellent |
    | **Mobile** | No | Yes (Appium) |
    | **Community** | Growing | Mature |

    **Choose Cypress if:**
    - JavaScript project
    - Focus on modern browsers
    - Want fast feedback and great DX

    **Choose Selenium if:**
    - Need multiple languages
    - Need all browsers (Safari, IE)
    - Need mobile testing
    - Large existing Selenium investment

    ## Best Practices for Integration/E2E Tests

    ### 1. Use Test Data Builders

    ```javascript
    // test-helpers/builders.js
    class UserBuilder {
      constructor() {
        this.user = {
          name: 'Test User',
          email: `test${Date.now()}@example.com`,
          password: 'TestPass123!'
        };
      }

      withName(name) {
        this.user.name = name;
        return this;
      }

      withEmail(email) {
        this.user.email = email;
        return this;
      }

      build() {
        return this.user;
      }
    }

    // Usage in tests
    test('creates user', async () => {
      const user = new UserBuilder()
        .withName('Alice')
        .withEmail('alice@test.com')
        .build();

      const response = await request(app)
        .post('/api/users')
        .send(user);

      expect(response.status).toBe(201);
    });
    ```

    ### 2. Clean Up Test Data

    ```javascript
    describe('Users API', () => {
      const createdUserIds = [];

      afterEach(async () => {
        // Clean up created users
        for (const id of createdUserIds) {
          await User.destroy({ where: { id } });
        }
        createdUserIds.length = 0;
      });

      test('creates user', async () => {
        const response = await request(app)
          .post('/api/users')
          .send({ name: 'Alice', email: 'alice@test.com' });

        createdUserIds.push(response.body.id);
        expect(response.status).toBe(201);
      });
    });
    ```

    ### 3. Use Page Object Pattern (E2E)

    ```javascript
    // cypress/pages/LoginPage.js
    class LoginPage {
      visit() {
        cy.visit('/login');
      }

      fillEmail(email) {
        cy.get('input[name="email"]').type(email);
        return this;
      }

      fillPassword(password) {
        cy.get('input[name="password"]').type(password);
        return this;
      }

      submit() {
        cy.get('button[type="submit"]').click();
        return this;
      }

      shouldShowError(message) {
        cy.contains(message).should('be.visible');
        return this;
      }
    }

    // cypress/e2e/login.cy.js
    import LoginPage from '../pages/LoginPage';

    describe('Login', () => {
      const loginPage = new LoginPage();

      it('logs in successfully', () => {
        loginPage
          .visit()
          .fillEmail('user@example.com')
          .fillPassword('password123')
          .submit();

        cy.url().should('include', '/dashboard');
      });

      it('shows error for invalid credentials', () => {
        loginPage
          .visit()
          .fillEmail('user@example.com')
          .fillPassword('wrongpassword')
          .submit()
          .shouldShowError('Invalid email or password');
      });
    });
    ```

    ### 4. Wait for Async Operations

    ```javascript
    // ❌ Bad: Fixed timeout
    cy.wait(5000);

    // ✅ Good: Wait for specific condition
    cy.get('[data-testid="loading"]').should('not.exist');
    cy.get('[data-testid="user-profile"]').should('be.visible');

    // ✅ Good: Wait for network request
    cy.intercept('GET', '/api/users').as('getUsers');
    cy.visit('/users');
    cy.wait('@getUsers');
    cy.get('.user-list').should('be.visible');
    ```

    **Next**: We'll dive into Test-Driven Development (TDD) and testing best practices.
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

# TDD and Testing Best Practices

    **Test-Driven Development (TDD)** is a software development approach where you write tests before writing the implementation code.

    ## The Red-Green-Refactor Cycle

    ```
    🔴 RED      →    🟢 GREEN    →    🔵 REFACTOR
    Write failing   Make it pass    Improve code
       test                           quality
         ↑                               ↓
         └───────────────────────────────┘
    ```

    ### Step 1: Red - Write a Failing Test

    **Write the smallest test that fails**

    ```javascript
    // calculator.test.js
    const Calculator = require('./calculator');

    describe('Calculator', () => {
      test('adds two numbers', () => {
        const calc = new Calculator();
        expect(calc.add(2, 3)).toBe(5);
      });
    });

    // Running this test fails because Calculator doesn't exist yet
    // ❌ ReferenceError: Calculator is not defined
    ```

    ### Step 2: Green - Make It Pass

    **Write the minimal code to make the test pass**

    ```javascript
    // calculator.js
    class Calculator {
      add(a, b) {
        return a + b;
      }
    }

    module.exports = Calculator;

    // Now the test passes
    // ✅ Calculator › adds two numbers (3ms)
    ```

    ### Step 3: Refactor - Improve the Code

    **Improve code quality while keeping tests green**

    ```javascript
    // No refactoring needed yet (code is simple)
    // But let's add more functionality...

    test('subtracts two numbers', () => {
      const calc = new Calculator();
      expect(calc.subtract(5, 3)).toBe(2);
    });

    // ❌ Test fails - subtract method doesn't exist

    // Add subtract method
    class Calculator {
      add(a, b) {
        return a + b;
      }

      subtract(a, b) {
        return a - b;
      }
    }

    // ✅ Tests pass
    ```

    ## TDD Example: Building a Shopping Cart

    ### Iteration 1: Add Items

    ```javascript
    // ❌ RED: Write failing test
    describe('ShoppingCart', () => {
      test('starts empty', () => {
        const cart = new ShoppingCart();
        expect(cart.items).toEqual([]);
      });
    });

    // 🟢 GREEN: Minimal implementation
    class ShoppingCart {
      constructor() {
        this.items = [];
      }
    }

    // ✅ Test passes

    // ❌ RED: Add another test
    test('adds item to cart', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      expect(cart.items).toHaveLength(1);
    });

    // 🟢 GREEN: Implement addItem
    class ShoppingCart {
      constructor() {
        this.items = [];
      }

      addItem(item) {
        this.items.push(item);
      }
    }

    // ✅ Test passes
    ```

    ### Iteration 2: Calculate Total

    ```javascript
    // ❌ RED: Test total calculation
    test('calculates total price', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      cart.addItem({ id: 2, name: 'Pen', price: 5 });
      expect(cart.total()).toBe(15);
    });

    // 🟢 GREEN: Implement total
    class ShoppingCart {
      constructor() {
        this.items = [];
      }

      addItem(item) {
        this.items.push(item);
      }

      total() {
        return this.items.reduce((sum, item) => sum + item.price, 0);
      }
    }

    // ✅ Test passes

    // 🔵 REFACTOR: Add input validation
    addItem(item) {
      if (!item || typeof item.price !== 'number') {
        throw new Error('Invalid item');
      }
      this.items.push(item);
    }

    // Add test for validation
    test('throws error for invalid item', () => {
      const cart = new ShoppingCart();
      expect(() => cart.addItem(null)).toThrow('Invalid item');
    });

    // ✅ All tests still pass
    ```

    ### Iteration 3: Remove Items

    ```javascript
    // ❌ RED: Test removing items
    test('removes item by id', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      cart.addItem({ id: 2, name: 'Pen', price: 5 });

      cart.removeItem(1);

      expect(cart.items).toHaveLength(1);
      expect(cart.items[0].id).toBe(2);
    });

    // 🟢 GREEN: Implement removeItem
    class ShoppingCart {
      // ... previous methods ...

      removeItem(itemId) {
        this.items = this.items.filter(item => item.id !== itemId);
      }
    }

    // ✅ Test passes
    ```

    ## Benefits of TDD

    ✅ **Better Design**
    - Forces you to think about interfaces first
    - Encourages modular, testable code
    - YAGNI (You Aren't Gonna Need It) - only build what's needed

    ✅ **Documentation**
    - Tests serve as executable documentation
    - Shows how to use your code

    ✅ **Confidence**
    - Safe refactoring (tests catch regressions)
    - Less debugging time
    - Faster feature development (in long run)

    ✅ **Fewer Bugs**
    - Bugs caught early (cheap to fix)
    - Edge cases considered upfront

    ## Test Coverage

    **Test coverage measures how much of your code is executed by tests**

    ### Coverage Metrics

    ```javascript
    // Example function
    function calculateDiscount(price, userType) {
      if (price < 0) {
        throw new Error('Invalid price');
      }

      if (userType === 'VIP') {
        return price * 0.8; // 20% discount
      } else if (userType === 'regular') {
        return price * 0.95; // 5% discount
      } else {
        return price; // No discount
      }
    }
    ```

    **Coverage types:**

    1. **Line Coverage**: % of lines executed
    ```javascript
    // Test 1: covers lines 2-3
    test('throws error for negative price', () => {
      expect(() => calculateDiscount(-10, 'regular')).toThrow();
    });

    // Test 2: covers lines 6-7
    test('applies VIP discount', () => {
      expect(calculateDiscount(100, 'VIP')).toBe(80);
    });

    // Line coverage: 6/11 lines = 55%
    ```

    2. **Branch Coverage**: % of decision branches taken
    ```javascript
    // Need tests for all branches:
    // - price < 0 (true)
    // - userType === 'VIP' (true)
    // - userType === 'regular' (true)
    // - else branch (default)

    test('handles unknown user type', () => {
      expect(calculateDiscount(100, 'guest')).toBe(100);
    });

    // Branch coverage: 4/4 branches = 100%
    ```

    3. **Function Coverage**: % of functions called

    4. **Statement Coverage**: % of statements executed

    ### Measuring Coverage

    **Jest (JavaScript):**
    ```bash
    npm test -- --coverage

    # Output:
    -------------------|---------|----------|---------|---------|
    File               | % Stmts | % Branch | % Funcs | % Lines |
    -------------------|---------|----------|---------|---------|
    calculator.js      |     100 |      100 |     100 |     100 |
    shopping-cart.js   |    87.5 |       75 |     100 |    87.5 |
    -------------------|---------|----------|---------|---------|
    ```

    **Pytest (Python):**
    ```bash
    pytest --cov=src --cov-report=html

    # Generates HTML report showing uncovered lines
    ```

    ### What Coverage to Aim For?

    **General guidelines:**
    - **80-90% coverage**: Good target for most projects
    - **100% coverage**: Rarely worth the effort
    - **< 70% coverage**: Probably insufficient

    **Focus on:**
    ✅ Business logic (critical code)
    ✅ Complex algorithms
    ✅ Error handling
    ✅ Edge cases

    **Don't obsess over:**
    ❌ Trivial getters/setters
    ❌ Third-party library wrappers
    ❌ Generated code
    ❌ Configuration files

    ```javascript
    // ❌ Don't waste time testing this
    class User {
      getName() {
        return this.name;
      }

      setName(name) {
        this.name = name;
      }
    }

    // ✅ Focus on this instead
    class PaymentProcessor {
      processPayment(amount, card) {
        // Complex business logic
        // Multiple edge cases
        // Needs thorough testing!
      }
    }
    ```

    ## Testing Anti-Patterns

    ### 1. Testing Implementation Details

    ```javascript
    // ❌ BAD: Testing internal implementation
    test('uses array to store items', () => {
      const cart = new ShoppingCart();
      expect(Array.isArray(cart.items)).toBe(true);
    });

    // ✅ GOOD: Testing behavior
    test('stores added items', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      expect(cart.getItems()).toContainEqual({ id: 1, name: 'Book', price: 10 });
    });
    ```

    ### 2. Fragile Tests (Change Detector Tests)

    ```javascript
    // ❌ BAD: Breaks on any implementation change
    test('cart total calculation', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });

      // Testing internal implementation
      expect(cart._calculateSubtotal()).toBe(10);
      expect(cart._calculateTax()).toBe(0.8);
      expect(cart._applyDiscounts()).toBe(0);
      expect(cart.total()).toBe(10.8);
    });

    // ✅ GOOD: Tests public interface only
    test('cart calculates total correctly', () => {
      const cart = new ShoppingCart();
      cart.addItem({ id: 1, name: 'Book', price: 10 });
      expect(cart.total()).toBe(10.8);
    });
    ```

    ### 3. Interdependent Tests

    ```javascript
    // ❌ BAD: Tests depend on each other
    describe('User registration', () => {
      let userId;

      test('creates user', () => {
        userId = createUser({ name: 'Alice' });
        expect(userId).toBeDefined();
      });

      test('retrieves user', () => {
        const user = getUser(userId); // Depends on previous test!
        expect(user.name).toBe('Alice');
      });
    });

    // ✅ GOOD: Independent tests
    describe('User registration', () => {
      test('creates user', () => {
        const userId = createUser({ name: 'Alice' });
        expect(userId).toBeDefined();
      });

      test('retrieves user', () => {
        const userId = createUser({ name: 'Bob' });
        const user = getUser(userId);
        expect(user.name).toBe('Bob');
      });
    });
    ```

    ### 4. Excessive Mocking

    ```javascript
    // ❌ BAD: Mocking everything
    test('processes order', () => {
      const mockInventory = jest.fn().mockReturnValue(true);
      const mockPayment = jest.fn().mockReturnValue({ success: true });
      const mockShipping = jest.fn().mockReturnValue({ trackingId: '123' });
      const mockEmail = jest.fn();
      const mockDatabase = jest.fn();

      processOrder(mockInventory, mockPayment, mockShipping, mockEmail, mockDatabase);

      // Test verifies nothing about actual behavior!
    });

    // ✅ GOOD: Mock only external dependencies
    test('processes order', () => {
      const mockPaymentGateway = {
        charge: jest.fn().mockResolvedValue({ success: true })
      };

      const result = processOrder({
        items: [{ id: 1, price: 10 }],
        paymentGateway: mockPaymentGateway
      });

      expect(result.success).toBe(true);
      expect(mockPaymentGateway.charge).toHaveBeenCalledWith(10);
    });
    ```

    ### 5. Slow Tests

    ```python
    # ❌ BAD: Slow, unnecessary sleep
    def test_async_operation():
        start_operation()
        time.sleep(5)  # Wait for operation to complete
        assert operation_completed()

    # ✅ GOOD: Wait for condition
    def test_async_operation():
        start_operation()
        wait_until(lambda: operation_completed(), timeout=5)
        assert operation_completed()
    ```

    ## CI/CD Integration

    ### GitHub Actions Example

    ```yaml
    # .github/workflows/test.yml
    name: Run Tests

    on:
      push:
        branches: [ main, develop ]
      pull_request:
        branches: [ main ]

    jobs:
      test:
        runs-on: ubuntu-latest

        services:
          postgres:
            image: postgres:15
            env:
              POSTGRES_PASSWORD: test
            options: >-
              --health-cmd pg_isready
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5

        steps:
          - uses: actions/checkout@v3

          - name: Setup Node.js
            uses: actions/setup-node@v3
            with:
              node-version: '18'
              cache: 'npm'

          - name: Install dependencies
            run: npm ci

          - name: Run linter
            run: npm run lint

          - name: Run unit tests
            run: npm test -- --coverage

          - name: Run integration tests
            run: npm run test:integration
            env:
              DATABASE_URL: postgres://postgres:test@localhost:5432/testdb

          - name: Upload coverage
            uses: codecov/codecov-action@v3
            with:
              files: ./coverage/coverage-final.json

          - name: Run E2E tests
            run: npm run test:e2e

          - name: Archive test results
            if: failure()
            uses: actions/upload-artifact@v3
            with:
              name: test-results
              path: |
                coverage/
                test-results/
    ```

    ### GitLab CI Example

    ```yaml
    # .gitlab-ci.yml
    stages:
      - lint
      - test
      - build

    variables:
      POSTGRES_DB: testdb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: test

    lint:
      stage: lint
      image: node:18
      script:
        - npm ci
        - npm run lint

    unit-tests:
      stage: test
      image: node:18
      script:
        - npm ci
        - npm test -- --coverage
      coverage: '/Lines\s*:\s*(\d+\.\d+)%/'
      artifacts:
        reports:
          coverage_report:
            coverage_format: cobertura
            path: coverage/cobertura-coverage.xml

    integration-tests:
      stage: test
      image: node:18
      services:
        - postgres:15
      variables:
        DATABASE_URL: postgres://postgres:test@postgres:5432/testdb
      script:
        - npm ci
        - npm run test:integration

    e2e-tests:
      stage: test
      image: cypress/browsers:node18.12.0-chrome107
      script:
        - npm ci
        - npm run test:e2e
      artifacts:
        when: on_failure
        paths:
          - cypress/screenshots
          - cypress/videos
    ```

    ### Jenkins Pipeline Example

    ```groovy
    // Jenkinsfile
    pipeline {
      agent any

      stages {
        stage('Install') {
          steps {
            sh 'npm ci'
          }
        }

        stage('Lint') {
          steps {
            sh 'npm run lint'
          }
        }

        stage('Unit Tests') {
          steps {
            sh 'npm test -- --coverage'
          }
          post {
            always {
              publishHTML([
                reportDir: 'coverage',
                reportFiles: 'index.html',
                reportName: 'Coverage Report'
              ])
            }
          }
        }

        stage('Integration Tests') {
          steps {
            sh 'docker-compose up -d postgres'
            sh 'npm run test:integration'
          }
          post {
            always {
              sh 'docker-compose down'
            }
          }
        }

        stage('E2E Tests') {
          steps {
            sh 'npm run test:e2e'
          }
        }
      }

      post {
        always {
          junit 'test-results/**/*.xml'
        }
        success {
          echo 'All tests passed!'
        }
        failure {
          echo 'Tests failed!'
          mail to: 'team@example.com',
               subject: "Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
               body: "Check console output at ${env.BUILD_URL}"
        }
      }
    }
    ```

    ## Testing Best Practices Summary

    ### Do:
    ✅ Write tests first (TDD)
    ✅ Test behavior, not implementation
    ✅ Keep tests independent
    ✅ Use descriptive test names
    ✅ Follow AAA pattern
    ✅ Aim for 80-90% coverage
    ✅ Mock external dependencies
    ✅ Run tests in CI/CD
    ✅ Keep tests fast
    ✅ Treat test code like production code

    ### Don't:
    ❌ Test private methods directly
    ❌ Write interdependent tests
    ❌ Mock everything
    ❌ Obsess over 100% coverage
    ❌ Write slow tests
    ❌ Skip edge cases
    ❌ Test third-party libraries
    ❌ Ignore flaky tests
    ❌ Write tests after implementation (unless legacy code)

    ## Real-World Example: Testing Checklist

    **Before pushing code:**
    ```bash
    # 1. Run tests locally
    npm test

    # 2. Check coverage
    npm test -- --coverage

    # 3. Run linter
    npm run lint

    # 4. Run integration tests
    npm run test:integration

    # 5. Run E2E tests (critical paths)
    npm run test:e2e

    # 6. Push code
    git push

    # CI will run all tests again and block merge if any fail
    ```

    **Continuous improvement:**
    - Monitor test execution time (keep under 10 minutes)
    - Track flaky tests and fix them
    - Update tests when requirements change
    - Refactor tests to reduce duplication
    - Add tests for every bug fix

    **Next steps:** Apply these principles to your own projects. Start with TDD for new features, and gradually add tests to existing code.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 7: Practice Question ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: Practice Question ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 9: Practice Question ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 10: Practice Question ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 11: Practice Question ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 12: Lesson 12 ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 12',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Unit Testing Fundamentals

    **Unit testing** is the practice of testing individual components of your code in isolation to ensure they work correctly.

    ## Types of Tests

    ### 1. Unit Tests
    **Test individual functions/methods in isolation**

    ```javascript
    // Function to test
    function add(a, b) {
      return a + b;
    }

    // Unit test
    test('add function adds two numbers', () => {
      expect(add(2, 3)).toBe(5);
      expect(add(-1, 1)).toBe(0);
      expect(add(0, 0)).toBe(0);
    });
    ```

    **Characteristics:**
    - Fast (milliseconds)
    - Isolated (no external dependencies)
    - Focused (one component)
    - Many (hundreds to thousands)

    ✅ **Pros:**
    - Quick feedback
    - Easy to debug (small scope)
    - Safe to run anywhere
    - Cheap to maintain

    ❌ **Cons:**
    - Don't test integration
    - Mocking can be complex
    - False confidence if too many mocks

    ### 2. Integration Tests
    **Test how components work together**

    ```javascript
    // Integration test: API + Database
    test('POST /users creates user in database', async () => {
      const response = await request(app)
        .post('/api/users')
        .send({ name: 'Alice', email: 'alice@example.com' });

      expect(response.status).toBe(201);

      // Verify database has the user
      const user = await db.users.findOne({ email: 'alice@example.com' });
      expect(user.name).toBe('Alice');
    });
    ```

    **Characteristics:**
    - Slower (seconds)
    - Tests real interactions
    - May require database/services
    - Moderate number (dozens to hundreds)

    ✅ **Pros:**
    - Tests real behavior
    - Catches integration issues
    - More confidence

    ❌ **Cons:**
    - Slower execution
    - More setup required
    - Harder to debug
    - Environment dependencies

    ### 3. End-to-End (E2E) Tests
    **Test complete user workflows**

    ```javascript
    // E2E test with Cypress
    describe('User Login Flow', () => {
      it('user can log in and see dashboard', () => {
        cy.visit('/login');
        cy.get('input[name="email"]').type('user@example.com');
        cy.get('input[name="password"]').type('password123');
        cy.get('button[type="submit"]').click();

        // Verify redirect to dashboard
        cy.url().should('include', '/dashboard');
        cy.contains('Welcome back').should('be.visible');
      });
    });
    ```

    **Characteristics:**
    - Slowest (seconds to minutes)
    - Tests from user perspective
    - Full stack involved
    - Few tests (dozens)

    ✅ **Pros:**
    - Tests real user scenarios
    - Highest confidence
    - Catches UI issues

    ❌ **Cons:**
    - Very slow
    - Brittle (UI changes break tests)
    - Expensive to maintain
    - Harder to debug

    ## The Test Pyramid

    ```
                    ╱╲
                   ╱  ╲
                  ╱ E2E ╲      ← Few (slow, expensive)
                 ╱────────╲
                ╱          ╲
               ╱            ╲
              ╱ Integration  ╲  ← Some (medium speed)
             ╱────────────────╲
            ╱                  ╲
           ╱                    ╱
          ╱    Unit Tests      ╱  ← Many (fast, cheap)
         ╱────────────────────╱
    ```

    **Ideal distribution:**
    - 70% Unit tests
    - 20% Integration tests
    - 10% E2E tests

    **Why this ratio?**

    ```python
    # Unit tests: Fast feedback loop
    Run 1000 unit tests: 5 seconds ✓
    Run 100 integration tests: 2 minutes
    Run 10 E2E tests: 5 minutes

    Total: ~7 minutes for comprehensive coverage
    ```

    ### Anti-Pattern: Ice Cream Cone

    ```
         ╱╲
        ╱  ╲
       ╱    ╲
      ╱ E2E  ╲      ← Too many! Slow, brittle
     ╱────────╲
    ╱          ╲
    ╲ Integration/    ← Some
     ╲──────────╱
      ╲        ╱
       ╲ Unit ╱       ← Too few! Miss bugs
        ╲────╱
    ```

    ❌ **Problems:**
    - Tests take hours to run
    - High maintenance cost
    - Slow feedback
    - Developers skip tests

    ## AAA Pattern (Arrange, Act, Assert)

    **Standard structure for writing clear tests**

    ### Example 1: JavaScript (Jest)

    ```javascript
    describe('ShoppingCart', () => {
      test('adds item to cart', () => {
        // ARRANGE: Set up test data
        const cart = new ShoppingCart();
        const item = { id: 1, name: 'Book', price: 10 };

        // ACT: Perform the action
        cart.addItem(item);

        // ASSERT: Verify the result
        expect(cart.items).toHaveLength(1);
        expect(cart.items[0]).toEqual(item);
        expect(cart.total()).toBe(10);
      });

      test('calculates total with multiple items', () => {
        // ARRANGE
        const cart = new ShoppingCart();
        const item1 = { id: 1, name: 'Book', price: 10 };
        const item2 = { id: 2, name: 'Pen', price: 5 };

        // ACT
        cart.addItem(item1);
        cart.addItem(item2);

        // ASSERT
        expect(cart.total()).toBe(15);
      });
    });
    ```

    ### Example 2: Python (Pytest)

    ```python
    import pytest
    from shopping_cart import ShoppingCart, Item

    class TestShoppingCart:
        def test_add_item_to_cart(self):
            # ARRANGE
            cart = ShoppingCart()
            item = Item(id=1, name='Book', price=10.0)

            # ACT
            cart.add_item(item)

            # ASSERT
            assert len(cart.items) == 1
            assert cart.items[0] == item
            assert cart.total() == 10.0

        def test_remove_item_from_cart(self):
            # ARRANGE
            cart = ShoppingCart()
            item = Item(id=1, name='Book', price=10.0)
            cart.add_item(item)

            # ACT
            cart.remove_item(item.id)

            # ASSERT
            assert len(cart.items) == 0
            assert cart.total() == 0.0
    ```

    ### Example 3: Java (JUnit)

    ```java
    import org.junit.jupiter.api.Test;
    import static org.junit.jupiter.api.Assertions.*;

    class ShoppingCartTest {
        @Test
        void testAddItemToCart() {
            // ARRANGE
            ShoppingCart cart = new ShoppingCart();
            Item item = new Item(1, "Book", 10.0);

            // ACT
            cart.addItem(item);

            // ASSERT
            assertEquals(1, cart.getItems().size());
            assertEquals(item, cart.getItems().get(0));
            assertEquals(10.0, cart.getTotal(), 0.01);
        }

        @Test
        void testApplyDiscount() {
            // ARRANGE
            ShoppingCart cart = new ShoppingCart();
            cart.addItem(new Item(1, "Book", 100.0));

            // ACT
            cart.applyDiscount(0.10); // 10% discount

            // ASSERT
            assertEquals(90.0, cart.getTotal(), 0.01);
        }
    }
    ```

    ## Mocking and Stubbing

    **Isolate units by replacing dependencies with test doubles**

    ### What are Test Doubles?

    - **Stub**: Returns predefined data
    - **Mock**: Verifies interactions were called
    - **Fake**: Working implementation (simpler)
    - **Spy**: Records calls for verification

    ### Example 1: Mocking in Jest

    ```javascript
    // user-service.js
    class UserService {
      constructor(database) {
        this.database = database;
      }

      async getUser(id) {
        return await this.database.query('SELECT * FROM users WHERE id = ?', id);
      }

      async createUser(userData) {
        const existingUser = await this.database.query(
          'SELECT * FROM users WHERE email = ?',
          userData.email
        );

        if (existingUser) {
          throw new Error('User already exists');
        }

        return await this.database.insert('users', userData);
      }
    }

    // user-service.test.js
    describe('UserService', () => {
      test('getUser returns user from database', async () => {
        // ARRANGE: Mock database
        const mockDatabase = {
          query: jest.fn().mockResolvedValue({ id: 1, name: 'Alice' })
        };
        const userService = new UserService(mockDatabase);

        // ACT
        const user = await userService.getUser(1);

        // ASSERT
        expect(mockDatabase.query).toHaveBeenCalledWith(
          'SELECT * FROM users WHERE id = ?',
          1
        );
        expect(user).toEqual({ id: 1, name: 'Alice' });
      });

      test('createUser throws error if user exists', async () => {
        // ARRANGE
        const mockDatabase = {
          query: jest.fn().mockResolvedValue({ id: 1, email: 'alice@test.com' }),
          insert: jest.fn()
        };
        const userService = new UserService(mockDatabase);

        // ACT & ASSERT
        await expect(
          userService.createUser({ email: 'alice@test.com', name: 'Alice' })
        ).rejects.toThrow('User already exists');

        expect(mockDatabase.insert).not.toHaveBeenCalled();
      });
    });
    ```

    ### Example 2: Mocking in Python (unittest.mock)

    ```python
    from unittest.mock import Mock, patch
    import pytest
    from user_service import UserService

    class TestUserService:
        def test_get_user_returns_user_from_database(self):
            # ARRANGE: Mock database
            mock_db = Mock()
            mock_db.query.return_value = {'id': 1, 'name': 'Alice'}
            user_service = UserService(mock_db)

            # ACT
            user = user_service.get_user(1)

            # ASSERT
            mock_db.query.assert_called_once_with(
                'SELECT * FROM users WHERE id = ?', 1
            )
            assert user == {'id': 1, 'name': 'Alice'}

        @patch('user_service.send_email')
        def test_create_user_sends_welcome_email(self, mock_send_email):
            # ARRANGE
            mock_db = Mock()
            mock_db.query.return_value = None  # No existing user
            mock_db.insert.return_value = {'id': 1, 'email': 'alice@test.com'}
            user_service = UserService(mock_db)

            # ACT
            user_service.create_user({'email': 'alice@test.com', 'name': 'Alice'})

            # ASSERT
            mock_send_email.assert_called_once_with(
                to='alice@test.com',
                subject='Welcome!',
                body='Welcome to our service'
            )
    ```

    ### Example 3: Mocking HTTP Requests

    ```javascript
    // weather-service.js
    const axios = require('axios');

    class WeatherService {
      async getTemperature(city) {
        const response = await axios.get(
          `https://api.weather.com/forecast?city=${city}`
        );
        return response.data.temperature;
      }
    }

    // weather-service.test.js
    jest.mock('axios');

    describe('WeatherService', () => {
      test('getTemperature returns temperature for city', async () => {
        // ARRANGE
        axios.get.mockResolvedValue({
          data: { temperature: 72, city: 'San Francisco' }
        });
        const weatherService = new WeatherService();

        // ACT
        const temp = await weatherService.getTemperature('San Francisco');

        // ASSERT
        expect(temp).toBe(72);
        expect(axios.get).toHaveBeenCalledWith(
          'https://api.weather.com/forecast?city=San Francisco'
        );
      });

      test('getTemperature handles API errors', async () => {
        // ARRANGE
        axios.get.mockRejectedValue(new Error('API Error'));
        const weatherService = new WeatherService();

        // ACT & ASSERT
        await expect(
          weatherService.getTemperature('InvalidCity')
        ).rejects.toThrow('API Error');
      });
    });
    ```

    ### Example 4: Spy Pattern

    ```python
    # payment_processor.py
    class PaymentProcessor:
        def __init__(self, payment_gateway):
            self.payment_gateway = payment_gateway
            self.logger = Logger()

        def process_payment(self, amount, card):
            self.logger.info(f'Processing payment: ${amount}')
            result = self.payment_gateway.charge(amount, card)

            if result.success:
                self.logger.info(f'Payment successful: {result.transaction_id}')
            else:
                self.logger.error(f'Payment failed: {result.error}')

            return result

    # test_payment_processor.py
    from unittest.mock import Mock, call
    import pytest

    def test_process_payment_logs_correctly():
        # ARRANGE
        mock_gateway = Mock()
        mock_gateway.charge.return_value = Mock(
            success=True,
            transaction_id='txn_123'
        )

        processor = PaymentProcessor(mock_gateway)
        processor.logger = Mock()  # Spy on logger

        # ACT
        processor.process_payment(100.0, {'number': '4111111111111111'})

        # ASSERT: Verify logger was called correctly
        assert processor.logger.info.call_count == 2
        processor.logger.info.assert_has_calls([
            call('Processing payment: $100.0'),
            call('Payment successful: txn_123')
        ])
    ```

    ## When to Mock vs Use Real Dependencies

    ### Mock These:
    - External APIs (slow, costs money, rate limits)
    - Databases (in unit tests)
    - File system operations
    - Email services
    - Payment gateways
    - Time/dates (for deterministic tests)

    ```python
    # Mock time for deterministic tests
    from unittest.mock import patch
    from datetime import datetime

    def test_is_business_hours():
        # Test at 2 PM (business hours)
        with patch('datetime.datetime') as mock_datetime:
            mock_datetime.now.return_value = datetime(2024, 1, 1, 14, 0)
            assert is_business_hours() == True

        # Test at 8 PM (after hours)
        with patch('datetime.datetime') as mock_datetime:
            mock_datetime.now.return_value = datetime(2024, 1, 1, 20, 0)
            assert is_business_hours() == False
    ```

    ### Use Real Dependencies:
    - Pure functions (no side effects)
    - Simple utilities
    - Value objects
    - Your own domain logic

    ```javascript
    // Don't mock these - test directly
    class Money {
      constructor(amount, currency) {
        this.amount = amount;
        this.currency = currency;
      }

      add(other) {
        if (this.currency !== other.currency) {
          throw new Error('Currency mismatch');
        }
        return new Money(this.amount + other.amount, this.currency);
      }
    }

    // Test with real objects
    test('Money.add combines amounts', () => {
      const m1 = new Money(10, 'USD');
      const m2 = new Money(20, 'USD');

      const result = m1.add(m2);

      expect(result.amount).toBe(30);
      expect(result.currency).toBe('USD');
    });
    ```

    ## Test Naming Conventions

    ### Good Test Names

    ```javascript
    // Pattern: test_[method]_[scenario]_[expected_result]

    // ✅ Good
    test('add_validNumbers_returnsSum')
    test('createUser_duplicateEmail_throwsError')
    test('calculateDiscount_vipCustomer_applies20PercentDiscount')

    // ❌ Bad (too vague)
    test('test1')
    test('addTest')
    test('userCreation')
    ```

    ### Describe Blocks for Organization

    ```javascript
    describe('ShoppingCart', () => {
      describe('addItem', () => {
        test('adds item to empty cart', () => { /* ... */ });
        test('adds item to cart with existing items', () => { /* ... */ });
        test('throws error if item is null', () => { /* ... */ });
      });

      describe('removeItem', () => {
        test('removes item by id', () => { /* ... */ });
        test('throws error if item not found', () => { /* ... */ });
      });

      describe('total', () => {
        test('returns zero for empty cart', () => { /* ... */ });
        test('sums all item prices', () => { /* ... */ });
        test('applies discount if applicable', () => { /* ... */ });
      });
    });
    ```

    ## Best Practices

    1. **One assertion per test** (when possible)
    ```javascript
    // ✅ Good
    test('cart total is correct', () => {
      expect(cart.total()).toBe(100);
    });

    // ❌ Avoid (testing multiple things)
    test('cart works', () => {
      expect(cart.items).toHaveLength(2);
      expect(cart.total()).toBe(100);
      expect(cart.isEmpty()).toBe(false);
    });
    ```

    2. **Tests should be independent**
    ```javascript
    // ❌ Bad: Tests depend on execution order
    let cart;
    test('test 1', () => {
      cart = new ShoppingCart();
      cart.addItem(item);
    });
    test('test 2', () => {
      expect(cart.items).toHaveLength(1); // Depends on test 1!
    });

    // ✅ Good: Each test is independent
    test('test 1', () => {
      const cart = new ShoppingCart();
      cart.addItem(item);
      expect(cart.items).toHaveLength(1);
    });
    test('test 2', () => {
      const cart = new ShoppingCart();
      expect(cart.items).toHaveLength(0);
    });
    ```

    3. **Use test fixtures/setup**
    ```python
    import pytest

    @pytest.fixture
    def cart():
        """Reusable cart fixture"""
        return ShoppingCart()

    @pytest.fixture
    def cart_with_items():
        """Cart pre-populated with items"""
        cart = ShoppingCart()
        cart.add_item(Item(1, 'Book', 10.0))
        cart.add_item(Item(2, 'Pen', 5.0))
        return cart

    def test_empty_cart_total(cart):
        assert cart.total() == 0.0

    def test_cart_with_items_total(cart_with_items):
        assert cart_with_items.total() == 15.0
    ```

    **Next**: We'll explore integration testing and E2E testing in depth.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 12 microlessons for Testing Fundamentals"
