# AUTO-GENERATED from clean_code_refactoring_course.rb
puts "Creating Microlessons for Clean Code Principles..."

module_var = CourseModule.find_by(slug: 'clean-code-principles')

# === MICROLESSON 1: Comments: When and How ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Comments: When and How',
  content: <<~MARKDOWN,
# Comments: When and How 🚀

# Comments: When and How

    "Don't comment bad code—rewrite it." — Brian W. Kernighan & P. J. Plaugher

    ## The Proper Use of Comments

    **The best comment is the one you found a way not to write.**

    Comments are, at best, a necessary evil. Every comment represents a failure to express yourself in code.

    ### Why Comments Are Often Bad

    1. **They lie** - Code changes, comments often don't
    2. **They're maintained** - Extra work that's often neglected
    3. **They clutter** - Make code harder to read
    4. **They mislead** - Outdated comments are worse than no comments

    ## Good Comments

    ### 1. Legal Comments
    ```python
    # Copyright (C) 2024 Company Name
    # Licensed under the Apache License, Version 2.0
    ```

    ### 2. Informative Comments
    ```python
    # Returns an instance of the Responder being tested
    def responder_instance():
        return Responder()

    # format matched: kk:mm:ss EEE, MMM dd, yyyy
    pattern = r'\\d{2}:\\d{2}:\\d{2} \\w{3}, \\w{3} \\d{2}, \\d{4}'
    ```

    **Better:** Use function names instead:
    ```python
    def responder_being_tested():
        return Responder()

    TIMESTAMP_FORMAT_PATTERN = r'\\d{2}:\\d{2}:\\d{2} \\w{3}, \\w{3} \\d{2}, \\d{4}'
    ```

    ### 3. Explanation of Intent
    ```python
    def compare_to(other):
        if self < other:
            return -1
        elif self > other:
            return 1
        else:
            # We want to force objects of this type to the bottom of the list
            return 0
    ```

    ### 4. Clarification
    ```python
    assertTrue(a.compareTo(a) == 0)    # a == a
    assertTrue(a.compareTo(b) != 0)    # a != b
    assertTrue(ab.compareTo(ab) == 0)  # ab == ab
    assertTrue(a.compareTo(b) == -1)   # a < b
    ```

    ### 5. Warning of Consequences
    ```python
    # Don't run unless you have 8+ hours to spare
    def test_with_really_big_file():
        write_lines_to_file(10000000)
        response = serve_file()
        # ...

    # SimpleDateFormat is not thread safe
    # so we need to create a new instance each time
    date_format = SimpleDateFormat("yyyy-MM-dd")
    ```

    ### 6. TODO Comments
    ```python
    # TODO: These are not needed
    # We expect this to go away when we do the checkout model
    def make_version():
        return None
    ```

    **Important:** Scan and eliminate TODOs regularly!

    ### 7. Amplification
    ```python
    # the trim is really important. It removes the starting spaces
    # that could cause the item to be recognized as another list
    list_item_content = match.group(3).strip()
    ```

    ### 8. Public API Documentation
    ```python
    def calculate_compound_interest(principal, rate, time):
        """
        Calculate compound interest.

        Args:
            principal (float): Initial amount
            rate (float): Interest rate (as decimal, e.g., 0.05 for 5%)
            time (int): Time period in years

        Returns:
            float: Final amount after compound interest

        Example:
            >>> calculate_compound_interest(1000, 0.05, 2)
            1102.50
        """
        return principal * (1 + rate) ** time
    ```

    ## Bad Comments

    ### 1. Mumbling
    ```python
    def load_properties():
        try:
            properties_path = "properties.xml"
            # Load properties here
            load(properties_path)
        except Exception:
            # No properties files means all defaults are loaded
            pass
    ```

    **Problems:**
    - Who loads the defaults?
    - When are they loaded?
    - Were they already loaded before the exception?

    ### 2. Redundant Comments
    ```python
    # Utility method that returns when this.closed is true.
    # Throws an exception if the timeout is reached.
    def wait_for_close(timeout_millis):
        if not self.closed:
            wait(timeout_millis)
            if not self.closed:
                raise Exception("MockResponseSender could not be closed")
    ```

    The comment provides no more information than the code itself!

    ### 3. Misleading Comments
    ```python
    # Returns days between two dates (inclusive)
    def days_between(start, end):
        # Actually doesn't include the end date!
        return (end - start).days
    ```

    ### 4. Mandated Comments
    ```python
    # ❌ Don't do this for every function
    def __init__(self, name):
        """
        Constructor for Employee.

        Args:
            name: The name
        """
        self.name = name
    ```

    ### 5. Journal Comments
    ```python
    # Changes (from 11-Oct-2001)
    # ---------------------------
    # 11-Oct-2001 : Re-organized the class (DG);
    # 05-Nov-2001 : Added getDescription() method (DG);
    # 25-Jun-2002 : Removed unnecessary import (DG);
    ```

    **Use version control instead!**

    ### 6. Noise Comments
    ```python
    # Default constructor
    def __init__(self):
        pass

    # Returns the day
    def get_day(self):
        return self.day

    # Sets the day
    def set_day(self, day):
        self.day = day
    ```

    These add zero value!

    ### 7. Position Markers
    ```python
    # //////////////// Actions //////////////////
    def action1():
        pass

    def action2():
        pass
    ```

    Use sparingly, if at all.

    ### 8. Closing Brace Comments
    ```python
    def process_data():
        if condition:
            while True:
                try:
                    # lots of code
                except Exception:
                    pass
                # end try
            # end while
        # end if
    # end function
    ```

    **Solution:** Make functions shorter!

    ### 9. Commented-Out Code
    ```python
    # inputRecord = self.input_stream.read()
    response = Response()
    # response.set_status(200)
    response.set_body(formatter.format(body))
    # old_response = response
    ```

    **NEVER DO THIS!**
    - Others won't delete it (afraid it's important)
    - It piles up over time
    - Use version control to preserve history

    ### 10. HTML in Comments
    ```python
    """
    Load properties from a file.
    <p>
    This method reads a properties file and loads all
    key-value pairs into memory.
    <ul>
    <li>Supports .properties files</li>
    <li>Supports .xml files</li>
    </ul>
    </p>
    """
    ```

    HTML is unreadable in source code!

    ### 11. Too Much Information
    ```python
    # RFC 2045 - Multipurpose Internet Mail Extensions (MIME)
    # Part One: Format of Internet Message Bodies
    # Section 6.8. Base64 Content-Transfer-Encoding
    # The encoding process represents 24-bit groups of input bits
    # as output strings of 4 encoded characters. Proceeding from
    # left to right... (continues for 30 more lines)
    def encode_base64(data):
        pass
    ```

    Link to RFC instead!

    ## Comment Best Practices

    ### When to Comment

    **DO comment when:**
    - Explaining complex algorithms
    - Documenting public APIs
    - Warning about consequences
    - Legal requirements
    - TODO notes (temporarily)

    **DON'T comment when:**
    - Code is self-explanatory
    - You can use better names instead
    - Function/variable name would suffice
    - It restates what code does

    ### Before Writing a Comment

    Ask yourself:
    1. Can I express this in code instead?
    2. Can I use a better function/variable name?
    3. Can I extract a method with a descriptive name?
    4. Is this comment worth maintaining?

    ### Example: Comment to Code Transformation

    #### ❌ With Comments
    ```python
    def get_employees():
        # Check to see if the employee is eligible for full benefits
        if employee.flags & HOURLY_FLAG and employee.age > 65:
            # Complex logic here
            pass
    ```

    #### ✅ Without Comments
    ```python
    def get_employees():
        if is_eligible_for_full_benefits(employee):
            # Complex logic here
            pass

    def is_eligible_for_full_benefits(employee):
        return employee.flags & HOURLY_FLAG and employee.age > 65
    ```

    ## Documentation vs Comments

    ### Documentation (Good)
    - Public API reference
    - Architecture decisions
    - Setup instructions
    - Usage examples
    - Design patterns used

    ### Comments in Code (Use Sparingly)
    - Why, not what
    - Non-obvious consequences
    - Temporary notes (TODO)

    ## Key Takeaways

    1. **Comments are a failure** - Represent inability to express in code
    2. **Code changes, comments rot** - Outdated comments mislead
    3. **Explain yourself in code** - Better names > comments
    4. **Good comments are rare** - Legal, warning, TODO, public API docs
    5. **Bad comments are common** - Mumbling, noise, redundant, misleading
    6. **Delete commented-out code** - Version control preserves history
    7. **Before commenting, try:**
       - Better names
       - Extract method
       - Simplify code
    8. **Document the "why", not the "what"**

    Remember: **The best comment is a well-named function or variable!**
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: The Art of Meaningful Naming ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'The Art of Meaningful Naming',
  content: <<~MARKDOWN,
# The Art of Meaningful Naming 🚀

# The Art of Meaningful Naming

    Naming is one of the most important and difficult tasks in programming. Good names make code self-documenting and easy to understand.

    ## Use Intention-Revealing Names

    ### ❌ Bad Examples
    ```python
    d = 10  # elapsed time in days
    list1 = []
    def getThem():
        result = []
        for x in list1:
            if x[0] == 4:
                result.append(x)
        return result
    ```

    ### ✅ Good Examples
    ```python
    elapsed_time_in_days = 10
    game_board = []

    def get_flagged_cells():
        flagged_cells = []
        for cell in game_board:
            if cell[STATUS_INDEX] == FLAGGED:
                flagged_cells.append(cell)
        return flagged_cells
    ```

    ## Avoid Disinformation

    ### ❌ Don't Use Reserved Words
    ```python
    hp_unix = []  # Not actually HP Unix
    accounts_list = {}  # It's a dict, not a list!
    ```

    ### ✅ Be Accurate
    ```python
    unix_servers = []
    accounts_map = {}
    account_group = {}
    ```

    ## Make Meaningful Distinctions

    ### ❌ Number Series Naming
    ```javascript
    function copyChars(a1, a2) {
        for (let i = 0; i < a1.length; i++) {
            a2[i] = a1[i];
        }
    }
    ```

    ### ✅ Meaningful Names
    ```javascript
    function copyChars(source, destination) {
        for (let i = 0; i < source.length; i++) {
            destination[i] = source[i];
        }
    }
    ```

    ### ❌ Noise Words
    ```java
    class Product {}
    class ProductInfo {}  // What's the difference?
    class ProductData {}  // Still unclear!

    String nameString;  // Redundant - name is obviously a string
    ```

    ## Use Pronounceable Names

    ### ❌ Unpronounceable
    ```python
    genymdhms = datetime.now()  # "gen why em dee aitch em ess"?
    modymdhms = datetime.now()
    ```

    ### ✅ Pronounceable
    ```python
    generation_timestamp = datetime.now()
    modification_timestamp = datetime.now()
    ```

    ## Use Searchable Names

    ### ❌ Magic Numbers and Single Letters
    ```python
    for i in range(34):  # What is 34?
        s += (t[i] * 4) / 5
    ```

    ### ✅ Named Constants
    ```python
    WORK_DAYS_PER_WEEK = 5
    HOURS_PER_DAY = 8
    NUMBER_OF_TASKS = 34

    for task_index in range(NUMBER_OF_TASKS):
        real_days_per_task = (task_estimate[task_index] * HOURS_PER_DAY) / WORK_DAYS_PER_WEEK
        sum_of_tasks += real_days_per_task
    ```

    ## Class Names

    ### Guidelines
    - Should be **nouns or noun phrases**
    - Use PascalCase
    - Avoid generic words like Manager, Processor, Data, Info

    ### ✅ Good Class Names
    ```python
    class Customer:
        pass

    class WikiPage:
        pass

    class Account:
        pass

    class AddressParser:
        pass
    ```

    ### ❌ Poor Class Names
    ```python
    class Manager:  # Too generic
        pass

    class Data:  # Meaningless
        pass

    class Info:  # Vague
        pass
    ```

    ## Method Names

    ### Guidelines
    - Should be **verbs or verb phrases**
    - Use camelCase (Java, JS) or snake_case (Python, Ruby)
    - Accessors: get prefix
    - Mutators: set prefix
    - Predicates: is, has, can prefix

    ### ✅ Good Method Names
    ```python
    def save_customer():
        pass

    def delete_page():
        pass

    def is_valid():
        pass

    def has_permission():
        pass

    def can_edit():
        pass
    ```

    ## Pick One Word per Concept

    ### ❌ Inconsistent Vocabulary
    ```python
    fetch_data()
    retrieve_users()
    get_products()
    obtain_orders()  # Which one should I use?
    ```

    ### ✅ Consistent Vocabulary
    ```python
    get_data()
    get_users()
    get_products()
    get_orders()  # Clear pattern!
    ```

    ## Use Domain Names

    ### Problem Domain Terms
    ```python
    class AccountVisitor:  # Visitor pattern
        pass

    class JobQueue:  # Queue data structure
        pass
    ```

    ### Solution Domain Terms
    ```python
    class CustomerFactory:  # Factory pattern
        pass

    class OrderBuilder:  # Builder pattern
        pass
    ```

    ## Context Matters

    ### ❌ Context-less Variables
    ```python
    first_name = "John"
    last_name = "Doe"
    street = "123 Main St"
    city = "Springfield"
    state = "IL"
    ```

    ### ✅ Variables with Context
    ```python
    class Address:
        def __init__(self):
            self.street = "123 Main St"
            self.city = "Springfield"
            self.state = "IL"

    # Or with prefixes
    address_street = "123 Main St"
    address_city = "Springfield"
    address_state = "IL"
    ```

    ## Naming Convention Summary

    | Type | Convention | Example |
    |------|-----------|---------|
    | Class | PascalCase (noun) | `CustomerAccount` |
    | Method | camelCase/snake_case (verb) | `calculateTotal()` / `calculate_total()` |
    | Variable | camelCase/snake_case | `userName` / `user_name` |
    | Constant | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
    | Private | _prefix | `_internal_value` |
    | Boolean | is/has/can prefix | `isValid`, `hasPermission` |

    ## Anti-Patterns to Avoid

    ### Hungarian Notation
    ```cpp
    // ❌ Old style - type in name
    String sName;
    int iCount;
    bool bIsValid;

    // ✅ Modern - let type system handle it
    String name;
    int count;
    bool isValid;
    ```

    ### Member Prefixes
    ```java
    // ❌ Unnecessary prefix
    class Customer {
        private String m_name;
        private int m_age;
    }

    // ✅ Clean
    class Customer {
        private String name;
        private int age;
    }
    ```

    ## The Ultimate Naming Rule

    **If you need a comment to explain a name, the name is wrong.**

    ```python
    # ❌ Needs comment
    d = 5  # delay in milliseconds

    # ✅ Self-explanatory
    delay_in_milliseconds = 5
    ```

    ## Key Takeaways

    1. **Names should reveal intent** - No comments needed
    2. **Be consistent** - One word per concept
    3. **Be specific** - Avoid generic terms
    4. **Use domain language** - Speak the user's language
    5. **Refactor names** - Don't be afraid to rename
    6. **Length correlates with scope** - Longer scope = longer name
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Writing Clean Functions ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Writing Clean Functions',
  content: <<~MARKDOWN,
# Writing Clean Functions 🚀

# Writing Clean Functions

    Functions are the first line of organization in any program. This chapter teaches how to write functions that are easy to understand and maintain.

    ## The First Rule: Small!

    ### Functions Should Be Small
    **How small?** Typically 5-15 lines, rarely more than 20.

    ### ❌ Too Large
    ```python
    def process_order(order):
        # Validate order (20 lines)
        if not order:
            raise ValueError("Order cannot be null")
        if not order.items:
            raise ValueError("Order must have items")
        # ... more validation

        # Calculate totals (30 lines)
        subtotal = 0
        for item in order.items:
            subtotal += item.price * item.quantity
        # ... tax calculation
        # ... shipping calculation

        # Process payment (40 lines)
        payment_gateway = PaymentGateway()
        # ... payment logic

        # Send confirmation (25 lines)
        # ... email logic

        return order  # 115 lines total!
    ```

    ### ✅ Small and Focused
    ```python
    def process_order(order):
        validate_order(order)
        total = calculate_order_total(order)
        process_payment(order, total)
        send_confirmation_email(order)
        return order  # 5 lines total!

    def validate_order(order):
        if not order:
            raise ValueError("Order cannot be null")
        if not order.items:
            raise ValueError("Order must have items")

    def calculate_order_total(order):
        subtotal = calculate_subtotal(order.items)
        tax = calculate_tax(subtotal)
        shipping = calculate_shipping(order)
        return subtotal + tax + shipping
    ```

    ## Do One Thing

    **Functions should do one thing. They should do it well. They should do it only.**

    ### How to Know if a Function Does One Thing?

    **Test:** Can you extract another function from it with a name that isn't a restatement of its implementation?

    ### ❌ Does Multiple Things
    ```python
    def save_and_email_customer(customer):
        # Saves to database
        db.save(customer)

        # Sends email
        email = f"Welcome {customer.name}!"
        send_email(customer.email, email)

        # Logs activity
        logger.info(f"Customer {customer.id} saved and emailed")
    ```

    ### ✅ Does One Thing
    ```python
    def save_customer(customer):
        db.save(customer)

    def send_welcome_email(customer):
        email = f"Welcome {customer.name}!"
        send_email(customer.email, email)

    def log_customer_activity(customer, action):
        logger.info(f"Customer {customer.id} {action}")

    # Usage
    save_customer(customer)
    send_welcome_email(customer)
    log_customer_activity(customer, "registered")
    ```

    ## One Level of Abstraction

    **Keep all statements in a function at the same level of abstraction.**

    ### ❌ Mixed Levels of Abstraction
    ```python
    def render_page(page_data):
        # High level
        html = "<html>"

        # Medium level
        html += render_header(page_data.header)

        # Low level - string manipulation
        html += "<body>"
        html += "<div class='content'>"

        # High level again
        html += render_content(page_data.content)

        # Low level
        html += "</div></body></html>"

        return html
    ```

    ### ✅ Consistent Abstraction Level
    ```python
    def render_page(page_data):
        return build_html(
            render_header(page_data.header),
            render_body(page_data.content),
            render_footer(page_data.footer)
        )

    def render_body(content):
        return wrap_in_div(render_content(content), class_name='content')

    def wrap_in_div(content, class_name):
        return f"<div class='{class_name}'>{content}</div>"
    ```

    ## Function Arguments

    ### Ideal Number of Arguments

    | Arguments | Rating | Notes |
    |-----------|--------|-------|
    | 0 (niladic) | ⭐⭐⭐⭐⭐ | Perfect |
    | 1 (monadic) | ⭐⭐⭐⭐ | Good |
    | 2 (dyadic) | ⭐⭐⭐ | OK |
    | 3 (triadic) | ⭐⭐ | Questionable |
    | 4+ (polyadic) | ⭐ | Avoid |

    ### ❌ Too Many Arguments
    ```python
    def create_user(name, email, password, age, address, phone, country, timezone, preferences):
        # Hard to remember order
        # Hard to test all combinations
        pass

    # Confusing call site
    create_user("John", "john@example.com", "pass123", 30, "123 Main St", "555-1234", "USA", "PST", {})
    ```

    ### ✅ Use Objects for Multiple Arguments
    ```python
    class UserData:
        def __init__(self, name, email, password):
            self.name = name
            self.email = email
            self.password = password
            self.age = None
            self.address = None
            self.preferences = {}

    def create_user(user_data):
        # Clear and extensible
        pass

    # Clear call site
    user_data = UserData("John", "john@example.com", "pass123")
    user_data.age = 30
    create_user(user_data)
    ```

    ## Flag Arguments

    **Flag arguments are ugly. Passing a boolean into a function is a terrible practice.**

    ### ❌ Flag Argument
    ```python
    def render(is_test):
        if is_test:
            render_for_test()
        else:
            render_for_production()
    ```

    ### ✅ Split Into Two Functions
    ```python
    def render_for_test():
        # Test rendering logic
        pass

    def render_for_production():
        # Production rendering logic
        pass
    ```

    ## Avoid Side Effects

    **A function promises to do one thing, but it also does other hidden things.**

    ### ❌ Hidden Side Effect
    ```python
    def check_password(username, password):
        user = User.find_by_username(username)
        if user.password == password:
            Session.initialize()  # Hidden side effect!
            return True
        return False
    ```

    ### ✅ Clear Intent
    ```python
    def check_password(username, password):
        user = User.find_by_username(username)
        return user.password == password

    def login(username, password):
        if check_password(username, password):
            Session.initialize()  # Clear and explicit
            return True
        return False
    ```

    ## Command Query Separation

    **Functions should either do something or answer something, but not both.**

    ### ❌ Mixed Command and Query
    ```python
    def set_and_check_attribute(attribute, value):
        if attribute_exists(attribute):
            set_attribute(attribute, value)
            return True
        return False

    # Confusing usage
    if set_and_check_attribute("username", "john"):
        # Does this mean it was set, or it already existed?
        pass
    ```

    ### ✅ Separate Command and Query
    ```python
    def set_attribute(attribute, value):
        # Command: changes state
        attributes[attribute] = value

    def attribute_exists(attribute):
        # Query: returns information
        return attribute in attributes

    # Clear usage
    if attribute_exists("username"):
        set_attribute("username", "john")
    ```

    ## Prefer Exceptions to Error Codes

    ### ❌ Error Codes
    ```python
    def delete_page(page):
        if delete_from_database(page) == E_OK:
            if delete_from_cache(page) == E_OK:
                logger.log("page deleted")
            else:
                logger.log("cache delete failed")
        else:
            logger.log("database delete failed")
    ```

    ### ✅ Exceptions
    ```python
    def delete_page(page):
        try:
            delete_page_and_dependencies(page)
        except Exception as e:
            logger.error(f"Failed to delete page: {e}")
            raise

    def delete_page_and_dependencies(page):
        delete_from_database(page)
        delete_from_cache(page)
        logger.info("Page deleted successfully")
    ```

    ## Don't Repeat Yourself (DRY)

    **Duplication is the root of all evil in software.**

    ### ❌ Duplication
    ```python
    def calculate_employee_pay(employee):
        regular_hours = employee.hours
        overtime = regular_hours > 40 ? regular_hours - 40 : 0
        regular_pay = employee.rate * min(regular_hours, 40)
        overtime_pay = overtime * employee.rate * 1.5
        return regular_pay + overtime_pay

    def calculate_contractor_pay(contractor):
        regular_hours = contractor.hours
        overtime = regular_hours > 40 ? regular_hours - 40 : 0
        regular_pay = contractor.rate * min(regular_hours, 40)
        overtime_pay = overtime * contractor.rate * 1.5
        return regular_pay + overtime_pay
    ```

    ### ✅ Extract Common Logic
    ```python
    def calculate_pay(worker):
        regular_hours = min(worker.hours, 40)
        overtime_hours = max(worker.hours - 40, 0)

        regular_pay = worker.rate * regular_hours
        overtime_pay = worker.rate * 1.5 * overtime_hours

        return regular_pay + overtime_pay
    ```

    ## Structured Programming

    **Every function should have:**
    - One entry point
    - One exit point (single return)
    - No breaks or continues (loops)
    - Never any goto statements

    ### Multiple Returns Can Be OK
    ```python
    # ✅ Early returns for guard clauses
    def get_user_discount(user):
        if not user:
            return 0

        if user.is_premium():
            return 0.2

        if user.order_count > 10:
            return 0.1

        return 0
    ```

    ## Function Organization Guidelines

    ### 1. Stepdown Rule
    Read code from top to bottom like a narrative:
    ```python
    def main_process():
        initialize()
        process_data()
        cleanup()

    def initialize():
        load_config()
        connect_database()

    def load_config():
        # Details...
        pass
    ```

    ### 2. Extract Till You Drop
    Keep extracting until you can't anymore:
    ```python
    # Level 0
    def process_payment():
        validate_payment()
        charge_customer()
        send_receipt()

    # Level 1
    def validate_payment():
        check_payment_method()
        verify_amount()
        validate_currency()

    # Level 2
    def check_payment_method():
        # Specific implementation
        pass
    ```

    ## Key Takeaways

    1. **Functions should be small** - 5-15 lines ideal
    2. **Do one thing** - Single Responsibility Principle
    3. **One level of abstraction** - Don't mix high and low level
    4. **Descriptive names** - Name reveals what function does
    5. **Few arguments** - 0-2 ideal, avoid flags
    6. **No side effects** - Do what you promise
    7. **Prefer exceptions** - To error codes
    8. **DRY** - Don't Repeat Yourself
    9. **Separate commands and queries** - Clear intent
    10. **Read like prose** - Top to bottom narrative
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 4: Comments: When and How ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Comments: When and How',
  content: <<~MARKDOWN,
# Comments: When and How 🚀

# Comments: When and How

    "Don't comment bad code—rewrite it." — Brian W. Kernighan & P. J. Plaugher

    ## The Proper Use of Comments

    **The best comment is the one you found a way not to write.**

    Comments are, at best, a necessary evil. Every comment represents a failure to express yourself in code.

    ### Why Comments Are Often Bad

    1. **They lie** - Code changes, comments often don't
    2. **They're maintained** - Extra work that's often neglected
    3. **They clutter** - Make code harder to read
    4. **They mislead** - Outdated comments are worse than no comments

    ## Good Comments

    ### 1. Legal Comments
    ```python
    # Copyright (C) 2024 Company Name
    # Licensed under the Apache License, Version 2.0
    ```

    ### 2. Informative Comments
    ```python
    # Returns an instance of the Responder being tested
    def responder_instance():
        return Responder()

    # format matched: kk:mm:ss EEE, MMM dd, yyyy
    pattern = r'\\d{2}:\\d{2}:\\d{2} \\w{3}, \\w{3} \\d{2}, \\d{4}'
    ```

    **Better:** Use function names instead:
    ```python
    def responder_being_tested():
        return Responder()

    TIMESTAMP_FORMAT_PATTERN = r'\\d{2}:\\d{2}:\\d{2} \\w{3}, \\w{3} \\d{2}, \\d{4}'
    ```

    ### 3. Explanation of Intent
    ```python
    def compare_to(other):
        if self < other:
            return -1
        elif self > other:
            return 1
        else:
            # We want to force objects of this type to the bottom of the list
            return 0
    ```

    ### 4. Clarification
    ```python
    assertTrue(a.compareTo(a) == 0)    # a == a
    assertTrue(a.compareTo(b) != 0)    # a != b
    assertTrue(ab.compareTo(ab) == 0)  # ab == ab
    assertTrue(a.compareTo(b) == -1)   # a < b
    ```

    ### 5. Warning of Consequences
    ```python
    # Don't run unless you have 8+ hours to spare
    def test_with_really_big_file():
        write_lines_to_file(10000000)
        response = serve_file()
        # ...

    # SimpleDateFormat is not thread safe
    # so we need to create a new instance each time
    date_format = SimpleDateFormat("yyyy-MM-dd")
    ```

    ### 6. TODO Comments
    ```python
    # TODO: These are not needed
    # We expect this to go away when we do the checkout model
    def make_version():
        return None
    ```

    **Important:** Scan and eliminate TODOs regularly!

    ### 7. Amplification
    ```python
    # the trim is really important. It removes the starting spaces
    # that could cause the item to be recognized as another list
    list_item_content = match.group(3).strip()
    ```

    ### 8. Public API Documentation
    ```python
    def calculate_compound_interest(principal, rate, time):
        """
        Calculate compound interest.

        Args:
            principal (float): Initial amount
            rate (float): Interest rate (as decimal, e.g., 0.05 for 5%)
            time (int): Time period in years

        Returns:
            float: Final amount after compound interest

        Example:
            >>> calculate_compound_interest(1000, 0.05, 2)
            1102.50
        """
        return principal * (1 + rate) ** time
    ```

    ## Bad Comments

    ### 1. Mumbling
    ```python
    def load_properties():
        try:
            properties_path = "properties.xml"
            # Load properties here
            load(properties_path)
        except Exception:
            # No properties files means all defaults are loaded
            pass
    ```

    **Problems:**
    - Who loads the defaults?
    - When are they loaded?
    - Were they already loaded before the exception?

    ### 2. Redundant Comments
    ```python
    # Utility method that returns when this.closed is true.
    # Throws an exception if the timeout is reached.
    def wait_for_close(timeout_millis):
        if not self.closed:
            wait(timeout_millis)
            if not self.closed:
                raise Exception("MockResponseSender could not be closed")
    ```

    The comment provides no more information than the code itself!

    ### 3. Misleading Comments
    ```python
    # Returns days between two dates (inclusive)
    def days_between(start, end):
        # Actually doesn't include the end date!
        return (end - start).days
    ```

    ### 4. Mandated Comments
    ```python
    # ❌ Don't do this for every function
    def __init__(self, name):
        """
        Constructor for Employee.

        Args:
            name: The name
        """
        self.name = name
    ```

    ### 5. Journal Comments
    ```python
    # Changes (from 11-Oct-2001)
    # ---------------------------
    # 11-Oct-2001 : Re-organized the class (DG);
    # 05-Nov-2001 : Added getDescription() method (DG);
    # 25-Jun-2002 : Removed unnecessary import (DG);
    ```

    **Use version control instead!**

    ### 6. Noise Comments
    ```python
    # Default constructor
    def __init__(self):
        pass

    # Returns the day
    def get_day(self):
        return self.day

    # Sets the day
    def set_day(self, day):
        self.day = day
    ```

    These add zero value!

    ### 7. Position Markers
    ```python
    # //////////////// Actions //////////////////
    def action1():
        pass

    def action2():
        pass
    ```

    Use sparingly, if at all.

    ### 8. Closing Brace Comments
    ```python
    def process_data():
        if condition:
            while True:
                try:
                    # lots of code
                except Exception:
                    pass
                # end try
            # end while
        # end if
    # end function
    ```

    **Solution:** Make functions shorter!

    ### 9. Commented-Out Code
    ```python
    # inputRecord = self.input_stream.read()
    response = Response()
    # response.set_status(200)
    response.set_body(formatter.format(body))
    # old_response = response
    ```

    **NEVER DO THIS!**
    - Others won't delete it (afraid it's important)
    - It piles up over time
    - Use version control to preserve history

    ### 10. HTML in Comments
    ```python
    """
    Load properties from a file.
    <p>
    This method reads a properties file and loads all
    key-value pairs into memory.
    <ul>
    <li>Supports .properties files</li>
    <li>Supports .xml files</li>
    </ul>
    </p>
    """
    ```

    HTML is unreadable in source code!

    ### 11. Too Much Information
    ```python
    # RFC 2045 - Multipurpose Internet Mail Extensions (MIME)
    # Part One: Format of Internet Message Bodies
    # Section 6.8. Base64 Content-Transfer-Encoding
    # The encoding process represents 24-bit groups of input bits
    # as output strings of 4 encoded characters. Proceeding from
    # left to right... (continues for 30 more lines)
    def encode_base64(data):
        pass
    ```

    Link to RFC instead!

    ## Comment Best Practices

    ### When to Comment

    **DO comment when:**
    - Explaining complex algorithms
    - Documenting public APIs
    - Warning about consequences
    - Legal requirements
    - TODO notes (temporarily)

    **DON'T comment when:**
    - Code is self-explanatory
    - You can use better names instead
    - Function/variable name would suffice
    - It restates what code does

    ### Before Writing a Comment

    Ask yourself:
    1. Can I express this in code instead?
    2. Can I use a better function/variable name?
    3. Can I extract a method with a descriptive name?
    4. Is this comment worth maintaining?

    ### Example: Comment to Code Transformation

    #### ❌ With Comments
    ```python
    def get_employees():
        # Check to see if the employee is eligible for full benefits
        if employee.flags & HOURLY_FLAG and employee.age > 65:
            # Complex logic here
            pass
    ```

    #### ✅ Without Comments
    ```python
    def get_employees():
        if is_eligible_for_full_benefits(employee):
            # Complex logic here
            pass

    def is_eligible_for_full_benefits(employee):
        return employee.flags & HOURLY_FLAG and employee.age > 65
    ```

    ## Documentation vs Comments

    ### Documentation (Good)
    - Public API reference
    - Architecture decisions
    - Setup instructions
    - Usage examples
    - Design patterns used

    ### Comments in Code (Use Sparingly)
    - Why, not what
    - Non-obvious consequences
    - Temporary notes (TODO)

    ## Key Takeaways

    1. **Comments are a failure** - Represent inability to express in code
    2. **Code changes, comments rot** - Outdated comments mislead
    3. **Explain yourself in code** - Better names > comments
    4. **Good comments are rare** - Legal, warning, TODO, public API docs
    5. **Bad comments are common** - Mumbling, noise, redundant, misleading
    6. **Delete commented-out code** - Version control preserves history
    7. **Before commenting, try:**
       - Better names
       - Extract method
       - Simplify code
    8. **Document the "why", not the "what"**

    Remember: **The best comment is a well-named function or variable!**
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 5: What is Clean Code? ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is Clean Code?',
  content: <<~MARKDOWN,
# What is Clean Code? 🚀

# What is Clean Code?

    Clean code is code that is easy to understand, easy to change, and easy to maintain. As Robert C. Martin (Uncle Bob) famously said: "Clean code is code that has been taken care of."

    ## Why Clean Code Matters

    ### Technical Debt
    - Poor code quality accumulates as technical debt
    - Costs increase exponentially over time
    - Slows down feature development
    - Increases bug introduction rate

    ### The Boy Scout Rule
    **"Leave the code cleaner than you found it."**

    Small improvements compound over time:
    - Rename one variable
    - Break up one large function
    - Remove one piece of duplication

    ## Characteristics of Clean Code

    ### 1. Readable
    - Code is read 10x more than it's written
    - Should read like well-written prose
    - Express intent clearly
    - Minimize cognitive load

    ### 2. Simple
    - Does one thing well
    - No unnecessary complexity
    - KISS: Keep It Simple, Stupid
    - YAGNI: You Aren't Gonna Need It

    ### 3. Tested
    - Has comprehensive test coverage
    - Tests serve as documentation
    - Tests enable refactoring

    ### 4. Expressive
    - Self-documenting
    - Names reveal intent
    - Minimal comments needed
    - Code explains "what" and "why"

    ## Cost of Bad Code

    ### Productivity Loss
    ```
    Time →
    ↑
    |     Initial
    | ✓   velocity
    | ✓✓
    | ✓✓✓           Production reality
    | ✓✓✓✓          with bad code
    | ✓✓✓✓✓      ↙
    | ✓✓✓✓✓✓  ↙
    | ✓✓✓✓✓✓↙
    |_____________→ Features
    ```

    ### The Grand Redesign Trap
    - Teams demand rewrite
    - New team starts from scratch
    - Takes years to reach feature parity
    - Meanwhile, original system evolves
    - Cycle repeats

    ## Clean Code Principles

    ### 1. Meaningful Names
    - Reveal intention
    - Avoid disinformation
    - Make meaningful distinctions
    - Use pronounceable names
    - Use searchable names

    ### 2. Functions
    - Small (< 20 lines ideal)
    - Do one thing
    - One level of abstraction
    - Few arguments (0-2 ideal)
    - No side effects

    ### 3. Comments
    - Code should be self-explanatory
    - Good code > comments
    - Explain "why", not "what"
    - Update or delete stale comments

    ### 4. Formatting
    - Consistent style
    - Vertical openness
    - Horizontal density
    - Team agreement

    ## The Total Cost of Owning a Mess

    Studies show:
    - 80% of software cost is maintenance
    - Original authors maintain < 20% of code
    - Comprehension is the biggest challenge
    - Clean code reduces onboarding time by 50%

    ## Key Takeaways

    1. **Quality is not negotiable** - It's not a luxury, it's essential
    2. **Start clean** - Easier than cleaning up later
    3. **Continuous improvement** - Small daily improvements compound
    4. **Team effort** - Code reviews and pair programming help
    5. **Professional responsibility** - Part of being a software craftsperson
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 6: The Art of Meaningful Naming ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'The Art of Meaningful Naming',
  content: <<~MARKDOWN,
# The Art of Meaningful Naming 🚀

# The Art of Meaningful Naming

    Naming is one of the most important and difficult tasks in programming. Good names make code self-documenting and easy to understand.

    ## Use Intention-Revealing Names

    ### ❌ Bad Examples
    ```python
    d = 10  # elapsed time in days
    list1 = []
    def getThem():
        result = []
        for x in list1:
            if x[0] == 4:
                result.append(x)
        return result
    ```

    ### ✅ Good Examples
    ```python
    elapsed_time_in_days = 10
    game_board = []

    def get_flagged_cells():
        flagged_cells = []
        for cell in game_board:
            if cell[STATUS_INDEX] == FLAGGED:
                flagged_cells.append(cell)
        return flagged_cells
    ```

    ## Avoid Disinformation

    ### ❌ Don't Use Reserved Words
    ```python
    hp_unix = []  # Not actually HP Unix
    accounts_list = {}  # It's a dict, not a list!
    ```

    ### ✅ Be Accurate
    ```python
    unix_servers = []
    accounts_map = {}
    account_group = {}
    ```

    ## Make Meaningful Distinctions

    ### ❌ Number Series Naming
    ```javascript
    function copyChars(a1, a2) {
        for (let i = 0; i < a1.length; i++) {
            a2[i] = a1[i];
        }
    }
    ```

    ### ✅ Meaningful Names
    ```javascript
    function copyChars(source, destination) {
        for (let i = 0; i < source.length; i++) {
            destination[i] = source[i];
        }
    }
    ```

    ### ❌ Noise Words
    ```java
    class Product {}
    class ProductInfo {}  // What's the difference?
    class ProductData {}  // Still unclear!

    String nameString;  // Redundant - name is obviously a string
    ```

    ## Use Pronounceable Names

    ### ❌ Unpronounceable
    ```python
    genymdhms = datetime.now()  # "gen why em dee aitch em ess"?
    modymdhms = datetime.now()
    ```

    ### ✅ Pronounceable
    ```python
    generation_timestamp = datetime.now()
    modification_timestamp = datetime.now()
    ```

    ## Use Searchable Names

    ### ❌ Magic Numbers and Single Letters
    ```python
    for i in range(34):  # What is 34?
        s += (t[i] * 4) / 5
    ```

    ### ✅ Named Constants
    ```python
    WORK_DAYS_PER_WEEK = 5
    HOURS_PER_DAY = 8
    NUMBER_OF_TASKS = 34

    for task_index in range(NUMBER_OF_TASKS):
        real_days_per_task = (task_estimate[task_index] * HOURS_PER_DAY) / WORK_DAYS_PER_WEEK
        sum_of_tasks += real_days_per_task
    ```

    ## Class Names

    ### Guidelines
    - Should be **nouns or noun phrases**
    - Use PascalCase
    - Avoid generic words like Manager, Processor, Data, Info

    ### ✅ Good Class Names
    ```python
    class Customer:
        pass

    class WikiPage:
        pass

    class Account:
        pass

    class AddressParser:
        pass
    ```

    ### ❌ Poor Class Names
    ```python
    class Manager:  # Too generic
        pass

    class Data:  # Meaningless
        pass

    class Info:  # Vague
        pass
    ```

    ## Method Names

    ### Guidelines
    - Should be **verbs or verb phrases**
    - Use camelCase (Java, JS) or snake_case (Python, Ruby)
    - Accessors: get prefix
    - Mutators: set prefix
    - Predicates: is, has, can prefix

    ### ✅ Good Method Names
    ```python
    def save_customer():
        pass

    def delete_page():
        pass

    def is_valid():
        pass

    def has_permission():
        pass

    def can_edit():
        pass
    ```

    ## Pick One Word per Concept

    ### ❌ Inconsistent Vocabulary
    ```python
    fetch_data()
    retrieve_users()
    get_products()
    obtain_orders()  # Which one should I use?
    ```

    ### ✅ Consistent Vocabulary
    ```python
    get_data()
    get_users()
    get_products()
    get_orders()  # Clear pattern!
    ```

    ## Use Domain Names

    ### Problem Domain Terms
    ```python
    class AccountVisitor:  # Visitor pattern
        pass

    class JobQueue:  # Queue data structure
        pass
    ```

    ### Solution Domain Terms
    ```python
    class CustomerFactory:  # Factory pattern
        pass

    class OrderBuilder:  # Builder pattern
        pass
    ```

    ## Context Matters

    ### ❌ Context-less Variables
    ```python
    first_name = "John"
    last_name = "Doe"
    street = "123 Main St"
    city = "Springfield"
    state = "IL"
    ```

    ### ✅ Variables with Context
    ```python
    class Address:
        def __init__(self):
            self.street = "123 Main St"
            self.city = "Springfield"
            self.state = "IL"

    # Or with prefixes
    address_street = "123 Main St"
    address_city = "Springfield"
    address_state = "IL"
    ```

    ## Naming Convention Summary

    | Type | Convention | Example |
    |------|-----------|---------|
    | Class | PascalCase (noun) | `CustomerAccount` |
    | Method | camelCase/snake_case (verb) | `calculateTotal()` / `calculate_total()` |
    | Variable | camelCase/snake_case | `userName` / `user_name` |
    | Constant | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
    | Private | _prefix | `_internal_value` |
    | Boolean | is/has/can prefix | `isValid`, `hasPermission` |

    ## Anti-Patterns to Avoid

    ### Hungarian Notation
    ```cpp
    // ❌ Old style - type in name
    String sName;
    int iCount;
    bool bIsValid;

    // ✅ Modern - let type system handle it
    String name;
    int count;
    bool isValid;
    ```

    ### Member Prefixes
    ```java
    // ❌ Unnecessary prefix
    class Customer {
        private String m_name;
        private int m_age;
    }

    // ✅ Clean
    class Customer {
        private String name;
        private int age;
    }
    ```

    ## The Ultimate Naming Rule

    **If you need a comment to explain a name, the name is wrong.**

    ```python
    # ❌ Needs comment
    d = 5  # delay in milliseconds

    # ✅ Self-explanatory
    delay_in_milliseconds = 5
    ```

    ## Key Takeaways

    1. **Names should reveal intent** - No comments needed
    2. **Be consistent** - One word per concept
    3. **Be specific** - Avoid generic terms
    4. **Use domain language** - Speak the user's language
    5. **Refactor names** - Don't be afraid to rename
    6. **Length correlates with scope** - Longer scope = longer name
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 7: Writing Clean Functions ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Writing Clean Functions',
  content: <<~MARKDOWN,
# Writing Clean Functions 🚀

# Writing Clean Functions

    Functions are the first line of organization in any program. This chapter teaches how to write functions that are easy to understand and maintain.

    ## The First Rule: Small!

    ### Functions Should Be Small
    **How small?** Typically 5-15 lines, rarely more than 20.

    ### ❌ Too Large
    ```python
    def process_order(order):
        # Validate order (20 lines)
        if not order:
            raise ValueError("Order cannot be null")
        if not order.items:
            raise ValueError("Order must have items")
        # ... more validation

        # Calculate totals (30 lines)
        subtotal = 0
        for item in order.items:
            subtotal += item.price * item.quantity
        # ... tax calculation
        # ... shipping calculation

        # Process payment (40 lines)
        payment_gateway = PaymentGateway()
        # ... payment logic

        # Send confirmation (25 lines)
        # ... email logic

        return order  # 115 lines total!
    ```

    ### ✅ Small and Focused
    ```python
    def process_order(order):
        validate_order(order)
        total = calculate_order_total(order)
        process_payment(order, total)
        send_confirmation_email(order)
        return order  # 5 lines total!

    def validate_order(order):
        if not order:
            raise ValueError("Order cannot be null")
        if not order.items:
            raise ValueError("Order must have items")

    def calculate_order_total(order):
        subtotal = calculate_subtotal(order.items)
        tax = calculate_tax(subtotal)
        shipping = calculate_shipping(order)
        return subtotal + tax + shipping
    ```

    ## Do One Thing

    **Functions should do one thing. They should do it well. They should do it only.**

    ### How to Know if a Function Does One Thing?

    **Test:** Can you extract another function from it with a name that isn't a restatement of its implementation?

    ### ❌ Does Multiple Things
    ```python
    def save_and_email_customer(customer):
        # Saves to database
        db.save(customer)

        # Sends email
        email = f"Welcome {customer.name}!"
        send_email(customer.email, email)

        # Logs activity
        logger.info(f"Customer {customer.id} saved and emailed")
    ```

    ### ✅ Does One Thing
    ```python
    def save_customer(customer):
        db.save(customer)

    def send_welcome_email(customer):
        email = f"Welcome {customer.name}!"
        send_email(customer.email, email)

    def log_customer_activity(customer, action):
        logger.info(f"Customer {customer.id} {action}")

    # Usage
    save_customer(customer)
    send_welcome_email(customer)
    log_customer_activity(customer, "registered")
    ```

    ## One Level of Abstraction

    **Keep all statements in a function at the same level of abstraction.**

    ### ❌ Mixed Levels of Abstraction
    ```python
    def render_page(page_data):
        # High level
        html = "<html>"

        # Medium level
        html += render_header(page_data.header)

        # Low level - string manipulation
        html += "<body>"
        html += "<div class='content'>"

        # High level again
        html += render_content(page_data.content)

        # Low level
        html += "</div></body></html>"

        return html
    ```

    ### ✅ Consistent Abstraction Level
    ```python
    def render_page(page_data):
        return build_html(
            render_header(page_data.header),
            render_body(page_data.content),
            render_footer(page_data.footer)
        )

    def render_body(content):
        return wrap_in_div(render_content(content), class_name='content')

    def wrap_in_div(content, class_name):
        return f"<div class='{class_name}'>{content}</div>"
    ```

    ## Function Arguments

    ### Ideal Number of Arguments

    | Arguments | Rating | Notes |
    |-----------|--------|-------|
    | 0 (niladic) | ⭐⭐⭐⭐⭐ | Perfect |
    | 1 (monadic) | ⭐⭐⭐⭐ | Good |
    | 2 (dyadic) | ⭐⭐⭐ | OK |
    | 3 (triadic) | ⭐⭐ | Questionable |
    | 4+ (polyadic) | ⭐ | Avoid |

    ### ❌ Too Many Arguments
    ```python
    def create_user(name, email, password, age, address, phone, country, timezone, preferences):
        # Hard to remember order
        # Hard to test all combinations
        pass

    # Confusing call site
    create_user("John", "john@example.com", "pass123", 30, "123 Main St", "555-1234", "USA", "PST", {})
    ```

    ### ✅ Use Objects for Multiple Arguments
    ```python
    class UserData:
        def __init__(self, name, email, password):
            self.name = name
            self.email = email
            self.password = password
            self.age = None
            self.address = None
            self.preferences = {}

    def create_user(user_data):
        # Clear and extensible
        pass

    # Clear call site
    user_data = UserData("John", "john@example.com", "pass123")
    user_data.age = 30
    create_user(user_data)
    ```

    ## Flag Arguments

    **Flag arguments are ugly. Passing a boolean into a function is a terrible practice.**

    ### ❌ Flag Argument
    ```python
    def render(is_test):
        if is_test:
            render_for_test()
        else:
            render_for_production()
    ```

    ### ✅ Split Into Two Functions
    ```python
    def render_for_test():
        # Test rendering logic
        pass

    def render_for_production():
        # Production rendering logic
        pass
    ```

    ## Avoid Side Effects

    **A function promises to do one thing, but it also does other hidden things.**

    ### ❌ Hidden Side Effect
    ```python
    def check_password(username, password):
        user = User.find_by_username(username)
        if user.password == password:
            Session.initialize()  # Hidden side effect!
            return True
        return False
    ```

    ### ✅ Clear Intent
    ```python
    def check_password(username, password):
        user = User.find_by_username(username)
        return user.password == password

    def login(username, password):
        if check_password(username, password):
            Session.initialize()  # Clear and explicit
            return True
        return False
    ```

    ## Command Query Separation

    **Functions should either do something or answer something, but not both.**

    ### ❌ Mixed Command and Query
    ```python
    def set_and_check_attribute(attribute, value):
        if attribute_exists(attribute):
            set_attribute(attribute, value)
            return True
        return False

    # Confusing usage
    if set_and_check_attribute("username", "john"):
        # Does this mean it was set, or it already existed?
        pass
    ```

    ### ✅ Separate Command and Query
    ```python
    def set_attribute(attribute, value):
        # Command: changes state
        attributes[attribute] = value

    def attribute_exists(attribute):
        # Query: returns information
        return attribute in attributes

    # Clear usage
    if attribute_exists("username"):
        set_attribute("username", "john")
    ```

    ## Prefer Exceptions to Error Codes

    ### ❌ Error Codes
    ```python
    def delete_page(page):
        if delete_from_database(page) == E_OK:
            if delete_from_cache(page) == E_OK:
                logger.log("page deleted")
            else:
                logger.log("cache delete failed")
        else:
            logger.log("database delete failed")
    ```

    ### ✅ Exceptions
    ```python
    def delete_page(page):
        try:
            delete_page_and_dependencies(page)
        except Exception as e:
            logger.error(f"Failed to delete page: {e}")
            raise

    def delete_page_and_dependencies(page):
        delete_from_database(page)
        delete_from_cache(page)
        logger.info("Page deleted successfully")
    ```

    ## Don't Repeat Yourself (DRY)

    **Duplication is the root of all evil in software.**

    ### ❌ Duplication
    ```python
    def calculate_employee_pay(employee):
        regular_hours = employee.hours
        overtime = regular_hours > 40 ? regular_hours - 40 : 0
        regular_pay = employee.rate * min(regular_hours, 40)
        overtime_pay = overtime * employee.rate * 1.5
        return regular_pay + overtime_pay

    def calculate_contractor_pay(contractor):
        regular_hours = contractor.hours
        overtime = regular_hours > 40 ? regular_hours - 40 : 0
        regular_pay = contractor.rate * min(regular_hours, 40)
        overtime_pay = overtime * contractor.rate * 1.5
        return regular_pay + overtime_pay
    ```

    ### ✅ Extract Common Logic
    ```python
    def calculate_pay(worker):
        regular_hours = min(worker.hours, 40)
        overtime_hours = max(worker.hours - 40, 0)

        regular_pay = worker.rate * regular_hours
        overtime_pay = worker.rate * 1.5 * overtime_hours

        return regular_pay + overtime_pay
    ```

    ## Structured Programming

    **Every function should have:**
    - One entry point
    - One exit point (single return)
    - No breaks or continues (loops)
    - Never any goto statements

    ### Multiple Returns Can Be OK
    ```python
    # ✅ Early returns for guard clauses
    def get_user_discount(user):
        if not user:
            return 0

        if user.is_premium():
            return 0.2

        if user.order_count > 10:
            return 0.1

        return 0
    ```

    ## Function Organization Guidelines

    ### 1. Stepdown Rule
    Read code from top to bottom like a narrative:
    ```python
    def main_process():
        initialize()
        process_data()
        cleanup()

    def initialize():
        load_config()
        connect_database()

    def load_config():
        # Details...
        pass
    ```

    ### 2. Extract Till You Drop
    Keep extracting until you can't anymore:
    ```python
    # Level 0
    def process_payment():
        validate_payment()
        charge_customer()
        send_receipt()

    # Level 1
    def validate_payment():
        check_payment_method()
        verify_amount()
        validate_currency()

    # Level 2
    def check_payment_method():
        # Specific implementation
        pass
    ```

    ## Key Takeaways

    1. **Functions should be small** - 5-15 lines ideal
    2. **Do one thing** - Single Responsibility Principle
    3. **One level of abstraction** - Don't mix high and low level
    4. **Descriptive names** - Name reveals what function does
    5. **Few arguments** - 0-2 ideal, avoid flags
    6. **No side effects** - Do what you promise
    7. **Prefer exceptions** - To error codes
    8. **DRY** - Don't Repeat Yourself
    9. **Separate commands and queries** - Clear intent
    10. **Read like prose** - Top to bottom narrative
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: What is Clean Code? ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'What is Clean Code?',
  content: <<~MARKDOWN,
# What is Clean Code? 🚀

# What is Clean Code?

    Clean code is code that is easy to understand, easy to change, and easy to maintain. As Robert C. Martin (Uncle Bob) famously said: "Clean code is code that has been taken care of."

    ## Why Clean Code Matters

    ### Technical Debt
    - Poor code quality accumulates as technical debt
    - Costs increase exponentially over time
    - Slows down feature development
    - Increases bug introduction rate

    ### The Boy Scout Rule
    **"Leave the code cleaner than you found it."**

    Small improvements compound over time:
    - Rename one variable
    - Break up one large function
    - Remove one piece of duplication

    ## Characteristics of Clean Code

    ### 1. Readable
    - Code is read 10x more than it's written
    - Should read like well-written prose
    - Express intent clearly
    - Minimize cognitive load

    ### 2. Simple
    - Does one thing well
    - No unnecessary complexity
    - KISS: Keep It Simple, Stupid
    - YAGNI: You Aren't Gonna Need It

    ### 3. Tested
    - Has comprehensive test coverage
    - Tests serve as documentation
    - Tests enable refactoring

    ### 4. Expressive
    - Self-documenting
    - Names reveal intent
    - Minimal comments needed
    - Code explains "what" and "why"

    ## Cost of Bad Code

    ### Productivity Loss
    ```
    Time →
    ↑
    |     Initial
    | ✓   velocity
    | ✓✓
    | ✓✓✓           Production reality
    | ✓✓✓✓          with bad code
    | ✓✓✓✓✓      ↙
    | ✓✓✓✓✓✓  ↙
    | ✓✓✓✓✓✓↙
    |_____________→ Features
    ```

    ### The Grand Redesign Trap
    - Teams demand rewrite
    - New team starts from scratch
    - Takes years to reach feature parity
    - Meanwhile, original system evolves
    - Cycle repeats

    ## Clean Code Principles

    ### 1. Meaningful Names
    - Reveal intention
    - Avoid disinformation
    - Make meaningful distinctions
    - Use pronounceable names
    - Use searchable names

    ### 2. Functions
    - Small (< 20 lines ideal)
    - Do one thing
    - One level of abstraction
    - Few arguments (0-2 ideal)
    - No side effects

    ### 3. Comments
    - Code should be self-explanatory
    - Good code > comments
    - Explain "why", not "what"
    - Update or delete stale comments

    ### 4. Formatting
    - Consistent style
    - Vertical openness
    - Horizontal density
    - Team agreement

    ## The Total Cost of Owning a Mess

    Studies show:
    - 80% of software cost is maintenance
    - Original authors maintain < 20% of code
    - Comprehension is the biggest challenge
    - Clean code reduces onboarding time by 50%

    ## Key Takeaways

    1. **Quality is not negotiable** - It's not a luxury, it's essential
    2. **Start clean** - Easier than cleaning up later
    3. **Continuous improvement** - Small daily improvements compound
    4. **Team effort** - Code reviews and pair programming help
    5. **Professional responsibility** - Part of being a software craftsperson
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 8 microlessons for Clean Code Principles"
