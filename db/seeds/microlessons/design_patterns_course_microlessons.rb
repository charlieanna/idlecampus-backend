# AUTO-GENERATED from design_patterns_course.rb
puts "Creating Microlessons for Solid Principles..."

module_var = CourseModule.find_by(slug: 'solid-principles')

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

# Creational Design Patterns

    **Creational patterns** provide ways to create objects while hiding the creation logic, making the system more flexible and reusable.

    ---

    ## 1. Singleton Pattern

    **Ensure a class has only ONE instance and provide a global point of access to it.**

    ### Use Cases
    - Database connections
    - Configuration managers
    - Logger instances
    - Thread pools
    - Cache managers

    ### ❌ BEFORE (Bad - Multiple Instances)

    ```python
    class Database:
        def __init__(self):
            print("Creating new database connection")
            self.connection = self._connect()

        def _connect(self):
            return "Connected to database"

    # Problem: Multiple instances created!
    db1 = Database()  # "Creating new database connection"
    db2 = Database()  # "Creating new database connection"
    db3 = Database()  # "Creating new database connection"

    print(db1 is db2)  # False - different instances
    # Wastes resources, inconsistent state
    ```

    ### ✅ AFTER (Good - Singleton)

    ```python
    class Database:
        _instance = None

        def __new__(cls):
            if cls._instance is None:
                print("Creating single database connection")
                cls._instance = super().__new__(cls)
                cls._instance.connection = "Connected to database"
            return cls._instance

    # Only one instance created!
    db1 = Database()  # "Creating single database connection"
    db2 = Database()  # Returns existing instance
    db3 = Database()  # Returns existing instance

    print(db1 is db2)  # True - same instance
    print(db2 is db3)  # True - same instance
    ```

    ### Thread-Safe Singleton (Python)

    ```python
    import threading

    class ThreadSafeSingleton:
        _instance = None
        _lock = threading.Lock()

        def __new__(cls):
            if cls._instance is None:
                with cls._lock:
                    # Double-checked locking
                    if cls._instance is None:
                        cls._instance = super().__new__(cls)
            return cls._instance

    # Or use decorator:
    def singleton(cls):
        instances = {}
        lock = threading.Lock()

        def get_instance(*args, **kwargs):
            if cls not in instances:
                with lock:
                    if cls not in instances:
                        instances[cls] = cls(*args, **kwargs)
            return instances[cls]

        return get_instance

    @singleton
    class Logger:
        def __init__(self):
            self.logs = []

        def log(self, message):
            self.logs.append(message)
    ```

    ### Thread-Safe Singleton (JavaScript)

    ```javascript
    class Database {
      constructor() {
        if (Database.instance) {
          return Database.instance;
        }
        this.connection = 'Connected to database';
        Database.instance = this;
      }

      query(sql) {
        console.log(`Executing: ${sql}`);
      }
    }

    // Usage:
    const db1 = new Database();
    const db2 = new Database();
    console.log(db1 === db2); // true
    ```

    ### ⚠️ Singleton Drawbacks

    - Hard to test (global state)
    - Violates Single Responsibility (manages instance + business logic)
    - Hidden dependencies
    - Can cause issues in multi-threaded environments

    **Better alternative:** Dependency Injection

    ---

    ## 2. Factory Pattern

    **Define an interface for creating objects, but let subclasses decide which class to instantiate.**

    ### Use Cases
    - Creating different types of UI elements
    - Database connection factories
    - Document creators (PDF, Word, Excel)
    - Vehicle manufacturing

    ### ❌ BEFORE (Bad - Tight Coupling)

    ```python
    class CarShowroom:
        def order_vehicle(self, vehicle_type):
            if vehicle_type == 'sedan':
                vehicle = Sedan()
            elif vehicle_type == 'suv':
                vehicle = SUV()
            elif vehicle_type == 'truck':
                vehicle = Truck()
            else:
                raise ValueError("Unknown vehicle type")

            vehicle.assemble()
            vehicle.test()
            return vehicle

    # Problem: Must modify code to add new vehicle types
    ```

    ### ✅ AFTER (Good - Factory Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Product interface
    class Vehicle(ABC):
        @abstractmethod
        def assemble(self):
            pass

        @abstractmethod
        def test(self):
            pass

    # Concrete products
    class Sedan(Vehicle):
        def assemble(self):
            print("Assembling sedan")

        def test(self):
            print("Testing sedan")

    class SUV(Vehicle):
        def assemble(self):
            print("Assembling SUV")

        def test(self):
            print("Testing SUV")

    class Truck(Vehicle):
        def assemble(self):
            print("Assembling truck")

        def test(self):
            print("Testing truck")

    # Factory
    class VehicleFactory:
        @staticmethod
        def create_vehicle(vehicle_type):
            vehicles = {
                'sedan': Sedan,
                'suv': SUV,
                'truck': Truck
            }

            vehicle_class = vehicles.get(vehicle_type.lower())
            if vehicle_class:
                return vehicle_class()
            raise ValueError(f"Unknown vehicle type: {vehicle_type}")

    # Usage:
    factory = VehicleFactory()
    sedan = factory.create_vehicle('sedan')
    sedan.assemble()
    sedan.test()

    suv = factory.create_vehicle('suv')
    suv.assemble()
    suv.test()
    ```

    ### Real-World Example: Notification System

    ```python
    class Notification(ABC):
        @abstractmethod
        def send(self, message):
            pass

    class EmailNotification(Notification):
        def send(self, message):
            print(f"Sending email: {message}")

    class SMSNotification(Notification):
        def send(self, message):
            print(f"Sending SMS: {message}")

    class PushNotification(Notification):
        def send(self, message):
            print(f"Sending push notification: {message}")

    class NotificationFactory:
        @staticmethod
        def create(notification_type):
            types = {
                'email': EmailNotification,
                'sms': SMSNotification,
                'push': PushNotification
            }
            return types[notification_type]()

    # Usage:
    notif = NotificationFactory.create('email')
    notif.send("Welcome to our service!")
    ```

    ---

    ## 3. Abstract Factory Pattern

    **Provide an interface for creating families of related objects without specifying their concrete classes.**

    ### Use Cases
    - UI toolkits (Windows, Mac, Linux themes)
    - Cross-platform applications
    - Database drivers
    - Product families (furniture sets)

    ### ✅ Abstract Factory Example

    ```python
    from abc import ABC, abstractmethod

    # Abstract products
    class Button(ABC):
        @abstractmethod
        def render(self):
            pass

    class Checkbox(ABC):
        @abstractmethod
        def render(self):
            pass

    # Concrete products - Windows
    class WindowsButton(Button):
        def render(self):
            return "Rendering Windows button"

    class WindowsCheckbox(Checkbox):
        def render(self):
            return "Rendering Windows checkbox"

    # Concrete products - Mac
    class MacButton(Button):
        def render(self):
            return "Rendering Mac button"

    class MacCheckbox(Checkbox):
        def render(self):
            return "Rendering Mac checkbox"

    # Abstract factory
    class GUIFactory(ABC):
        @abstractmethod
        def create_button(self) -> Button:
            pass

        @abstractmethod
        def create_checkbox(self) -> Checkbox:
            pass

    # Concrete factories
    class WindowsFactory(GUIFactory):
        def create_button(self):
            return WindowsButton()

        def create_checkbox(self):
            return WindowsCheckbox()

    class MacFactory(GUIFactory):
        def create_button(self):
            return MacButton()

        def create_checkbox(self):
            return MacCheckbox()

    # Client code
    class Application:
        def __init__(self, factory: GUIFactory):
            self.factory = factory

        def render_ui(self):
            button = self.factory.create_button()
            checkbox = self.factory.create_checkbox()
            print(button.render())
            print(checkbox.render())

    # Usage:
    import platform

    if platform.system() == 'Windows':
        factory = WindowsFactory()
    else:
        factory = MacFactory()

    app = Application(factory)
    app.render_ui()
    ```

    ---

    ## 4. Builder Pattern

    **Separate the construction of a complex object from its representation.**

    ### Use Cases
    - Building complex objects with many optional parameters
    - SQL query builders
    - HTTP request builders
    - Meal/menu builders

    ### ❌ BEFORE (Bad - Constructor with Too Many Parameters)

    ```python
    class Computer:
        def __init__(self, cpu, ram, storage, gpu, wifi, bluetooth,
                     usb_ports, display_size, os, keyboard_backlight,
                     touchscreen, webcam):
            self.cpu = cpu
            self.ram = ram
            self.storage = storage
            self.gpu = gpu
            self.wifi = wifi
            self.bluetooth = bluetooth
            self.usb_ports = usb_ports
            self.display_size = display_size
            self.os = os
            self.keyboard_backlight = keyboard_backlight
            self.touchscreen = touchscreen
            self.webcam = webcam

    # Problem: Hard to remember parameter order
    computer = Computer('Intel i7', '16GB', '512GB SSD', 'NVIDIA RTX',
                       True, True, 4, 15.6, 'Windows', True, False, True)
    # What does 'True, True, 4, 15.6' mean? Unclear!
    ```

    ### ✅ AFTER (Good - Builder Pattern)

    ```python
    class Computer:
        def __init__(self):
            self.cpu = None
            self.ram = None
            self.storage = None
            self.gpu = None
            self.wifi = False
            self.bluetooth = False
            self.usb_ports = 0
            self.display_size = 0
            self.os = None
            self.keyboard_backlight = False
            self.touchscreen = False
            self.webcam = False

        def __str__(self):
            return f"Computer({self.cpu}, {self.ram}, {self.storage})"

    class ComputerBuilder:
        def __init__(self):
            self.computer = Computer()

        def set_cpu(self, cpu):
            self.computer.cpu = cpu
            return self  # Return self for method chaining

        def set_ram(self, ram):
            self.computer.ram = ram
            return self

        def set_storage(self, storage):
            self.computer.storage = storage
            return self

        def set_gpu(self, gpu):
            self.computer.gpu = gpu
            return self

        def enable_wifi(self):
            self.computer.wifi = True
            return self

        def enable_bluetooth(self):
            self.computer.bluetooth = True
            return self

        def set_usb_ports(self, count):
            self.computer.usb_ports = count
            return self

        def set_display_size(self, size):
            self.computer.display_size = size
            return self

        def set_os(self, os):
            self.computer.os = os
            return self

        def enable_keyboard_backlight(self):
            self.computer.keyboard_backlight = True
            return self

        def enable_touchscreen(self):
            self.computer.touchscreen = True
            return self

        def enable_webcam(self):
            self.computer.webcam = True
            return self

        def build(self):
            return self.computer

    # Usage: Clear and readable!
    computer = (ComputerBuilder()
                .set_cpu('Intel i7')
                .set_ram('16GB')
                .set_storage('512GB SSD')
                .set_gpu('NVIDIA RTX')
                .enable_wifi()
                .enable_bluetooth()
                .set_usb_ports(4)
                .set_display_size(15.6)
                .set_os('Windows')
                .enable_keyboard_backlight()
                .enable_webcam()
                .build())

    print(computer)
    ```

    ### Builder with Director (Preset Configurations)

    ```python
    class ComputerDirector:
        def __init__(self, builder):
            self.builder = builder

        def build_gaming_computer(self):
            return (self.builder
                    .set_cpu('Intel i9')
                    .set_ram('32GB')
                    .set_storage('1TB NVMe SSD')
                    .set_gpu('NVIDIA RTX 4090')
                    .enable_wifi()
                    .enable_bluetooth()
                    .set_usb_ports(8)
                    .enable_keyboard_backlight()
                    .build())

        def build_office_computer(self):
            return (self.builder
                    .set_cpu('Intel i5')
                    .set_ram('8GB')
                    .set_storage('256GB SSD')
                    .enable_wifi()
                    .set_usb_ports(4)
                    .enable_webcam()
                    .build())

    # Usage:
    director = ComputerDirector(ComputerBuilder())
    gaming_pc = director.build_gaming_computer()
    office_pc = director.build_office_computer()
    ```

    ---

    ## 5. Prototype Pattern

    **Create new objects by copying existing objects (prototypes).**

    ### Use Cases
    - Cloning complex objects
    - Avoiding expensive initialization
    - When object creation is costly
    - Creating variations of objects

    ### ✅ Prototype Pattern

    ```python
    import copy

    class Prototype:
        def clone(self):
            return copy.deepcopy(self)

    class Shape(Prototype):
        def __init__(self, x, y, color):
            self.x = x
            self.y = y
            self.color = color

        def __str__(self):
            return f"{self.__class__.__name__}(x={self.x}, y={self.y}, color={self.color})"

    class Circle(Shape):
        def __init__(self, x, y, color, radius):
            super().__init__(x, y, color)
            self.radius = radius

        def __str__(self):
            return f"Circle(x={self.x}, y={self.y}, color={self.color}, radius={self.radius})"

    class Rectangle(Shape):
        def __init__(self, x, y, color, width, height):
            super().__init__(x, y, color)
            self.width = width
            self.height = height

    # Usage:
    # Create original
    original_circle = Circle(10, 20, 'red', 5)
    print(f"Original: {original_circle}")

    # Clone and modify
    cloned_circle = original_circle.clone()
    cloned_circle.x = 30
    cloned_circle.color = 'blue'
    print(f"Clone: {cloned_circle}")
    print(f"Original unchanged: {original_circle}")
    ```

    ### Real-World Example: Document Templates

    ```python
    import copy

    class Document:
        def __init__(self, title, content, formatting):
            self.title = title
            self.content = content
            self.formatting = formatting
            # Assume expensive initialization
            print(f"Creating document: {title}")

        def clone(self):
            print(f"Cloning document: {self.title}")
            return copy.deepcopy(self)

    # Create template (expensive)
    template = Document(
        "Report Template",
        "Executive Summary\\n\\nDetails\\n\\nConclusion",
        {"font": "Arial", "size": 12, "margins": [1, 1, 1, 1]}
    )

    # Clone for specific reports (cheap)
    q1_report = template.clone()
    q1_report.title = "Q1 Report"
    q1_report.content = "Q1 Sales: $1M"

    q2_report = template.clone()
    q2_report.title = "Q2 Report"
    q2_report.content = "Q2 Sales: $1.2M"
    ```

    ---

    ## When to Use Each Pattern

    | Pattern | Use When |
    |---------|----------|
    | **Singleton** | Need exactly one instance (config, connection pool) |
    | **Factory** | Creating objects without exposing creation logic |
    | **Abstract Factory** | Need to create families of related objects |
    | **Builder** | Creating complex objects with many optional parameters |
    | **Prototype** | Cloning is cheaper than creating from scratch |

    ## Comparison Example

    ```python
    # Singleton: One database connection for entire app
    db = Database.get_instance()

    # Factory: Create different notification types
    notif = NotificationFactory.create('email')

    # Abstract Factory: Create related UI components
    factory = WindowsFactory()
    button = factory.create_button()
    checkbox = factory.create_checkbox()

    # Builder: Build complex object step by step
    computer = ComputerBuilder().set_cpu('i7').set_ram('16GB').build()

    # Prototype: Clone existing object
    new_doc = template.clone()
    ```

    **Next**: We'll explore structural patterns that help organize relationships between objects.
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

# Structural Patterns

    **Structural patterns** explain how to assemble objects and classes into larger structures while keeping these structures flexible and efficient.

    ---

    ## 1. Adapter Pattern

    **Convert the interface of a class into another interface clients expect.**

    Also known as: Wrapper

    ### Use Cases
    - Integrating third-party libraries
    - Legacy code integration
    - API compatibility layers
    - Payment gateway integration

    ### ❌ BEFORE (Incompatible Interfaces)

    ```python
    # Old payment system
    class OldPaymentSystem:
        def process_old_payment(self, amount):
            print(f"Processing payment via old system: ${amount}")

    # New payment system with different interface
    class NewPaymentSystem:
        def make_payment(self, payment_info):
            print(f"Processing payment via new system: ${payment_info['amount']}")

    # Client code expects this interface
    def checkout(payment_processor):
        payment_processor.pay(100)  # Error! Neither system has pay() method

    # Problem: Can't use old or new system without changing client code
    ```

    ### ✅ AFTER (Good - Adapter Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Target interface (what client expects)
    class PaymentProcessor(ABC):
        @abstractmethod
        def pay(self, amount):
            pass

    # Adaptee 1: Old system
    class OldPaymentSystem:
        def process_old_payment(self, amount):
            print(f"Processing via old system: ${amount}")

    # Adapter 1: Wraps old system
    class OldPaymentAdapter(PaymentProcessor):
        def __init__(self):
            self.old_system = OldPaymentSystem()

        def pay(self, amount):
            self.old_system.process_old_payment(amount)

    # Adaptee 2: New system
    class NewPaymentSystem:
        def make_payment(self, payment_info):
            print(f"Processing via new system: ${payment_info['amount']}")

    # Adapter 2: Wraps new system
    class NewPaymentAdapter(PaymentProcessor):
        def __init__(self):
            self.new_system = NewPaymentSystem()

        def pay(self, amount):
            payment_info = {'amount': amount, 'currency': 'USD'}
            self.new_system.make_payment(payment_info)

    # Client code works with any adapter
    def checkout(payment_processor: PaymentProcessor, amount):
        payment_processor.pay(amount)

    # Usage:
    checkout(OldPaymentAdapter(), 100)  # Works!
    checkout(NewPaymentAdapter(), 200)  # Works!
    ```

    ### Real-World Example: Data Format Adapter

    ```python
    # JSON API
    class JSONDataProvider:
        def get_json_data(self):
            return '{"name": "Alice", "age": 30}'

    # XML API
    class XMLDataProvider:
        def get_xml_data(self):
            return '<person><name>Bob</name><age>25</age></person>'

    # Target interface
    class DataProvider(ABC):
        @abstractmethod
        def get_data(self):
            pass

    # Adapters
    class JSONAdapter(DataProvider):
        def __init__(self, json_provider):
            self.provider = json_provider

        def get_data(self):
            import json
            json_str = self.provider.get_json_data()
            return json.loads(json_str)

    class XMLAdapter(DataProvider):
        def __init__(self, xml_provider):
            self.provider = xml_provider

        def get_data(self):
            import xml.etree.ElementTree as ET
            xml_str = self.provider.get_xml_data()
            root = ET.fromstring(xml_str)
            return {
                'name': root.find('name').text,
                'age': int(root.find('age').text)
            }

    # Usage:
    providers = [
        JSONAdapter(JSONDataProvider()),
        XMLAdapter(XMLDataProvider())
    ]

    for provider in providers:
        data = provider.get_data()
        print(f"Name: {data['name']}, Age: {data['age']}")
    ```

    ---

    ## 2. Decorator Pattern

    **Attach additional responsibilities to an object dynamically.**

    ### Use Cases
    - Adding features to objects without inheritance
    - Coffee shop ordering (size, milk, sugar, whipped cream)
    - Text formatting (bold, italic, underline)
    - Middleware/interceptors
    - Logging, caching, validation

    ### ❌ BEFORE (Bad - Inheritance Explosion)

    ```python
    # Base coffee
    class Coffee:
        def cost(self):
            return 5

    # Problem: Need class for every combination!
    class CoffeeWithMilk(Coffee):
        def cost(self):
            return 5 + 1

    class CoffeeWithSugar(Coffee):
        def cost(self):
            return 5 + 0.5

    class CoffeeWithMilkAndSugar(Coffee):
        def cost(self):
            return 5 + 1 + 0.5

    class CoffeeWithMilkSugarAndWhippedCream(Coffee):
        def cost(self):
            return 5 + 1 + 0.5 + 2

    # 3 toppings = 8 classes, 4 toppings = 16 classes, 5 = 32, etc.
    # Combinatorial explosion!
    ```

    ### ✅ AFTER (Good - Decorator Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Component interface
    class Coffee(ABC):
        @abstractmethod
        def cost(self):
            pass

        @abstractmethod
        def description(self):
            pass

    # Concrete component
    class SimpleCoffee(Coffee):
        def cost(self):
            return 5

        def description(self):
            return "Simple coffee"

    # Base decorator
    class CoffeeDecorator(Coffee):
        def __init__(self, coffee: Coffee):
            self._coffee = coffee

        def cost(self):
            return self._coffee.cost()

        def description(self):
            return self._coffee.description()

    # Concrete decorators
    class MilkDecorator(CoffeeDecorator):
        def cost(self):
            return self._coffee.cost() + 1

        def description(self):
            return self._coffee.description() + ", milk"

    class SugarDecorator(CoffeeDecorator):
        def cost(self):
            return self._coffee.cost() + 0.5

        def description(self):
            return self._coffee.description() + ", sugar"

    class WhippedCreamDecorator(CoffeeDecorator):
        def cost(self):
            return self._coffee.cost() + 2

        def description(self):
            return self._coffee.description() + ", whipped cream"

    # Usage: Compose decorators dynamically!
    coffee = SimpleCoffee()
    print(f"{coffee.description()}: ${coffee.cost()}")
    # "Simple coffee: $5"

    coffee = MilkDecorator(SimpleCoffee())
    print(f"{coffee.description()}: ${coffee.cost()}")
    # "Simple coffee, milk: $6"

    coffee = WhippedCreamDecorator(SugarDecorator(MilkDecorator(SimpleCoffee())))
    print(f"{coffee.description()}: ${coffee.cost()}")
    # "Simple coffee, milk, sugar, whipped cream: $8.5"
    ```

    ### Python Decorator Functions

    ```python
    # Function decorator for logging
    def log_execution(func):
        def wrapper(*args, **kwargs):
            print(f"Executing {func.__name__}")
            result = func(*args, **kwargs)
            print(f"Finished {func.__name__}")
            return result
        return wrapper

    # Decorator for timing
    import time
    def measure_time(func):
        def wrapper(*args, **kwargs):
            start = time.time()
            result = func(*args, **kwargs)
            end = time.time()
            print(f"{func.__name__} took {end - start:.2f}s")
            return result
        return wrapper

    # Usage:
    @log_execution
    @measure_time
    def process_data(data):
        time.sleep(1)
        return f"Processed {len(data)} items"

    result = process_data([1, 2, 3])
    # Output:
    # Executing process_data
    # process_data took 1.00s
    # Finished process_data
    ```

    ---

    ## 3. Proxy Pattern

    **Provide a surrogate or placeholder for another object to control access to it.**

    ### Types of Proxies
    - **Virtual Proxy**: Lazy initialization (load heavy object on demand)
    - **Protection Proxy**: Access control (authentication/authorization)
    - **Remote Proxy**: Represent object in different address space
    - **Caching Proxy**: Cache results of expensive operations

    ### ✅ Virtual Proxy (Lazy Loading)

    ```python
    from abc import ABC, abstractmethod

    class Image(ABC):
        @abstractmethod
        def display(self):
            pass

    # Real object (heavy)
    class RealImage(Image):
        def __init__(self, filename):
            self.filename = filename
            self._load_from_disk()

        def _load_from_disk(self):
            print(f"Loading image from disk: {self.filename}")
            # Expensive operation

        def display(self):
            print(f"Displaying image: {self.filename}")

    # Proxy (lazy loading)
    class ImageProxy(Image):
        def __init__(self, filename):
            self.filename = filename
            self._real_image = None

        def display(self):
            if self._real_image is None:
                self._real_image = RealImage(self.filename)
            self._real_image.display()

    # Usage:
    image1 = ImageProxy("photo1.jpg")  # Not loaded yet
    image2 = ImageProxy("photo2.jpg")  # Not loaded yet

    image1.display()  # Loads and displays
    # Loading image from disk: photo1.jpg
    # Displaying image: photo1.jpg

    image1.display()  # Already loaded, just displays
    # Displaying image: photo1.jpg
    ```

    ### Protection Proxy (Access Control)

    ```python
    class Document:
        def __init__(self, content):
            self.content = content

        def read(self):
            return self.content

        def write(self, content):
            self.content = content

    class ProtectedDocument:
        def __init__(self, document, user_role):
            self.document = document
            self.user_role = user_role

        def read(self):
            return self.document.read()

        def write(self, content):
            if self.user_role == 'admin':
                self.document.write(content)
                print("Document updated")
            else:
                raise PermissionError("Only admins can write")

    # Usage:
    doc = Document("Secret data")

    admin_doc = ProtectedDocument(doc, 'admin')
    admin_doc.write("New data")  # Works

    user_doc = ProtectedDocument(doc, 'user')
    print(user_doc.read())  # Works
    # user_doc.write("Hack")  # PermissionError!
    ```

    ### Caching Proxy

    ```python
    class DatabaseQuery:
        def execute(self, query):
            print(f"Executing expensive query: {query}")
            # Simulate expensive database query
            import time
            time.sleep(1)
            return f"Results for: {query}"

    class CachedDatabaseQuery:
        def __init__(self):
            self.db = DatabaseQuery()
            self.cache = {}

        def execute(self, query):
            if query in self.cache:
                print(f"Returning cached result for: {query}")
                return self.cache[query]

            result = self.db.execute(query)
            self.cache[query] = result
            return result

    # Usage:
    db = CachedDatabaseQuery()

    db.execute("SELECT * FROM users")
    # Executing expensive query: SELECT * FROM users
    # (waits 1 second)

    db.execute("SELECT * FROM users")
    # Returning cached result for: SELECT * FROM users
    # (instant!)
    ```

    ---

    ## 4. Facade Pattern

    **Provide a unified interface to a set of interfaces in a subsystem.**

    ### Use Cases
    - Simplifying complex libraries
    - Home theater systems (TV, sound, lights, DVD)
    - Computer startup (CPU, memory, hard drive)
    - API wrappers

    ### ❌ BEFORE (Complex Subsystem)

    ```python
    # Client must interact with many subsystems
    tv = TV()
    tv.turn_on()
    tv.set_input("HDMI1")

    sound_system = SoundSystem()
    sound_system.turn_on()
    sound_system.set_volume(20)
    sound_system.set_mode("surround")

    dvd_player = DVDPlayer()
    dvd_player.turn_on()
    dvd_player.load_disc()

    lights = Lights()
    lights.dim(10)

    # Too complex! Many steps to watch a movie
    ```

    ### ✅ AFTER (Good - Facade Pattern)

    ```python
    # Subsystems
    class TV:
        def turn_on(self):
            print("TV on")

        def turn_off(self):
            print("TV off")

        def set_input(self, input_source):
            print(f"TV input: {input_source}")

    class SoundSystem:
        def turn_on(self):
            print("Sound system on")

        def turn_off(self):
            print("Sound system off")

        def set_volume(self, level):
            print(f"Volume: {level}")

        def set_mode(self, mode):
            print(f"Sound mode: {mode}")

    class DVDPlayer:
        def turn_on(self):
            print("DVD player on")

        def turn_off(self):
            print("DVD player off")

        def load_disc(self):
            print("Loading disc")

    class Lights:
        def dim(self, level):
            print(f"Lights dimmed to {level}%")

        def brighten(self):
            print("Lights brightened")

    # Facade
    class HomeTheaterFacade:
        def __init__(self):
            self.tv = TV()
            self.sound = SoundSystem()
            self.dvd = DVDPlayer()
            self.lights = Lights()

        def watch_movie(self):
            print("Get ready to watch a movie...")
            self.lights.dim(10)
            self.tv.turn_on()
            self.tv.set_input("HDMI1")
            self.sound.turn_on()
            self.sound.set_volume(20)
            self.sound.set_mode("surround")
            self.dvd.turn_on()
            self.dvd.load_disc()
            print("Movie ready!")

        def end_movie(self):
            print("Shutting down theater...")
            self.dvd.turn_off()
            self.sound.turn_off()
            self.tv.turn_off()
            self.lights.brighten()
            print("Theater shut down")

    # Usage: Simple!
    theater = HomeTheaterFacade()
    theater.watch_movie()
    # ...watch movie...
    theater.end_movie()
    ```

    ---

    ## 5. Composite Pattern

    **Compose objects into tree structures to represent part-whole hierarchies.**

    ### Use Cases
    - File system (files and directories)
    - UI component trees
    - Organization hierarchies
    - Menu systems

    ### ✅ Composite Pattern

    ```python
    from abc import ABC, abstractmethod

    # Component
    class FileSystemItem(ABC):
        def __init__(self, name):
            self.name = name

        @abstractmethod
        def get_size(self):
            pass

        @abstractmethod
        def display(self, indent=0):
            pass

    # Leaf
    class File(FileSystemItem):
        def __init__(self, name, size):
            super().__init__(name)
            self.size = size

        def get_size(self):
            return self.size

        def display(self, indent=0):
            print("  " * indent + f"File: {self.name} ({self.size}KB)")

    # Composite
    class Directory(FileSystemItem):
        def __init__(self, name):
            super().__init__(name)
            self.children = []

        def add(self, item):
            self.children.append(item)

        def remove(self, item):
            self.children.remove(item)

        def get_size(self):
            return sum(child.get_size() for child in self.children)

        def display(self, indent=0):
            print("  " * indent + f"Directory: {self.name}/")
            for child in self.children:
                child.display(indent + 1)

    # Usage:
    root = Directory("root")

    home = Directory("home")
    home.add(File("photo.jpg", 2048))
    home.add(File("document.txt", 10))

    work = Directory("work")
    work.add(File("report.pdf", 500))
    work.add(File("data.csv", 1000))

    root.add(home)
    root.add(work)
    root.add(File("readme.txt", 5))

    # Display tree
    root.display()
    # Directory: root/
    #   Directory: home/
    #     File: photo.jpg (2048KB)
    #     File: document.txt (10KB)
    #   Directory: work/
    #     File: report.pdf (500KB)
    #     File: data.csv (1000KB)
    #   File: readme.txt (5KB)

    print(f"Total size: {root.get_size()}KB")
    # Total size: 3563KB
    ```

    ---

    ## Pattern Comparison

    | Pattern | Purpose | Example |
    |---------|---------|---------|
    | **Adapter** | Make incompatible interfaces work together | Payment gateway wrapper |
    | **Decorator** | Add responsibilities dynamically | Coffee with toppings |
    | **Proxy** | Control access to object | Image lazy loading |
    | **Facade** | Simplify complex subsystem | Home theater remote |
    | **Composite** | Tree structures | File system |

    **Next**: We'll explore behavioral patterns that define communication between objects.
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

# Behavioral Patterns

    **Behavioral patterns** are concerned with algorithms and the assignment of responsibilities between objects.

    ---

    ## 1. Observer Pattern

    **Define a one-to-many dependency so that when one object changes state, all its dependents are notified automatically.**

    Also known as: Publish-Subscribe, Event-Listener

    ### Use Cases
    - Event handling systems
    - Stock price updates
    - News notifications
    - Model-View-Controller (MVC)
    - Real-time dashboards

    ### ❌ BEFORE (Bad - Tight Coupling)

    ```python
    class WeatherStation:
        def __init__(self):
            self.temperature = 0
            self.display1 = Display1()
            self.display2 = Display2()
            self.logger = Logger()

        def set_temperature(self, temp):
            self.temperature = temp
            # Must know about all displays and update each
            self.display1.update(temp)
            self.display2.update(temp)
            self.logger.log(temp)

    # Problem: WeatherStation tightly coupled to all displays
    # Adding new display requires modifying WeatherStation
    ```

    ### ✅ AFTER (Good - Observer Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Observer interface
    class Observer(ABC):
        @abstractmethod
        def update(self, temperature):
            pass

    # Subject (Observable)
    class WeatherStation:
        def __init__(self):
            self._observers = []
            self._temperature = 0

        def attach(self, observer: Observer):
            self._observers.append(observer)

        def detach(self, observer: Observer):
            self._observers.remove(observer)

        def notify(self):
            for observer in self._observers:
                observer.update(self._temperature)

        def set_temperature(self, temp):
            print(f"WeatherStation: Temperature changed to {temp}°C")
            self._temperature = temp
            self.notify()

    # Concrete observers
    class PhoneDisplay(Observer):
        def update(self, temperature):
            print(f"Phone Display: {temperature}°C")

    class WindowDisplay(Observer):
        def update(self, temperature):
            print(f"Window Display: {temperature}°C")

    class Logger(Observer):
        def update(self, temperature):
            print(f"Logger: Recording temperature {temperature}°C")

    # Usage:
    weather = WeatherStation()

    phone = PhoneDisplay()
    window = WindowDisplay()
    logger = Logger()

    weather.attach(phone)
    weather.attach(window)
    weather.attach(logger)

    weather.set_temperature(25)
    # WeatherStation: Temperature changed to 25°C
    # Phone Display: 25°C
    # Window Display: 25°C
    # Logger: Recording temperature 25°C

    weather.detach(window)
    weather.set_temperature(30)
    # WeatherStation: Temperature changed to 30°C
    # Phone Display: 30°C
    # Logger: Recording temperature 30°C
    ```

    ### Real-World Example: Stock Market

    ```python
    class Stock:
        def __init__(self, symbol, price):
            self.symbol = symbol
            self._price = price
            self._observers = []

        def attach(self, observer):
            self._observers.append(observer)

        def detach(self, observer):
            self._observers.remove(observer)

        def notify(self):
            for observer in self._observers:
                observer.update(self)

        @property
        def price(self):
            return self._price

        @price.setter
        def price(self, value):
            self._price = value
            self.notify()

    class Investor(Observer):
        def __init__(self, name):
            self.name = name

        def update(self, stock):
            print(f"{self.name}: {stock.symbol} is now ${stock.price}")
            if stock.price > 150:
                print(f"{self.name}: Selling {stock.symbol}!")
            elif stock.price < 100:
                print(f"{self.name}: Buying {stock.symbol}!")

    # Usage:
    google = Stock("GOOGL", 120)

    investor1 = Investor("Alice")
    investor2 = Investor("Bob")

    google.attach(investor1)
    google.attach(investor2)

    google.price = 95  # Both investors notified
    google.price = 155  # Both investors notified
    ```

    ---

    ## 2. Strategy Pattern

    **Define a family of algorithms, encapsulate each one, and make them interchangeable.**

    ### Use Cases
    - Payment methods
    - Sorting algorithms
    - Compression algorithms
    - Validation strategies
    - Route navigation

    ### ❌ BEFORE (Bad - Conditional Logic)

    ```python
    class PaymentProcessor:
        def process_payment(self, amount, method):
            if method == 'credit_card':
                print(f"Processing ${amount} via credit card")
                # Credit card logic
            elif method == 'paypal':
                print(f"Processing ${amount} via PayPal")
                # PayPal logic
            elif method == 'bitcoin':
                print(f"Processing ${amount} via Bitcoin")
                # Bitcoin logic
            elif method == 'bank_transfer':
                print(f"Processing ${amount} via bank transfer")
                # Bank transfer logic

    # Problem: Must modify class to add new payment methods
    # Violates Open/Closed Principle
    ```

    ### ✅ AFTER (Good - Strategy Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Strategy interface
    class PaymentStrategy(ABC):
        @abstractmethod
        def pay(self, amount):
            pass

    # Concrete strategies
    class CreditCardPayment(PaymentStrategy):
        def __init__(self, card_number, cvv):
            self.card_number = card_number
            self.cvv = cvv

        def pay(self, amount):
            print(f"Paid ${amount} using credit card {self.card_number[-4:]}")

    class PayPalPayment(PaymentStrategy):
        def __init__(self, email):
            self.email = email

        def pay(self, amount):
            print(f"Paid ${amount} using PayPal account {self.email}")

    class BitcoinPayment(PaymentStrategy):
        def __init__(self, wallet_address):
            self.wallet_address = wallet_address

        def pay(self, amount):
            print(f"Paid ${amount} using Bitcoin wallet {self.wallet_address}")

    # Context
    class ShoppingCart:
        def __init__(self):
            self.items = []
            self.total = 0

        def add_item(self, item, price):
            self.items.append(item)
            self.total += price

        def checkout(self, payment_strategy: PaymentStrategy):
            payment_strategy.pay(self.total)
            print("Payment successful!")

    # Usage:
    cart = ShoppingCart()
    cart.add_item("Laptop", 1000)
    cart.add_item("Mouse", 50)

    # Pay with credit card
    cart.checkout(CreditCardPayment("1234-5678-9012-3456", "123"))

    # Or pay with PayPal
    cart.checkout(PayPalPayment("user@example.com"))

    # Or pay with Bitcoin
    cart.checkout(BitcoinPayment("1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"))
    ```

    ### Real-World Example: Sorting Strategies

    ```python
    class SortStrategy(ABC):
        @abstractmethod
        def sort(self, data):
            pass

    class QuickSort(SortStrategy):
        def sort(self, data):
            print("Sorting using QuickSort")
            return sorted(data)  # Simplified

    class MergeSort(SortStrategy):
        def sort(self, data):
            print("Sorting using MergeSort")
            return sorted(data)  # Simplified

    class BubbleSort(SortStrategy):
        def sort(self, data):
            print("Sorting using BubbleSort")
            return sorted(data)  # Simplified

    class DataProcessor:
        def __init__(self, strategy: SortStrategy):
            self.strategy = strategy

        def set_strategy(self, strategy: SortStrategy):
            self.strategy = strategy

        def process(self, data):
            return self.strategy.sort(data)

    # Usage:
    data = [5, 2, 8, 1, 9]

    processor = DataProcessor(QuickSort())
    result = processor.process(data)

    # Switch strategy at runtime
    processor.set_strategy(MergeSort())
    result = processor.process(data)
    ```

    ---

    ## 3. Command Pattern

    **Encapsulate a request as an object, thereby letting you parameterize clients with different requests, queue requests, and support undoable operations.**

    ### Use Cases
    - Undo/Redo functionality
    - Transaction systems
    - Job queues
    - Menu actions
    - Macro recording

    ### ✅ Command Pattern

    ```python
    from abc import ABC, abstractmethod

    # Receiver
    class Light:
        def turn_on(self):
            print("Light is ON")

        def turn_off(self):
            print("Light is OFF")

    # Command interface
    class Command(ABC):
        @abstractmethod
        def execute(self):
            pass

        @abstractmethod
        def undo(self):
            pass

    # Concrete commands
    class LightOnCommand(Command):
        def __init__(self, light: Light):
            self.light = light

        def execute(self):
            self.light.turn_on()

        def undo(self):
            self.light.turn_off()

    class LightOffCommand(Command):
        def __init__(self, light: Light):
            self.light = light

        def execute(self):
            self.light.turn_off()

        def undo(self):
            self.light.turn_on()

    # Invoker
    class RemoteControl:
        def __init__(self):
            self.history = []

        def execute_command(self, command: Command):
            command.execute()
            self.history.append(command)

        def undo_last(self):
            if self.history:
                command = self.history.pop()
                command.undo()

    # Usage:
    light = Light()
    remote = RemoteControl()

    on_command = LightOnCommand(light)
    off_command = LightOffCommand(light)

    remote.execute_command(on_command)   # Light is ON
    remote.execute_command(off_command)  # Light is OFF
    remote.undo_last()                   # Light is ON
    remote.undo_last()                   # Light is OFF
    ```

    ### Real-World Example: Text Editor

    ```python
    class TextEditor:
        def __init__(self):
            self.text = ""

        def insert(self, text, position):
            self.text = self.text[:position] + text + self.text[position:]

        def delete(self, position, length):
            deleted = self.text[position:position + length]
            self.text = self.text[:position] + self.text[position + length:]
            return deleted

        def get_text(self):
            return self.text

    class InsertCommand(Command):
        def __init__(self, editor, text, position):
            self.editor = editor
            self.text = text
            self.position = position

        def execute(self):
            self.editor.insert(self.text, self.position)

        def undo(self):
            self.editor.delete(self.position, len(self.text))

    class DeleteCommand(Command):
        def __init__(self, editor, position, length):
            self.editor = editor
            self.position = position
            self.length = length
            self.deleted_text = ""

        def execute(self):
            self.deleted_text = self.editor.delete(self.position, self.length)

        def undo(self):
            self.editor.insert(self.deleted_text, self.position)

    # Usage:
    editor = TextEditor()
    history = []

    # Type "Hello"
    cmd1 = InsertCommand(editor, "Hello", 0)
    cmd1.execute()
    history.append(cmd1)
    print(editor.get_text())  # "Hello"

    # Type " World"
    cmd2 = InsertCommand(editor, " World", 5)
    cmd2.execute()
    history.append(cmd2)
    print(editor.get_text())  # "Hello World"

    # Undo last action
    history.pop().undo()
    print(editor.get_text())  # "Hello"

    # Undo again
    history.pop().undo()
    print(editor.get_text())  # ""
    ```

    ---

    ## 4. State Pattern

    **Allow an object to alter its behavior when its internal state changes.**

    ### Use Cases
    - TCP connections (listen, established, closed)
    - Vending machines
    - Document workflow (draft, review, published)
    - Player states in games

    ### ❌ BEFORE (Bad - Conditional State Logic)

    ```python
    class VendingMachine:
        def __init__(self):
            self.state = "no_coin"

        def insert_coin(self):
            if self.state == "no_coin":
                print("Coin inserted")
                self.state = "has_coin"
            elif self.state == "has_coin":
                print("Already have a coin")

        def eject_coin(self):
            if self.state == "has_coin":
                print("Coin ejected")
                self.state = "no_coin"
            elif self.state == "no_coin":
                print("No coin to eject")

        def dispense(self):
            if self.state == "has_coin":
                print("Dispensing product")
                self.state = "no_coin"
            elif self.state == "no_coin":
                print("Insert coin first")

    # Problem: Complex conditionals grow with each state
    ```

    ### ✅ AFTER (Good - State Pattern)

    ```python
    from abc import ABC, abstractmethod

    # State interface
    class State(ABC):
        @abstractmethod
        def insert_coin(self, machine):
            pass

        @abstractmethod
        def eject_coin(self, machine):
            pass

        @abstractmethod
        def dispense(self, machine):
            pass

    # Concrete states
    class NoCoinState(State):
        def insert_coin(self, machine):
            print("Coin inserted")
            machine.state = HasCoinState()

        def eject_coin(self, machine):
            print("No coin to eject")

        def dispense(self, machine):
            print("Insert coin first")

    class HasCoinState(State):
        def insert_coin(self, machine):
            print("Already have a coin")

        def eject_coin(self, machine):
            print("Coin ejected")
            machine.state = NoCoinState()

        def dispense(self, machine):
            print("Dispensing product")
            machine.state = NoCoinState()

    # Context
    class VendingMachine:
        def __init__(self):
            self.state = NoCoinState()

        def insert_coin(self):
            self.state.insert_coin(self)

        def eject_coin(self):
            self.state.eject_coin(self)

        def dispense(self):
            self.state.dispense(self)

    # Usage:
    machine = VendingMachine()
    machine.insert_coin()  # Coin inserted
    machine.dispense()     # Dispensing product
    machine.dispense()     # Insert coin first
    machine.insert_coin()  # Coin inserted
    machine.eject_coin()   # Coin ejected
    ```

    ---

    ## 5. Template Method Pattern

    **Define the skeleton of an algorithm, deferring some steps to subclasses.**

    ### Use Cases
    - Data processing pipelines
    - Game AI
    - Web frameworks (request handling)
    - Testing frameworks

    ### ✅ Template Method Pattern

    ```python
    from abc import ABC, abstractmethod

    class DataProcessor(ABC):
        # Template method
        def process(self):
            self.load_data()
            self.parse_data()
            self.analyze_data()
            self.send_report()

        @abstractmethod
        def load_data(self):
            pass

        @abstractmethod
        def parse_data(self):
            pass

        def analyze_data(self):
            # Default implementation (can be overridden)
            print("Analyzing data using default algorithm")

        def send_report(self):
            # Common implementation
            print("Sending report via email")

    class CSVDataProcessor(DataProcessor):
        def load_data(self):
            print("Loading data from CSV file")

        def parse_data(self):
            print("Parsing CSV data")

    class XMLDataProcessor(DataProcessor):
        def load_data(self):
            print("Loading data from XML file")

        def parse_data(self):
            print("Parsing XML data")

        def analyze_data(self):
            # Override default
            print("Analyzing data using XML-specific algorithm")

    # Usage:
    csv_processor = CSVDataProcessor()
    csv_processor.process()
    # Loading data from CSV file
    # Parsing CSV data
    # Analyzing data using default algorithm
    # Sending report via email

    xml_processor = XMLDataProcessor()
    xml_processor.process()
    # Loading data from XML file
    # Parsing XML data
    # Analyzing data using XML-specific algorithm
    # Sending report via email
    ```

    ---

    ## Pattern Comparison

    | Pattern | Purpose | Example |
    |---------|---------|---------|
    | **Observer** | One-to-many notification | Weather station updates |
    | **Strategy** | Interchangeable algorithms | Payment methods |
    | **Command** | Encapsulate requests | Undo/Redo |
    | **State** | Object behavior changes with state | Vending machine |
    | **Template Method** | Algorithm skeleton with customizable steps | Data processing pipeline |

    ---

    ## Real-World Combined Example: E-Commerce Order System

    ```python
    # Observer: Notify stakeholders of order status
    class OrderObserver(ABC):
        @abstractmethod
        def update(self, order):
            pass

    class EmailNotifier(OrderObserver):
        def update(self, order):
            print(f"Email: Order {order.id} status: {order.status}")

    class SMSNotifier(OrderObserver):
        def update(self, order):
            print(f"SMS: Order {order.id} status: {order.status}")

    # State: Order lifecycle
    class OrderState(ABC):
        @abstractmethod
        def process(self, order):
            pass

    class PendingState(OrderState):
        def process(self, order):
            print("Processing payment...")
            order.state = ProcessingState()

    class ProcessingState(OrderState):
        def process(self, order):
            print("Shipping order...")
            order.state = ShippedState()

    class ShippedState(OrderState):
        def process(self, order):
            print("Order already shipped")

    # Strategy: Payment method
    class PaymentStrategy(ABC):
        @abstractmethod
        def pay(self, amount):
            pass

    # Command: Order actions
    class OrderCommand(ABC):
        @abstractmethod
        def execute(self):
            pass

    class PlaceOrderCommand(OrderCommand):
        def __init__(self, order):
            self.order = order

        def execute(self):
            self.order.place()

    # Order class combines patterns
    class Order:
        def __init__(self, order_id):
            self.id = order_id
            self.status = "pending"
            self.state = PendingState()
            self._observers = []

        def attach(self, observer):
            self._observers.append(observer)

        def notify(self):
            for observer in self._observers:
                observer.update(self)

        def place(self):
            self.status = "placed"
            self.notify()

        def process_next(self):
            self.state.process(self)
            self.notify()
    ```

    **Congratulations!** You've learned the essential design patterns for writing maintainable, flexible code.
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

# SOLID Principles Explained

    **SOLID** is an acronym for five design principles that make software designs more understandable, flexible, and maintainable.

    ## Why SOLID?

    ```python
    # Without SOLID principles:
    - Hard to modify code (ripple effects)
    - Difficult to test
    - Tight coupling between components
    - Code duplication
    - Fragile to change

    # With SOLID principles:
    - Easy to extend and modify
    - Testable and maintainable
    - Loose coupling
    - Clear responsibilities
    - Resilient to change
    ```

    ---

    ## 1. Single Responsibility Principle (SRP)

    **A class should have only ONE reason to change.**

    Each class should have one job, one responsibility, one focus.

    ### ❌ BEFORE (Bad - Multiple Responsibilities)

    ```python
    class User:
        def __init__(self, name, email):
            self.name = name
            self.email = email

        def get_name(self):
            return self.name

        # Responsibility 1: User data management
        def save_to_database(self):
            db = Database()
            db.execute(f"INSERT INTO users VALUES ('{self.name}', '{self.email}')")

        # Responsibility 2: Email sending
        def send_welcome_email(self):
            smtp = SMTP('smtp.example.com')
            smtp.send(self.email, 'Welcome!', 'Thanks for joining')

        # Responsibility 3: Report generation
        def generate_user_report(self):
            return f"User Report: {self.name} - {self.email}"
    ```

    **Problems:**
    - 3 reasons to change: database logic, email logic, report format
    - Hard to test (must mock database AND email)
    - Violates SRP

    ### ✅ AFTER (Good - Single Responsibility)

    ```python
    # Responsibility 1: User data only
    class User:
        def __init__(self, name, email):
            self.name = name
            self.email = email

        def get_name(self):
            return self.name

        def get_email(self):
            return self.email

    # Responsibility 2: Database operations
    class UserRepository:
        def save(self, user):
            db = Database()
            db.execute(f"INSERT INTO users VALUES ('{user.name}', '{user.email}')")

        def find_by_email(self, email):
            db = Database()
            result = db.query(f"SELECT * FROM users WHERE email = '{email}'")
            return User(result['name'], result['email'])

    # Responsibility 3: Email operations
    class EmailService:
        def send_welcome_email(self, user):
            smtp = SMTP('smtp.example.com')
            smtp.send(user.email, 'Welcome!', f'Thanks for joining, {user.name}!')

    # Responsibility 4: Report generation
    class UserReportGenerator:
        def generate(self, user):
            return f"User Report: {user.name} - {user.email}"

    # Usage:
    user = User("Alice", "alice@example.com")
    UserRepository().save(user)
    EmailService().send_welcome_email(user)
    report = UserReportGenerator().generate(user)
    ```

    **Benefits:**
    - Each class has ONE reason to change
    - Easy to test (each class independently)
    - Easy to modify (change email logic without touching User)

    ---

    ## 2. Open/Closed Principle (OCP)

    **Classes should be OPEN for extension but CLOSED for modification.**

    You should be able to add new functionality without changing existing code.

    ### ❌ BEFORE (Bad - Modifying Existing Code)

    ```python
    class PaymentProcessor:
        def process_payment(self, amount, payment_type):
            if payment_type == 'credit_card':
                print(f"Processing credit card payment: ${amount}")
                # Credit card logic
            elif payment_type == 'paypal':
                print(f"Processing PayPal payment: ${amount}")
                # PayPal logic
            elif payment_type == 'bitcoin':
                print(f"Processing Bitcoin payment: ${amount}")
                # Bitcoin logic
            # Need to add Stripe? Must modify this class!
            # elif payment_type == 'stripe':
            #     ...
    ```

    **Problems:**
    - Must modify class for each new payment method
    - Risk of breaking existing functionality
    - Violates OCP

    ### ✅ AFTER (Good - Open for Extension)

    ```python
    from abc import ABC, abstractmethod

    # Abstract base class
    class PaymentMethod(ABC):
        @abstractmethod
        def process(self, amount):
            pass

    # Concrete implementations
    class CreditCardPayment(PaymentMethod):
        def process(self, amount):
            print(f"Processing credit card payment: ${amount}")
            # Credit card logic

    class PayPalPayment(PaymentMethod):
        def process(self, amount):
            print(f"Processing PayPal payment: ${amount}")
            # PayPal logic

    class BitcoinPayment(PaymentMethod):
        def process(self, amount):
            print(f"Processing Bitcoin payment: ${amount}")
            # Bitcoin logic

    # Add new payment method WITHOUT modifying existing code
    class StripePayment(PaymentMethod):
        def process(self, amount):
            print(f"Processing Stripe payment: ${amount}")
            # Stripe logic

    # Processor never needs to change
    class PaymentProcessor:
        def process_payment(self, amount, payment_method: PaymentMethod):
            payment_method.process(amount)

    # Usage:
    processor = PaymentProcessor()
    processor.process_payment(100, CreditCardPayment())
    processor.process_payment(50, PayPalPayment())
    processor.process_payment(200, StripePayment())  # New method added easily!
    ```

    **Benefits:**
    - Add new payment methods without modifying existing code
    - No risk of breaking existing functionality
    - Easy to test each payment method independently

    ---

    ## 3. Liskov Substitution Principle (LSP)

    **Objects of a superclass should be replaceable with objects of a subclass without breaking the application.**

    If S is a subtype of T, then objects of type T can be replaced with objects of type S.

    ### ❌ BEFORE (Bad - Violates LSP)

    ```python
    class Bird:
        def fly(self):
            return "Flying in the sky"

    class Sparrow(Bird):
        def fly(self):
            return "Sparrow flying at 20 mph"

    class Penguin(Bird):
        def fly(self):
            # Penguins can't fly!
            raise Exception("Penguins cannot fly")

    # Problem:
    def make_bird_fly(bird: Bird):
        return bird.fly()

    make_bird_fly(Sparrow())  # Works
    make_bird_fly(Penguin())  # Crashes! Violates LSP
    ```

    **Problem:** Penguin can't be substituted for Bird without breaking code.

    ### ✅ AFTER (Good - Follows LSP)

    ```python
    class Bird:
        def move(self):
            pass

    class FlyingBird(Bird):
        def fly(self):
            return "Flying in the sky"

        def move(self):
            return self.fly()

    class Sparrow(FlyingBird):
        def fly(self):
            return "Sparrow flying at 20 mph"

    class Penguin(Bird):
        def swim(self):
            return "Penguin swimming underwater"

        def move(self):
            return self.swim()

    # Now all birds can be substituted
    def make_bird_move(bird: Bird):
        return bird.move()

    make_bird_move(Sparrow())  # "Sparrow flying at 20 mph"
    make_bird_move(Penguin())  # "Penguin swimming underwater"
    # Both work! LSP satisfied
    ```

    **Benefits:**
    - All subclasses can be used interchangeably
    - No unexpected exceptions
    - Clear hierarchy

    ### Another Example: Rectangle vs Square

    ```python
    # BAD: Violates LSP
    class Rectangle:
        def __init__(self, width, height):
            self.width = width
            self.height = height

        def set_width(self, width):
            self.width = width

        def set_height(self, height):
            self.height = height

        def area(self):
            return self.width * self.height

    class Square(Rectangle):
        def set_width(self, width):
            self.width = width
            self.height = width  # Square must have equal sides

        def set_height(self, height):
            self.width = height
            self.height = height

    # Test:
    def test_rectangle(rect: Rectangle):
        rect.set_width(5)
        rect.set_height(4)
        assert rect.area() == 20  # Fails for Square!

    test_rectangle(Rectangle(0, 0))  # Passes
    test_rectangle(Square(0, 0))     # Fails! Violates LSP
    ```

    **Solution:** Don't inherit Square from Rectangle. Use separate classes or a Shape interface.

    ---

    ## 4. Interface Segregation Principle (ISP)

    **Clients should not be forced to depend on interfaces they don't use.**

    Many specific interfaces are better than one general-purpose interface.

    ### ❌ BEFORE (Bad - Fat Interface)

    ```python
    from abc import ABC, abstractmethod

    class Worker(ABC):
        @abstractmethod
        def work(self):
            pass

        @abstractmethod
        def eat(self):
            pass

        @abstractmethod
        def sleep(self):
            pass

    class Human(Worker):
        def work(self):
            print("Human working")

        def eat(self):
            print("Human eating")

        def sleep(self):
            print("Human sleeping")

    class Robot(Worker):
        def work(self):
            print("Robot working")

        def eat(self):
            # Robots don't eat!
            raise NotImplementedError("Robots don't eat")

        def sleep(self):
            # Robots don't sleep!
            raise NotImplementedError("Robots don't sleep")
    ```

    **Problem:** Robot forced to implement eat() and sleep() even though it doesn't need them.

    ### ✅ AFTER (Good - Segregated Interfaces)

    ```python
    from abc import ABC, abstractmethod

    # Separate interfaces for different behaviors
    class Workable(ABC):
        @abstractmethod
        def work(self):
            pass

    class Eatable(ABC):
        @abstractmethod
        def eat(self):
            pass

    class Sleepable(ABC):
        @abstractmethod
        def sleep(self):
            pass

    # Human implements all interfaces
    class Human(Workable, Eatable, Sleepable):
        def work(self):
            print("Human working")

        def eat(self):
            print("Human eating")

        def sleep(self):
            print("Human sleeping")

    # Robot only implements what it needs
    class Robot(Workable):
        def work(self):
            print("Robot working")

    # Usage:
    def manage_worker(worker: Workable):
        worker.work()

    def feed_creature(creature: Eatable):
        creature.eat()

    human = Human()
    robot = Robot()

    manage_worker(human)  # Works
    manage_worker(robot)  # Works

    feed_creature(human)  # Works
    # feed_creature(robot)  # Type error - good! Robot doesn't implement Eatable
    ```

    **Benefits:**
    - Classes only implement methods they need
    - Clear, focused interfaces
    - More flexible and maintainable

    ---

    ## 5. Dependency Inversion Principle (DIP)

    **Depend on abstractions, not concretions.**

    - High-level modules should not depend on low-level modules. Both should depend on abstractions.
    - Abstractions should not depend on details. Details should depend on abstractions.

    ### ❌ BEFORE (Bad - Depends on Concretions)

    ```python
    # Low-level module
    class MySQLDatabase:
        def connect(self):
            print("Connecting to MySQL")

        def save_user(self, user):
            print(f"Saving {user} to MySQL")

    # High-level module depends on low-level
    class UserService:
        def __init__(self):
            self.database = MySQLDatabase()  # Tight coupling!

        def create_user(self, name):
            user = f"User: {name}"
            self.database.save_user(user)

    # Problem: Want to switch to PostgreSQL? Must modify UserService!
    ```

    **Problem:** UserService is tightly coupled to MySQLDatabase. Can't easily switch databases.

    ### ✅ AFTER (Good - Depends on Abstractions)

    ```python
    from abc import ABC, abstractmethod

    # Abstraction (interface)
    class Database(ABC):
        @abstractmethod
        def connect(self):
            pass

        @abstractmethod
        def save_user(self, user):
            pass

    # Low-level implementations
    class MySQLDatabase(Database):
        def connect(self):
            print("Connecting to MySQL")

        def save_user(self, user):
            print(f"Saving {user} to MySQL")

    class PostgreSQLDatabase(Database):
        def connect(self):
            print("Connecting to PostgreSQL")

        def save_user(self, user):
            print(f"Saving {user} to PostgreSQL")

    class MongoDBDatabase(Database):
        def connect(self):
            print("Connecting to MongoDB")

        def save_user(self, user):
            print(f"Saving {user} to MongoDB")

    # High-level module depends on abstraction
    class UserService:
        def __init__(self, database: Database):  # Inject dependency!
            self.database = database

        def create_user(self, name):
            self.database.connect()
            user = f"User: {name}"
            self.database.save_user(user)

    # Usage: Easy to swap implementations
    service1 = UserService(MySQLDatabase())
    service1.create_user("Alice")

    service2 = UserService(PostgreSQLDatabase())
    service2.create_user("Bob")

    service3 = UserService(MongoDBDatabase())
    service3.create_user("Charlie")
    ```

    **Benefits:**
    - Loose coupling
    - Easy to test (inject mock database)
    - Easy to switch implementations
    - Follows Dependency Injection pattern

    ---

    ## Real-World Violation and Fix

    ### E-Commerce System Example

    #### ❌ BEFORE (Violates Multiple SOLID Principles)

    ```python
    class Order:
        def __init__(self, items):
            self.items = items
            self.total = 0

        # Violates SRP: Too many responsibilities
        def calculate_total(self):
            self.total = sum(item['price'] * item['quantity'] for item in self.items)
            return self.total

        def apply_discount(self, discount_code):
            if discount_code == 'SUMMER10':
                self.total *= 0.9
            elif discount_code == 'WINTER20':
                self.total *= 0.8
            # Violates OCP: Must modify for new discount codes

        def process_payment(self, payment_type):
            if payment_type == 'credit_card':
                print(f"Processing credit card: ${self.total}")
            elif payment_type == 'paypal':
                print(f"Processing PayPal: ${self.total}")
            # Violates OCP and DIP: Depends on concrete payment types

        def save_to_database(self):
            # Violates SRP and DIP: Direct database dependency
            import mysql.connector
            db = mysql.connector.connect(host="localhost", user="root")
            cursor = db.cursor()
            cursor.execute(f"INSERT INTO orders VALUES ({self.total})")

        def send_confirmation_email(self):
            # Violates SRP: Order shouldn't know about emails
            print(f"Sending email: Order total ${self.total}")
    ```

    #### ✅ AFTER (Follows SOLID Principles)

    ```python
    from abc import ABC, abstractmethod

    # Order only handles order data (SRP)
    class Order:
        def __init__(self, items):
            self.items = items
            self.subtotal = self._calculate_subtotal()

        def _calculate_subtotal(self):
            return sum(item['price'] * item['quantity'] for item in self.items)

    # Discount strategy (OCP)
    class DiscountStrategy(ABC):
        @abstractmethod
        def apply(self, amount):
            pass

    class PercentageDiscount(DiscountStrategy):
        def __init__(self, percentage):
            self.percentage = percentage

        def apply(self, amount):
            return amount * (1 - self.percentage / 100)

    class FixedDiscount(DiscountStrategy):
        def __init__(self, amount):
            self.amount = amount

        def apply(self, amount):
            return amount - self.amount

    # Payment processing (OCP, DIP)
    class PaymentProcessor(ABC):
        @abstractmethod
        def process(self, amount):
            pass

    class CreditCardProcessor(PaymentProcessor):
        def process(self, amount):
            print(f"Processing credit card: ${amount}")

    class PayPalProcessor(PaymentProcessor):
        def process(self, amount):
            print(f"Processing PayPal: ${amount}")

    # Database abstraction (DIP)
    class OrderRepository(ABC):
        @abstractmethod
        def save(self, order, total):
            pass

    class MySQLOrderRepository(OrderRepository):
        def save(self, order, total):
            print(f"Saving order to MySQL: ${total}")

    # Email service (SRP)
    class EmailService:
        def send_order_confirmation(self, order, total):
            print(f"Sending confirmation email: Order total ${total}")

    # Order service coordinates everything
    class OrderService:
        def __init__(self, repository: OrderRepository, email_service: EmailService):
            self.repository = repository
            self.email_service = email_service

        def place_order(self, order: Order, discount: DiscountStrategy,
                       payment_processor: PaymentProcessor):
            # Calculate total with discount
            total = discount.apply(order.subtotal)

            # Process payment
            payment_processor.process(total)

            # Save order
            self.repository.save(order, total)

            # Send email
            self.email_service.send_order_confirmation(order, total)

    # Usage:
    items = [{'price': 100, 'quantity': 2}, {'price': 50, 'quantity': 1}]
    order = Order(items)

    service = OrderService(
        MySQLOrderRepository(),
        EmailService()
    )

    service.place_order(
        order,
        PercentageDiscount(10),
        CreditCardProcessor()
    )
    ```

    **Benefits:**
    - ✅ SRP: Each class has one responsibility
    - ✅ OCP: Easy to add new discounts/payments without modifying existing code
    - ✅ LSP: All strategies/processors are interchangeable
    - ✅ ISP: Focused interfaces
    - ✅ DIP: Depends on abstractions, not concretions

    ---

    ## Summary

    | Principle | Key Idea | Benefit |
    |-----------|----------|---------|
    | **SRP** | One class, one job | Easy to maintain |
    | **OCP** | Open for extension, closed for modification | Add features without risk |
    | **LSP** | Subtypes must be substitutable | Reliable inheritance |
    | **ISP** | Many small interfaces | No unnecessary dependencies |
    | **DIP** | Depend on abstractions | Loose coupling, testability |

    **Next**: We'll explore creational design patterns that help you create objects in flexible ways.
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

# Creational Design Patterns

    **Creational patterns** provide ways to create objects while hiding the creation logic, making the system more flexible and reusable.

    ---

    ## 1. Singleton Pattern

    **Ensure a class has only ONE instance and provide a global point of access to it.**

    ### Use Cases
    - Database connections
    - Configuration managers
    - Logger instances
    - Thread pools
    - Cache managers

    ### ❌ BEFORE (Bad - Multiple Instances)

    ```python
    class Database:
        def __init__(self):
            print("Creating new database connection")
            self.connection = self._connect()

        def _connect(self):
            return "Connected to database"

    # Problem: Multiple instances created!
    db1 = Database()  # "Creating new database connection"
    db2 = Database()  # "Creating new database connection"
    db3 = Database()  # "Creating new database connection"

    print(db1 is db2)  # False - different instances
    # Wastes resources, inconsistent state
    ```

    ### ✅ AFTER (Good - Singleton)

    ```python
    class Database:
        _instance = None

        def __new__(cls):
            if cls._instance is None:
                print("Creating single database connection")
                cls._instance = super().__new__(cls)
                cls._instance.connection = "Connected to database"
            return cls._instance

    # Only one instance created!
    db1 = Database()  # "Creating single database connection"
    db2 = Database()  # Returns existing instance
    db3 = Database()  # Returns existing instance

    print(db1 is db2)  # True - same instance
    print(db2 is db3)  # True - same instance
    ```

    ### Thread-Safe Singleton (Python)

    ```python
    import threading

    class ThreadSafeSingleton:
        _instance = None
        _lock = threading.Lock()

        def __new__(cls):
            if cls._instance is None:
                with cls._lock:
                    # Double-checked locking
                    if cls._instance is None:
                        cls._instance = super().__new__(cls)
            return cls._instance

    # Or use decorator:
    def singleton(cls):
        instances = {}
        lock = threading.Lock()

        def get_instance(*args, **kwargs):
            if cls not in instances:
                with lock:
                    if cls not in instances:
                        instances[cls] = cls(*args, **kwargs)
            return instances[cls]

        return get_instance

    @singleton
    class Logger:
        def __init__(self):
            self.logs = []

        def log(self, message):
            self.logs.append(message)
    ```

    ### Thread-Safe Singleton (JavaScript)

    ```javascript
    class Database {
      constructor() {
        if (Database.instance) {
          return Database.instance;
        }
        this.connection = 'Connected to database';
        Database.instance = this;
      }

      query(sql) {
        console.log(`Executing: ${sql}`);
      }
    }

    // Usage:
    const db1 = new Database();
    const db2 = new Database();
    console.log(db1 === db2); // true
    ```

    ### ⚠️ Singleton Drawbacks

    - Hard to test (global state)
    - Violates Single Responsibility (manages instance + business logic)
    - Hidden dependencies
    - Can cause issues in multi-threaded environments

    **Better alternative:** Dependency Injection

    ---

    ## 2. Factory Pattern

    **Define an interface for creating objects, but let subclasses decide which class to instantiate.**

    ### Use Cases
    - Creating different types of UI elements
    - Database connection factories
    - Document creators (PDF, Word, Excel)
    - Vehicle manufacturing

    ### ❌ BEFORE (Bad - Tight Coupling)

    ```python
    class CarShowroom:
        def order_vehicle(self, vehicle_type):
            if vehicle_type == 'sedan':
                vehicle = Sedan()
            elif vehicle_type == 'suv':
                vehicle = SUV()
            elif vehicle_type == 'truck':
                vehicle = Truck()
            else:
                raise ValueError("Unknown vehicle type")

            vehicle.assemble()
            vehicle.test()
            return vehicle

    # Problem: Must modify code to add new vehicle types
    ```

    ### ✅ AFTER (Good - Factory Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Product interface
    class Vehicle(ABC):
        @abstractmethod
        def assemble(self):
            pass

        @abstractmethod
        def test(self):
            pass

    # Concrete products
    class Sedan(Vehicle):
        def assemble(self):
            print("Assembling sedan")

        def test(self):
            print("Testing sedan")

    class SUV(Vehicle):
        def assemble(self):
            print("Assembling SUV")

        def test(self):
            print("Testing SUV")

    class Truck(Vehicle):
        def assemble(self):
            print("Assembling truck")

        def test(self):
            print("Testing truck")

    # Factory
    class VehicleFactory:
        @staticmethod
        def create_vehicle(vehicle_type):
            vehicles = {
                'sedan': Sedan,
                'suv': SUV,
                'truck': Truck
            }

            vehicle_class = vehicles.get(vehicle_type.lower())
            if vehicle_class:
                return vehicle_class()
            raise ValueError(f"Unknown vehicle type: {vehicle_type}")

    # Usage:
    factory = VehicleFactory()
    sedan = factory.create_vehicle('sedan')
    sedan.assemble()
    sedan.test()

    suv = factory.create_vehicle('suv')
    suv.assemble()
    suv.test()
    ```

    ### Real-World Example: Notification System

    ```python
    class Notification(ABC):
        @abstractmethod
        def send(self, message):
            pass

    class EmailNotification(Notification):
        def send(self, message):
            print(f"Sending email: {message}")

    class SMSNotification(Notification):
        def send(self, message):
            print(f"Sending SMS: {message}")

    class PushNotification(Notification):
        def send(self, message):
            print(f"Sending push notification: {message}")

    class NotificationFactory:
        @staticmethod
        def create(notification_type):
            types = {
                'email': EmailNotification,
                'sms': SMSNotification,
                'push': PushNotification
            }
            return types[notification_type]()

    # Usage:
    notif = NotificationFactory.create('email')
    notif.send("Welcome to our service!")
    ```

    ---

    ## 3. Abstract Factory Pattern

    **Provide an interface for creating families of related objects without specifying their concrete classes.**

    ### Use Cases
    - UI toolkits (Windows, Mac, Linux themes)
    - Cross-platform applications
    - Database drivers
    - Product families (furniture sets)

    ### ✅ Abstract Factory Example

    ```python
    from abc import ABC, abstractmethod

    # Abstract products
    class Button(ABC):
        @abstractmethod
        def render(self):
            pass

    class Checkbox(ABC):
        @abstractmethod
        def render(self):
            pass

    # Concrete products - Windows
    class WindowsButton(Button):
        def render(self):
            return "Rendering Windows button"

    class WindowsCheckbox(Checkbox):
        def render(self):
            return "Rendering Windows checkbox"

    # Concrete products - Mac
    class MacButton(Button):
        def render(self):
            return "Rendering Mac button"

    class MacCheckbox(Checkbox):
        def render(self):
            return "Rendering Mac checkbox"

    # Abstract factory
    class GUIFactory(ABC):
        @abstractmethod
        def create_button(self) -> Button:
            pass

        @abstractmethod
        def create_checkbox(self) -> Checkbox:
            pass

    # Concrete factories
    class WindowsFactory(GUIFactory):
        def create_button(self):
            return WindowsButton()

        def create_checkbox(self):
            return WindowsCheckbox()

    class MacFactory(GUIFactory):
        def create_button(self):
            return MacButton()

        def create_checkbox(self):
            return MacCheckbox()

    # Client code
    class Application:
        def __init__(self, factory: GUIFactory):
            self.factory = factory

        def render_ui(self):
            button = self.factory.create_button()
            checkbox = self.factory.create_checkbox()
            print(button.render())
            print(checkbox.render())

    # Usage:
    import platform

    if platform.system() == 'Windows':
        factory = WindowsFactory()
    else:
        factory = MacFactory()

    app = Application(factory)
    app.render_ui()
    ```

    ---

    ## 4. Builder Pattern

    **Separate the construction of a complex object from its representation.**

    ### Use Cases
    - Building complex objects with many optional parameters
    - SQL query builders
    - HTTP request builders
    - Meal/menu builders

    ### ❌ BEFORE (Bad - Constructor with Too Many Parameters)

    ```python
    class Computer:
        def __init__(self, cpu, ram, storage, gpu, wifi, bluetooth,
                     usb_ports, display_size, os, keyboard_backlight,
                     touchscreen, webcam):
            self.cpu = cpu
            self.ram = ram
            self.storage = storage
            self.gpu = gpu
            self.wifi = wifi
            self.bluetooth = bluetooth
            self.usb_ports = usb_ports
            self.display_size = display_size
            self.os = os
            self.keyboard_backlight = keyboard_backlight
            self.touchscreen = touchscreen
            self.webcam = webcam

    # Problem: Hard to remember parameter order
    computer = Computer('Intel i7', '16GB', '512GB SSD', 'NVIDIA RTX',
                       True, True, 4, 15.6, 'Windows', True, False, True)
    # What does 'True, True, 4, 15.6' mean? Unclear!
    ```

    ### ✅ AFTER (Good - Builder Pattern)

    ```python
    class Computer:
        def __init__(self):
            self.cpu = None
            self.ram = None
            self.storage = None
            self.gpu = None
            self.wifi = False
            self.bluetooth = False
            self.usb_ports = 0
            self.display_size = 0
            self.os = None
            self.keyboard_backlight = False
            self.touchscreen = False
            self.webcam = False

        def __str__(self):
            return f"Computer({self.cpu}, {self.ram}, {self.storage})"

    class ComputerBuilder:
        def __init__(self):
            self.computer = Computer()

        def set_cpu(self, cpu):
            self.computer.cpu = cpu
            return self  # Return self for method chaining

        def set_ram(self, ram):
            self.computer.ram = ram
            return self

        def set_storage(self, storage):
            self.computer.storage = storage
            return self

        def set_gpu(self, gpu):
            self.computer.gpu = gpu
            return self

        def enable_wifi(self):
            self.computer.wifi = True
            return self

        def enable_bluetooth(self):
            self.computer.bluetooth = True
            return self

        def set_usb_ports(self, count):
            self.computer.usb_ports = count
            return self

        def set_display_size(self, size):
            self.computer.display_size = size
            return self

        def set_os(self, os):
            self.computer.os = os
            return self

        def enable_keyboard_backlight(self):
            self.computer.keyboard_backlight = True
            return self

        def enable_touchscreen(self):
            self.computer.touchscreen = True
            return self

        def enable_webcam(self):
            self.computer.webcam = True
            return self

        def build(self):
            return self.computer

    # Usage: Clear and readable!
    computer = (ComputerBuilder()
                .set_cpu('Intel i7')
                .set_ram('16GB')
                .set_storage('512GB SSD')
                .set_gpu('NVIDIA RTX')
                .enable_wifi()
                .enable_bluetooth()
                .set_usb_ports(4)
                .set_display_size(15.6)
                .set_os('Windows')
                .enable_keyboard_backlight()
                .enable_webcam()
                .build())

    print(computer)
    ```

    ### Builder with Director (Preset Configurations)

    ```python
    class ComputerDirector:
        def __init__(self, builder):
            self.builder = builder

        def build_gaming_computer(self):
            return (self.builder
                    .set_cpu('Intel i9')
                    .set_ram('32GB')
                    .set_storage('1TB NVMe SSD')
                    .set_gpu('NVIDIA RTX 4090')
                    .enable_wifi()
                    .enable_bluetooth()
                    .set_usb_ports(8)
                    .enable_keyboard_backlight()
                    .build())

        def build_office_computer(self):
            return (self.builder
                    .set_cpu('Intel i5')
                    .set_ram('8GB')
                    .set_storage('256GB SSD')
                    .enable_wifi()
                    .set_usb_ports(4)
                    .enable_webcam()
                    .build())

    # Usage:
    director = ComputerDirector(ComputerBuilder())
    gaming_pc = director.build_gaming_computer()
    office_pc = director.build_office_computer()
    ```

    ---

    ## 5. Prototype Pattern

    **Create new objects by copying existing objects (prototypes).**

    ### Use Cases
    - Cloning complex objects
    - Avoiding expensive initialization
    - When object creation is costly
    - Creating variations of objects

    ### ✅ Prototype Pattern

    ```python
    import copy

    class Prototype:
        def clone(self):
            return copy.deepcopy(self)

    class Shape(Prototype):
        def __init__(self, x, y, color):
            self.x = x
            self.y = y
            self.color = color

        def __str__(self):
            return f"{self.__class__.__name__}(x={self.x}, y={self.y}, color={self.color})"

    class Circle(Shape):
        def __init__(self, x, y, color, radius):
            super().__init__(x, y, color)
            self.radius = radius

        def __str__(self):
            return f"Circle(x={self.x}, y={self.y}, color={self.color}, radius={self.radius})"

    class Rectangle(Shape):
        def __init__(self, x, y, color, width, height):
            super().__init__(x, y, color)
            self.width = width
            self.height = height

    # Usage:
    # Create original
    original_circle = Circle(10, 20, 'red', 5)
    print(f"Original: {original_circle}")

    # Clone and modify
    cloned_circle = original_circle.clone()
    cloned_circle.x = 30
    cloned_circle.color = 'blue'
    print(f"Clone: {cloned_circle}")
    print(f"Original unchanged: {original_circle}")
    ```

    ### Real-World Example: Document Templates

    ```python
    import copy

    class Document:
        def __init__(self, title, content, formatting):
            self.title = title
            self.content = content
            self.formatting = formatting
            # Assume expensive initialization
            print(f"Creating document: {title}")

        def clone(self):
            print(f"Cloning document: {self.title}")
            return copy.deepcopy(self)

    # Create template (expensive)
    template = Document(
        "Report Template",
        "Executive Summary\\n\\nDetails\\n\\nConclusion",
        {"font": "Arial", "size": 12, "margins": [1, 1, 1, 1]}
    )

    # Clone for specific reports (cheap)
    q1_report = template.clone()
    q1_report.title = "Q1 Report"
    q1_report.content = "Q1 Sales: $1M"

    q2_report = template.clone()
    q2_report.title = "Q2 Report"
    q2_report.content = "Q2 Sales: $1.2M"
    ```

    ---

    ## When to Use Each Pattern

    | Pattern | Use When |
    |---------|----------|
    | **Singleton** | Need exactly one instance (config, connection pool) |
    | **Factory** | Creating objects without exposing creation logic |
    | **Abstract Factory** | Need to create families of related objects |
    | **Builder** | Creating complex objects with many optional parameters |
    | **Prototype** | Cloning is cheaper than creating from scratch |

    ## Comparison Example

    ```python
    # Singleton: One database connection for entire app
    db = Database.get_instance()

    # Factory: Create different notification types
    notif = NotificationFactory.create('email')

    # Abstract Factory: Create related UI components
    factory = WindowsFactory()
    button = factory.create_button()
    checkbox = factory.create_checkbox()

    # Builder: Build complex object step by step
    computer = ComputerBuilder().set_cpu('i7').set_ram('16GB').build()

    # Prototype: Clone existing object
    new_doc = template.clone()
    ```

    **Next**: We'll explore structural patterns that help organize relationships between objects.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 7: Lesson 7 ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 7',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Structural Patterns

    **Structural patterns** explain how to assemble objects and classes into larger structures while keeping these structures flexible and efficient.

    ---

    ## 1. Adapter Pattern

    **Convert the interface of a class into another interface clients expect.**

    Also known as: Wrapper

    ### Use Cases
    - Integrating third-party libraries
    - Legacy code integration
    - API compatibility layers
    - Payment gateway integration

    ### ❌ BEFORE (Incompatible Interfaces)

    ```python
    # Old payment system
    class OldPaymentSystem:
        def process_old_payment(self, amount):
            print(f"Processing payment via old system: ${amount}")

    # New payment system with different interface
    class NewPaymentSystem:
        def make_payment(self, payment_info):
            print(f"Processing payment via new system: ${payment_info['amount']}")

    # Client code expects this interface
    def checkout(payment_processor):
        payment_processor.pay(100)  # Error! Neither system has pay() method

    # Problem: Can't use old or new system without changing client code
    ```

    ### ✅ AFTER (Good - Adapter Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Target interface (what client expects)
    class PaymentProcessor(ABC):
        @abstractmethod
        def pay(self, amount):
            pass

    # Adaptee 1: Old system
    class OldPaymentSystem:
        def process_old_payment(self, amount):
            print(f"Processing via old system: ${amount}")

    # Adapter 1: Wraps old system
    class OldPaymentAdapter(PaymentProcessor):
        def __init__(self):
            self.old_system = OldPaymentSystem()

        def pay(self, amount):
            self.old_system.process_old_payment(amount)

    # Adaptee 2: New system
    class NewPaymentSystem:
        def make_payment(self, payment_info):
            print(f"Processing via new system: ${payment_info['amount']}")

    # Adapter 2: Wraps new system
    class NewPaymentAdapter(PaymentProcessor):
        def __init__(self):
            self.new_system = NewPaymentSystem()

        def pay(self, amount):
            payment_info = {'amount': amount, 'currency': 'USD'}
            self.new_system.make_payment(payment_info)

    # Client code works with any adapter
    def checkout(payment_processor: PaymentProcessor, amount):
        payment_processor.pay(amount)

    # Usage:
    checkout(OldPaymentAdapter(), 100)  # Works!
    checkout(NewPaymentAdapter(), 200)  # Works!
    ```

    ### Real-World Example: Data Format Adapter

    ```python
    # JSON API
    class JSONDataProvider:
        def get_json_data(self):
            return '{"name": "Alice", "age": 30}'

    # XML API
    class XMLDataProvider:
        def get_xml_data(self):
            return '<person><name>Bob</name><age>25</age></person>'

    # Target interface
    class DataProvider(ABC):
        @abstractmethod
        def get_data(self):
            pass

    # Adapters
    class JSONAdapter(DataProvider):
        def __init__(self, json_provider):
            self.provider = json_provider

        def get_data(self):
            import json
            json_str = self.provider.get_json_data()
            return json.loads(json_str)

    class XMLAdapter(DataProvider):
        def __init__(self, xml_provider):
            self.provider = xml_provider

        def get_data(self):
            import xml.etree.ElementTree as ET
            xml_str = self.provider.get_xml_data()
            root = ET.fromstring(xml_str)
            return {
                'name': root.find('name').text,
                'age': int(root.find('age').text)
            }

    # Usage:
    providers = [
        JSONAdapter(JSONDataProvider()),
        XMLAdapter(XMLDataProvider())
    ]

    for provider in providers:
        data = provider.get_data()
        print(f"Name: {data['name']}, Age: {data['age']}")
    ```

    ---

    ## 2. Decorator Pattern

    **Attach additional responsibilities to an object dynamically.**

    ### Use Cases
    - Adding features to objects without inheritance
    - Coffee shop ordering (size, milk, sugar, whipped cream)
    - Text formatting (bold, italic, underline)
    - Middleware/interceptors
    - Logging, caching, validation

    ### ❌ BEFORE (Bad - Inheritance Explosion)

    ```python
    # Base coffee
    class Coffee:
        def cost(self):
            return 5

    # Problem: Need class for every combination!
    class CoffeeWithMilk(Coffee):
        def cost(self):
            return 5 + 1

    class CoffeeWithSugar(Coffee):
        def cost(self):
            return 5 + 0.5

    class CoffeeWithMilkAndSugar(Coffee):
        def cost(self):
            return 5 + 1 + 0.5

    class CoffeeWithMilkSugarAndWhippedCream(Coffee):
        def cost(self):
            return 5 + 1 + 0.5 + 2

    # 3 toppings = 8 classes, 4 toppings = 16 classes, 5 = 32, etc.
    # Combinatorial explosion!
    ```

    ### ✅ AFTER (Good - Decorator Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Component interface
    class Coffee(ABC):
        @abstractmethod
        def cost(self):
            pass

        @abstractmethod
        def description(self):
            pass

    # Concrete component
    class SimpleCoffee(Coffee):
        def cost(self):
            return 5

        def description(self):
            return "Simple coffee"

    # Base decorator
    class CoffeeDecorator(Coffee):
        def __init__(self, coffee: Coffee):
            self._coffee = coffee

        def cost(self):
            return self._coffee.cost()

        def description(self):
            return self._coffee.description()

    # Concrete decorators
    class MilkDecorator(CoffeeDecorator):
        def cost(self):
            return self._coffee.cost() + 1

        def description(self):
            return self._coffee.description() + ", milk"

    class SugarDecorator(CoffeeDecorator):
        def cost(self):
            return self._coffee.cost() + 0.5

        def description(self):
            return self._coffee.description() + ", sugar"

    class WhippedCreamDecorator(CoffeeDecorator):
        def cost(self):
            return self._coffee.cost() + 2

        def description(self):
            return self._coffee.description() + ", whipped cream"

    # Usage: Compose decorators dynamically!
    coffee = SimpleCoffee()
    print(f"{coffee.description()}: ${coffee.cost()}")
    # "Simple coffee: $5"

    coffee = MilkDecorator(SimpleCoffee())
    print(f"{coffee.description()}: ${coffee.cost()}")
    # "Simple coffee, milk: $6"

    coffee = WhippedCreamDecorator(SugarDecorator(MilkDecorator(SimpleCoffee())))
    print(f"{coffee.description()}: ${coffee.cost()}")
    # "Simple coffee, milk, sugar, whipped cream: $8.5"
    ```

    ### Python Decorator Functions

    ```python
    # Function decorator for logging
    def log_execution(func):
        def wrapper(*args, **kwargs):
            print(f"Executing {func.__name__}")
            result = func(*args, **kwargs)
            print(f"Finished {func.__name__}")
            return result
        return wrapper

    # Decorator for timing
    import time
    def measure_time(func):
        def wrapper(*args, **kwargs):
            start = time.time()
            result = func(*args, **kwargs)
            end = time.time()
            print(f"{func.__name__} took {end - start:.2f}s")
            return result
        return wrapper

    # Usage:
    @log_execution
    @measure_time
    def process_data(data):
        time.sleep(1)
        return f"Processed {len(data)} items"

    result = process_data([1, 2, 3])
    # Output:
    # Executing process_data
    # process_data took 1.00s
    # Finished process_data
    ```

    ---

    ## 3. Proxy Pattern

    **Provide a surrogate or placeholder for another object to control access to it.**

    ### Types of Proxies
    - **Virtual Proxy**: Lazy initialization (load heavy object on demand)
    - **Protection Proxy**: Access control (authentication/authorization)
    - **Remote Proxy**: Represent object in different address space
    - **Caching Proxy**: Cache results of expensive operations

    ### ✅ Virtual Proxy (Lazy Loading)

    ```python
    from abc import ABC, abstractmethod

    class Image(ABC):
        @abstractmethod
        def display(self):
            pass

    # Real object (heavy)
    class RealImage(Image):
        def __init__(self, filename):
            self.filename = filename
            self._load_from_disk()

        def _load_from_disk(self):
            print(f"Loading image from disk: {self.filename}")
            # Expensive operation

        def display(self):
            print(f"Displaying image: {self.filename}")

    # Proxy (lazy loading)
    class ImageProxy(Image):
        def __init__(self, filename):
            self.filename = filename
            self._real_image = None

        def display(self):
            if self._real_image is None:
                self._real_image = RealImage(self.filename)
            self._real_image.display()

    # Usage:
    image1 = ImageProxy("photo1.jpg")  # Not loaded yet
    image2 = ImageProxy("photo2.jpg")  # Not loaded yet

    image1.display()  # Loads and displays
    # Loading image from disk: photo1.jpg
    # Displaying image: photo1.jpg

    image1.display()  # Already loaded, just displays
    # Displaying image: photo1.jpg
    ```

    ### Protection Proxy (Access Control)

    ```python
    class Document:
        def __init__(self, content):
            self.content = content

        def read(self):
            return self.content

        def write(self, content):
            self.content = content

    class ProtectedDocument:
        def __init__(self, document, user_role):
            self.document = document
            self.user_role = user_role

        def read(self):
            return self.document.read()

        def write(self, content):
            if self.user_role == 'admin':
                self.document.write(content)
                print("Document updated")
            else:
                raise PermissionError("Only admins can write")

    # Usage:
    doc = Document("Secret data")

    admin_doc = ProtectedDocument(doc, 'admin')
    admin_doc.write("New data")  # Works

    user_doc = ProtectedDocument(doc, 'user')
    print(user_doc.read())  # Works
    # user_doc.write("Hack")  # PermissionError!
    ```

    ### Caching Proxy

    ```python
    class DatabaseQuery:
        def execute(self, query):
            print(f"Executing expensive query: {query}")
            # Simulate expensive database query
            import time
            time.sleep(1)
            return f"Results for: {query}"

    class CachedDatabaseQuery:
        def __init__(self):
            self.db = DatabaseQuery()
            self.cache = {}

        def execute(self, query):
            if query in self.cache:
                print(f"Returning cached result for: {query}")
                return self.cache[query]

            result = self.db.execute(query)
            self.cache[query] = result
            return result

    # Usage:
    db = CachedDatabaseQuery()

    db.execute("SELECT * FROM users")
    # Executing expensive query: SELECT * FROM users
    # (waits 1 second)

    db.execute("SELECT * FROM users")
    # Returning cached result for: SELECT * FROM users
    # (instant!)
    ```

    ---

    ## 4. Facade Pattern

    **Provide a unified interface to a set of interfaces in a subsystem.**

    ### Use Cases
    - Simplifying complex libraries
    - Home theater systems (TV, sound, lights, DVD)
    - Computer startup (CPU, memory, hard drive)
    - API wrappers

    ### ❌ BEFORE (Complex Subsystem)

    ```python
    # Client must interact with many subsystems
    tv = TV()
    tv.turn_on()
    tv.set_input("HDMI1")

    sound_system = SoundSystem()
    sound_system.turn_on()
    sound_system.set_volume(20)
    sound_system.set_mode("surround")

    dvd_player = DVDPlayer()
    dvd_player.turn_on()
    dvd_player.load_disc()

    lights = Lights()
    lights.dim(10)

    # Too complex! Many steps to watch a movie
    ```

    ### ✅ AFTER (Good - Facade Pattern)

    ```python
    # Subsystems
    class TV:
        def turn_on(self):
            print("TV on")

        def turn_off(self):
            print("TV off")

        def set_input(self, input_source):
            print(f"TV input: {input_source}")

    class SoundSystem:
        def turn_on(self):
            print("Sound system on")

        def turn_off(self):
            print("Sound system off")

        def set_volume(self, level):
            print(f"Volume: {level}")

        def set_mode(self, mode):
            print(f"Sound mode: {mode}")

    class DVDPlayer:
        def turn_on(self):
            print("DVD player on")

        def turn_off(self):
            print("DVD player off")

        def load_disc(self):
            print("Loading disc")

    class Lights:
        def dim(self, level):
            print(f"Lights dimmed to {level}%")

        def brighten(self):
            print("Lights brightened")

    # Facade
    class HomeTheaterFacade:
        def __init__(self):
            self.tv = TV()
            self.sound = SoundSystem()
            self.dvd = DVDPlayer()
            self.lights = Lights()

        def watch_movie(self):
            print("Get ready to watch a movie...")
            self.lights.dim(10)
            self.tv.turn_on()
            self.tv.set_input("HDMI1")
            self.sound.turn_on()
            self.sound.set_volume(20)
            self.sound.set_mode("surround")
            self.dvd.turn_on()
            self.dvd.load_disc()
            print("Movie ready!")

        def end_movie(self):
            print("Shutting down theater...")
            self.dvd.turn_off()
            self.sound.turn_off()
            self.tv.turn_off()
            self.lights.brighten()
            print("Theater shut down")

    # Usage: Simple!
    theater = HomeTheaterFacade()
    theater.watch_movie()
    # ...watch movie...
    theater.end_movie()
    ```

    ---

    ## 5. Composite Pattern

    **Compose objects into tree structures to represent part-whole hierarchies.**

    ### Use Cases
    - File system (files and directories)
    - UI component trees
    - Organization hierarchies
    - Menu systems

    ### ✅ Composite Pattern

    ```python
    from abc import ABC, abstractmethod

    # Component
    class FileSystemItem(ABC):
        def __init__(self, name):
            self.name = name

        @abstractmethod
        def get_size(self):
            pass

        @abstractmethod
        def display(self, indent=0):
            pass

    # Leaf
    class File(FileSystemItem):
        def __init__(self, name, size):
            super().__init__(name)
            self.size = size

        def get_size(self):
            return self.size

        def display(self, indent=0):
            print("  " * indent + f"File: {self.name} ({self.size}KB)")

    # Composite
    class Directory(FileSystemItem):
        def __init__(self, name):
            super().__init__(name)
            self.children = []

        def add(self, item):
            self.children.append(item)

        def remove(self, item):
            self.children.remove(item)

        def get_size(self):
            return sum(child.get_size() for child in self.children)

        def display(self, indent=0):
            print("  " * indent + f"Directory: {self.name}/")
            for child in self.children:
                child.display(indent + 1)

    # Usage:
    root = Directory("root")

    home = Directory("home")
    home.add(File("photo.jpg", 2048))
    home.add(File("document.txt", 10))

    work = Directory("work")
    work.add(File("report.pdf", 500))
    work.add(File("data.csv", 1000))

    root.add(home)
    root.add(work)
    root.add(File("readme.txt", 5))

    # Display tree
    root.display()
    # Directory: root/
    #   Directory: home/
    #     File: photo.jpg (2048KB)
    #     File: document.txt (10KB)
    #   Directory: work/
    #     File: report.pdf (500KB)
    #     File: data.csv (1000KB)
    #   File: readme.txt (5KB)

    print(f"Total size: {root.get_size()}KB")
    # Total size: 3563KB
    ```

    ---

    ## Pattern Comparison

    | Pattern | Purpose | Example |
    |---------|---------|---------|
    | **Adapter** | Make incompatible interfaces work together | Payment gateway wrapper |
    | **Decorator** | Add responsibilities dynamically | Coffee with toppings |
    | **Proxy** | Control access to object | Image lazy loading |
    | **Facade** | Simplify complex subsystem | Home theater remote |
    | **Composite** | Tree structures | File system |

    **Next**: We'll explore behavioral patterns that define communication between objects.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: Lesson 8 ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 8',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Behavioral Patterns

    **Behavioral patterns** are concerned with algorithms and the assignment of responsibilities between objects.

    ---

    ## 1. Observer Pattern

    **Define a one-to-many dependency so that when one object changes state, all its dependents are notified automatically.**

    Also known as: Publish-Subscribe, Event-Listener

    ### Use Cases
    - Event handling systems
    - Stock price updates
    - News notifications
    - Model-View-Controller (MVC)
    - Real-time dashboards

    ### ❌ BEFORE (Bad - Tight Coupling)

    ```python
    class WeatherStation:
        def __init__(self):
            self.temperature = 0
            self.display1 = Display1()
            self.display2 = Display2()
            self.logger = Logger()

        def set_temperature(self, temp):
            self.temperature = temp
            # Must know about all displays and update each
            self.display1.update(temp)
            self.display2.update(temp)
            self.logger.log(temp)

    # Problem: WeatherStation tightly coupled to all displays
    # Adding new display requires modifying WeatherStation
    ```

    ### ✅ AFTER (Good - Observer Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Observer interface
    class Observer(ABC):
        @abstractmethod
        def update(self, temperature):
            pass

    # Subject (Observable)
    class WeatherStation:
        def __init__(self):
            self._observers = []
            self._temperature = 0

        def attach(self, observer: Observer):
            self._observers.append(observer)

        def detach(self, observer: Observer):
            self._observers.remove(observer)

        def notify(self):
            for observer in self._observers:
                observer.update(self._temperature)

        def set_temperature(self, temp):
            print(f"WeatherStation: Temperature changed to {temp}°C")
            self._temperature = temp
            self.notify()

    # Concrete observers
    class PhoneDisplay(Observer):
        def update(self, temperature):
            print(f"Phone Display: {temperature}°C")

    class WindowDisplay(Observer):
        def update(self, temperature):
            print(f"Window Display: {temperature}°C")

    class Logger(Observer):
        def update(self, temperature):
            print(f"Logger: Recording temperature {temperature}°C")

    # Usage:
    weather = WeatherStation()

    phone = PhoneDisplay()
    window = WindowDisplay()
    logger = Logger()

    weather.attach(phone)
    weather.attach(window)
    weather.attach(logger)

    weather.set_temperature(25)
    # WeatherStation: Temperature changed to 25°C
    # Phone Display: 25°C
    # Window Display: 25°C
    # Logger: Recording temperature 25°C

    weather.detach(window)
    weather.set_temperature(30)
    # WeatherStation: Temperature changed to 30°C
    # Phone Display: 30°C
    # Logger: Recording temperature 30°C
    ```

    ### Real-World Example: Stock Market

    ```python
    class Stock:
        def __init__(self, symbol, price):
            self.symbol = symbol
            self._price = price
            self._observers = []

        def attach(self, observer):
            self._observers.append(observer)

        def detach(self, observer):
            self._observers.remove(observer)

        def notify(self):
            for observer in self._observers:
                observer.update(self)

        @property
        def price(self):
            return self._price

        @price.setter
        def price(self, value):
            self._price = value
            self.notify()

    class Investor(Observer):
        def __init__(self, name):
            self.name = name

        def update(self, stock):
            print(f"{self.name}: {stock.symbol} is now ${stock.price}")
            if stock.price > 150:
                print(f"{self.name}: Selling {stock.symbol}!")
            elif stock.price < 100:
                print(f"{self.name}: Buying {stock.symbol}!")

    # Usage:
    google = Stock("GOOGL", 120)

    investor1 = Investor("Alice")
    investor2 = Investor("Bob")

    google.attach(investor1)
    google.attach(investor2)

    google.price = 95  # Both investors notified
    google.price = 155  # Both investors notified
    ```

    ---

    ## 2. Strategy Pattern

    **Define a family of algorithms, encapsulate each one, and make them interchangeable.**

    ### Use Cases
    - Payment methods
    - Sorting algorithms
    - Compression algorithms
    - Validation strategies
    - Route navigation

    ### ❌ BEFORE (Bad - Conditional Logic)

    ```python
    class PaymentProcessor:
        def process_payment(self, amount, method):
            if method == 'credit_card':
                print(f"Processing ${amount} via credit card")
                # Credit card logic
            elif method == 'paypal':
                print(f"Processing ${amount} via PayPal")
                # PayPal logic
            elif method == 'bitcoin':
                print(f"Processing ${amount} via Bitcoin")
                # Bitcoin logic
            elif method == 'bank_transfer':
                print(f"Processing ${amount} via bank transfer")
                # Bank transfer logic

    # Problem: Must modify class to add new payment methods
    # Violates Open/Closed Principle
    ```

    ### ✅ AFTER (Good - Strategy Pattern)

    ```python
    from abc import ABC, abstractmethod

    # Strategy interface
    class PaymentStrategy(ABC):
        @abstractmethod
        def pay(self, amount):
            pass

    # Concrete strategies
    class CreditCardPayment(PaymentStrategy):
        def __init__(self, card_number, cvv):
            self.card_number = card_number
            self.cvv = cvv

        def pay(self, amount):
            print(f"Paid ${amount} using credit card {self.card_number[-4:]}")

    class PayPalPayment(PaymentStrategy):
        def __init__(self, email):
            self.email = email

        def pay(self, amount):
            print(f"Paid ${amount} using PayPal account {self.email}")

    class BitcoinPayment(PaymentStrategy):
        def __init__(self, wallet_address):
            self.wallet_address = wallet_address

        def pay(self, amount):
            print(f"Paid ${amount} using Bitcoin wallet {self.wallet_address}")

    # Context
    class ShoppingCart:
        def __init__(self):
            self.items = []
            self.total = 0

        def add_item(self, item, price):
            self.items.append(item)
            self.total += price

        def checkout(self, payment_strategy: PaymentStrategy):
            payment_strategy.pay(self.total)
            print("Payment successful!")

    # Usage:
    cart = ShoppingCart()
    cart.add_item("Laptop", 1000)
    cart.add_item("Mouse", 50)

    # Pay with credit card
    cart.checkout(CreditCardPayment("1234-5678-9012-3456", "123"))

    # Or pay with PayPal
    cart.checkout(PayPalPayment("user@example.com"))

    # Or pay with Bitcoin
    cart.checkout(BitcoinPayment("1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"))
    ```

    ### Real-World Example: Sorting Strategies

    ```python
    class SortStrategy(ABC):
        @abstractmethod
        def sort(self, data):
            pass

    class QuickSort(SortStrategy):
        def sort(self, data):
            print("Sorting using QuickSort")
            return sorted(data)  # Simplified

    class MergeSort(SortStrategy):
        def sort(self, data):
            print("Sorting using MergeSort")
            return sorted(data)  # Simplified

    class BubbleSort(SortStrategy):
        def sort(self, data):
            print("Sorting using BubbleSort")
            return sorted(data)  # Simplified

    class DataProcessor:
        def __init__(self, strategy: SortStrategy):
            self.strategy = strategy

        def set_strategy(self, strategy: SortStrategy):
            self.strategy = strategy

        def process(self, data):
            return self.strategy.sort(data)

    # Usage:
    data = [5, 2, 8, 1, 9]

    processor = DataProcessor(QuickSort())
    result = processor.process(data)

    # Switch strategy at runtime
    processor.set_strategy(MergeSort())
    result = processor.process(data)
    ```

    ---

    ## 3. Command Pattern

    **Encapsulate a request as an object, thereby letting you parameterize clients with different requests, queue requests, and support undoable operations.**

    ### Use Cases
    - Undo/Redo functionality
    - Transaction systems
    - Job queues
    - Menu actions
    - Macro recording

    ### ✅ Command Pattern

    ```python
    from abc import ABC, abstractmethod

    # Receiver
    class Light:
        def turn_on(self):
            print("Light is ON")

        def turn_off(self):
            print("Light is OFF")

    # Command interface
    class Command(ABC):
        @abstractmethod
        def execute(self):
            pass

        @abstractmethod
        def undo(self):
            pass

    # Concrete commands
    class LightOnCommand(Command):
        def __init__(self, light: Light):
            self.light = light

        def execute(self):
            self.light.turn_on()

        def undo(self):
            self.light.turn_off()

    class LightOffCommand(Command):
        def __init__(self, light: Light):
            self.light = light

        def execute(self):
            self.light.turn_off()

        def undo(self):
            self.light.turn_on()

    # Invoker
    class RemoteControl:
        def __init__(self):
            self.history = []

        def execute_command(self, command: Command):
            command.execute()
            self.history.append(command)

        def undo_last(self):
            if self.history:
                command = self.history.pop()
                command.undo()

    # Usage:
    light = Light()
    remote = RemoteControl()

    on_command = LightOnCommand(light)
    off_command = LightOffCommand(light)

    remote.execute_command(on_command)   # Light is ON
    remote.execute_command(off_command)  # Light is OFF
    remote.undo_last()                   # Light is ON
    remote.undo_last()                   # Light is OFF
    ```

    ### Real-World Example: Text Editor

    ```python
    class TextEditor:
        def __init__(self):
            self.text = ""

        def insert(self, text, position):
            self.text = self.text[:position] + text + self.text[position:]

        def delete(self, position, length):
            deleted = self.text[position:position + length]
            self.text = self.text[:position] + self.text[position + length:]
            return deleted

        def get_text(self):
            return self.text

    class InsertCommand(Command):
        def __init__(self, editor, text, position):
            self.editor = editor
            self.text = text
            self.position = position

        def execute(self):
            self.editor.insert(self.text, self.position)

        def undo(self):
            self.editor.delete(self.position, len(self.text))

    class DeleteCommand(Command):
        def __init__(self, editor, position, length):
            self.editor = editor
            self.position = position
            self.length = length
            self.deleted_text = ""

        def execute(self):
            self.deleted_text = self.editor.delete(self.position, self.length)

        def undo(self):
            self.editor.insert(self.deleted_text, self.position)

    # Usage:
    editor = TextEditor()
    history = []

    # Type "Hello"
    cmd1 = InsertCommand(editor, "Hello", 0)
    cmd1.execute()
    history.append(cmd1)
    print(editor.get_text())  # "Hello"

    # Type " World"
    cmd2 = InsertCommand(editor, " World", 5)
    cmd2.execute()
    history.append(cmd2)
    print(editor.get_text())  # "Hello World"

    # Undo last action
    history.pop().undo()
    print(editor.get_text())  # "Hello"

    # Undo again
    history.pop().undo()
    print(editor.get_text())  # ""
    ```

    ---

    ## 4. State Pattern

    **Allow an object to alter its behavior when its internal state changes.**

    ### Use Cases
    - TCP connections (listen, established, closed)
    - Vending machines
    - Document workflow (draft, review, published)
    - Player states in games

    ### ❌ BEFORE (Bad - Conditional State Logic)

    ```python
    class VendingMachine:
        def __init__(self):
            self.state = "no_coin"

        def insert_coin(self):
            if self.state == "no_coin":
                print("Coin inserted")
                self.state = "has_coin"
            elif self.state == "has_coin":
                print("Already have a coin")

        def eject_coin(self):
            if self.state == "has_coin":
                print("Coin ejected")
                self.state = "no_coin"
            elif self.state == "no_coin":
                print("No coin to eject")

        def dispense(self):
            if self.state == "has_coin":
                print("Dispensing product")
                self.state = "no_coin"
            elif self.state == "no_coin":
                print("Insert coin first")

    # Problem: Complex conditionals grow with each state
    ```

    ### ✅ AFTER (Good - State Pattern)

    ```python
    from abc import ABC, abstractmethod

    # State interface
    class State(ABC):
        @abstractmethod
        def insert_coin(self, machine):
            pass

        @abstractmethod
        def eject_coin(self, machine):
            pass

        @abstractmethod
        def dispense(self, machine):
            pass

    # Concrete states
    class NoCoinState(State):
        def insert_coin(self, machine):
            print("Coin inserted")
            machine.state = HasCoinState()

        def eject_coin(self, machine):
            print("No coin to eject")

        def dispense(self, machine):
            print("Insert coin first")

    class HasCoinState(State):
        def insert_coin(self, machine):
            print("Already have a coin")

        def eject_coin(self, machine):
            print("Coin ejected")
            machine.state = NoCoinState()

        def dispense(self, machine):
            print("Dispensing product")
            machine.state = NoCoinState()

    # Context
    class VendingMachine:
        def __init__(self):
            self.state = NoCoinState()

        def insert_coin(self):
            self.state.insert_coin(self)

        def eject_coin(self):
            self.state.eject_coin(self)

        def dispense(self):
            self.state.dispense(self)

    # Usage:
    machine = VendingMachine()
    machine.insert_coin()  # Coin inserted
    machine.dispense()     # Dispensing product
    machine.dispense()     # Insert coin first
    machine.insert_coin()  # Coin inserted
    machine.eject_coin()   # Coin ejected
    ```

    ---

    ## 5. Template Method Pattern

    **Define the skeleton of an algorithm, deferring some steps to subclasses.**

    ### Use Cases
    - Data processing pipelines
    - Game AI
    - Web frameworks (request handling)
    - Testing frameworks

    ### ✅ Template Method Pattern

    ```python
    from abc import ABC, abstractmethod

    class DataProcessor(ABC):
        # Template method
        def process(self):
            self.load_data()
            self.parse_data()
            self.analyze_data()
            self.send_report()

        @abstractmethod
        def load_data(self):
            pass

        @abstractmethod
        def parse_data(self):
            pass

        def analyze_data(self):
            # Default implementation (can be overridden)
            print("Analyzing data using default algorithm")

        def send_report(self):
            # Common implementation
            print("Sending report via email")

    class CSVDataProcessor(DataProcessor):
        def load_data(self):
            print("Loading data from CSV file")

        def parse_data(self):
            print("Parsing CSV data")

    class XMLDataProcessor(DataProcessor):
        def load_data(self):
            print("Loading data from XML file")

        def parse_data(self):
            print("Parsing XML data")

        def analyze_data(self):
            # Override default
            print("Analyzing data using XML-specific algorithm")

    # Usage:
    csv_processor = CSVDataProcessor()
    csv_processor.process()
    # Loading data from CSV file
    # Parsing CSV data
    # Analyzing data using default algorithm
    # Sending report via email

    xml_processor = XMLDataProcessor()
    xml_processor.process()
    # Loading data from XML file
    # Parsing XML data
    # Analyzing data using XML-specific algorithm
    # Sending report via email
    ```

    ---

    ## Pattern Comparison

    | Pattern | Purpose | Example |
    |---------|---------|---------|
    | **Observer** | One-to-many notification | Weather station updates |
    | **Strategy** | Interchangeable algorithms | Payment methods |
    | **Command** | Encapsulate requests | Undo/Redo |
    | **State** | Object behavior changes with state | Vending machine |
    | **Template Method** | Algorithm skeleton with customizable steps | Data processing pipeline |

    ---

    ## Real-World Combined Example: E-Commerce Order System

    ```python
    # Observer: Notify stakeholders of order status
    class OrderObserver(ABC):
        @abstractmethod
        def update(self, order):
            pass

    class EmailNotifier(OrderObserver):
        def update(self, order):
            print(f"Email: Order {order.id} status: {order.status}")

    class SMSNotifier(OrderObserver):
        def update(self, order):
            print(f"SMS: Order {order.id} status: {order.status}")

    # State: Order lifecycle
    class OrderState(ABC):
        @abstractmethod
        def process(self, order):
            pass

    class PendingState(OrderState):
        def process(self, order):
            print("Processing payment...")
            order.state = ProcessingState()

    class ProcessingState(OrderState):
        def process(self, order):
            print("Shipping order...")
            order.state = ShippedState()

    class ShippedState(OrderState):
        def process(self, order):
            print("Order already shipped")

    # Strategy: Payment method
    class PaymentStrategy(ABC):
        @abstractmethod
        def pay(self, amount):
            pass

    # Command: Order actions
    class OrderCommand(ABC):
        @abstractmethod
        def execute(self):
            pass

    class PlaceOrderCommand(OrderCommand):
        def __init__(self, order):
            self.order = order

        def execute(self):
            self.order.place()

    # Order class combines patterns
    class Order:
        def __init__(self, order_id):
            self.id = order_id
            self.status = "pending"
            self.state = PendingState()
            self._observers = []

        def attach(self, observer):
            self._observers.append(observer)

        def notify(self):
            for observer in self._observers:
                observer.update(self)

        def place(self):
            self.status = "placed"
            self.notify()

        def process_next(self):
            self.state.process(self)
            self.notify()
    ```

    **Congratulations!** You've learned the essential design patterns for writing maintainable, flexible code.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
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

# === MICROLESSON 10: Lesson 10 ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 10',
  content: <<~MARKDOWN,
# Microlesson 🚀

# SOLID Principles Explained

    **SOLID** is an acronym for five design principles that make software designs more understandable, flexible, and maintainable.

    ## Why SOLID?

    ```python
    # Without SOLID principles:
    - Hard to modify code (ripple effects)
    - Difficult to test
    - Tight coupling between components
    - Code duplication
    - Fragile to change

    # With SOLID principles:
    - Easy to extend and modify
    - Testable and maintainable
    - Loose coupling
    - Clear responsibilities
    - Resilient to change
    ```

    ---

    ## 1. Single Responsibility Principle (SRP)

    **A class should have only ONE reason to change.**

    Each class should have one job, one responsibility, one focus.

    ### ❌ BEFORE (Bad - Multiple Responsibilities)

    ```python
    class User:
        def __init__(self, name, email):
            self.name = name
            self.email = email

        def get_name(self):
            return self.name

        # Responsibility 1: User data management
        def save_to_database(self):
            db = Database()
            db.execute(f"INSERT INTO users VALUES ('{self.name}', '{self.email}')")

        # Responsibility 2: Email sending
        def send_welcome_email(self):
            smtp = SMTP('smtp.example.com')
            smtp.send(self.email, 'Welcome!', 'Thanks for joining')

        # Responsibility 3: Report generation
        def generate_user_report(self):
            return f"User Report: {self.name} - {self.email}"
    ```

    **Problems:**
    - 3 reasons to change: database logic, email logic, report format
    - Hard to test (must mock database AND email)
    - Violates SRP

    ### ✅ AFTER (Good - Single Responsibility)

    ```python
    # Responsibility 1: User data only
    class User:
        def __init__(self, name, email):
            self.name = name
            self.email = email

        def get_name(self):
            return self.name

        def get_email(self):
            return self.email

    # Responsibility 2: Database operations
    class UserRepository:
        def save(self, user):
            db = Database()
            db.execute(f"INSERT INTO users VALUES ('{user.name}', '{user.email}')")

        def find_by_email(self, email):
            db = Database()
            result = db.query(f"SELECT * FROM users WHERE email = '{email}'")
            return User(result['name'], result['email'])

    # Responsibility 3: Email operations
    class EmailService:
        def send_welcome_email(self, user):
            smtp = SMTP('smtp.example.com')
            smtp.send(user.email, 'Welcome!', f'Thanks for joining, {user.name}!')

    # Responsibility 4: Report generation
    class UserReportGenerator:
        def generate(self, user):
            return f"User Report: {user.name} - {user.email}"

    # Usage:
    user = User("Alice", "alice@example.com")
    UserRepository().save(user)
    EmailService().send_welcome_email(user)
    report = UserReportGenerator().generate(user)
    ```

    **Benefits:**
    - Each class has ONE reason to change
    - Easy to test (each class independently)
    - Easy to modify (change email logic without touching User)

    ---

    ## 2. Open/Closed Principle (OCP)

    **Classes should be OPEN for extension but CLOSED for modification.**

    You should be able to add new functionality without changing existing code.

    ### ❌ BEFORE (Bad - Modifying Existing Code)

    ```python
    class PaymentProcessor:
        def process_payment(self, amount, payment_type):
            if payment_type == 'credit_card':
                print(f"Processing credit card payment: ${amount}")
                # Credit card logic
            elif payment_type == 'paypal':
                print(f"Processing PayPal payment: ${amount}")
                # PayPal logic
            elif payment_type == 'bitcoin':
                print(f"Processing Bitcoin payment: ${amount}")
                # Bitcoin logic
            # Need to add Stripe? Must modify this class!
            # elif payment_type == 'stripe':
            #     ...
    ```

    **Problems:**
    - Must modify class for each new payment method
    - Risk of breaking existing functionality
    - Violates OCP

    ### ✅ AFTER (Good - Open for Extension)

    ```python
    from abc import ABC, abstractmethod

    # Abstract base class
    class PaymentMethod(ABC):
        @abstractmethod
        def process(self, amount):
            pass

    # Concrete implementations
    class CreditCardPayment(PaymentMethod):
        def process(self, amount):
            print(f"Processing credit card payment: ${amount}")
            # Credit card logic

    class PayPalPayment(PaymentMethod):
        def process(self, amount):
            print(f"Processing PayPal payment: ${amount}")
            # PayPal logic

    class BitcoinPayment(PaymentMethod):
        def process(self, amount):
            print(f"Processing Bitcoin payment: ${amount}")
            # Bitcoin logic

    # Add new payment method WITHOUT modifying existing code
    class StripePayment(PaymentMethod):
        def process(self, amount):
            print(f"Processing Stripe payment: ${amount}")
            # Stripe logic

    # Processor never needs to change
    class PaymentProcessor:
        def process_payment(self, amount, payment_method: PaymentMethod):
            payment_method.process(amount)

    # Usage:
    processor = PaymentProcessor()
    processor.process_payment(100, CreditCardPayment())
    processor.process_payment(50, PayPalPayment())
    processor.process_payment(200, StripePayment())  # New method added easily!
    ```

    **Benefits:**
    - Add new payment methods without modifying existing code
    - No risk of breaking existing functionality
    - Easy to test each payment method independently

    ---

    ## 3. Liskov Substitution Principle (LSP)

    **Objects of a superclass should be replaceable with objects of a subclass without breaking the application.**

    If S is a subtype of T, then objects of type T can be replaced with objects of type S.

    ### ❌ BEFORE (Bad - Violates LSP)

    ```python
    class Bird:
        def fly(self):
            return "Flying in the sky"

    class Sparrow(Bird):
        def fly(self):
            return "Sparrow flying at 20 mph"

    class Penguin(Bird):
        def fly(self):
            # Penguins can't fly!
            raise Exception("Penguins cannot fly")

    # Problem:
    def make_bird_fly(bird: Bird):
        return bird.fly()

    make_bird_fly(Sparrow())  # Works
    make_bird_fly(Penguin())  # Crashes! Violates LSP
    ```

    **Problem:** Penguin can't be substituted for Bird without breaking code.

    ### ✅ AFTER (Good - Follows LSP)

    ```python
    class Bird:
        def move(self):
            pass

    class FlyingBird(Bird):
        def fly(self):
            return "Flying in the sky"

        def move(self):
            return self.fly()

    class Sparrow(FlyingBird):
        def fly(self):
            return "Sparrow flying at 20 mph"

    class Penguin(Bird):
        def swim(self):
            return "Penguin swimming underwater"

        def move(self):
            return self.swim()

    # Now all birds can be substituted
    def make_bird_move(bird: Bird):
        return bird.move()

    make_bird_move(Sparrow())  # "Sparrow flying at 20 mph"
    make_bird_move(Penguin())  # "Penguin swimming underwater"
    # Both work! LSP satisfied
    ```

    **Benefits:**
    - All subclasses can be used interchangeably
    - No unexpected exceptions
    - Clear hierarchy

    ### Another Example: Rectangle vs Square

    ```python
    # BAD: Violates LSP
    class Rectangle:
        def __init__(self, width, height):
            self.width = width
            self.height = height

        def set_width(self, width):
            self.width = width

        def set_height(self, height):
            self.height = height

        def area(self):
            return self.width * self.height

    class Square(Rectangle):
        def set_width(self, width):
            self.width = width
            self.height = width  # Square must have equal sides

        def set_height(self, height):
            self.width = height
            self.height = height

    # Test:
    def test_rectangle(rect: Rectangle):
        rect.set_width(5)
        rect.set_height(4)
        assert rect.area() == 20  # Fails for Square!

    test_rectangle(Rectangle(0, 0))  # Passes
    test_rectangle(Square(0, 0))     # Fails! Violates LSP
    ```

    **Solution:** Don't inherit Square from Rectangle. Use separate classes or a Shape interface.

    ---

    ## 4. Interface Segregation Principle (ISP)

    **Clients should not be forced to depend on interfaces they don't use.**

    Many specific interfaces are better than one general-purpose interface.

    ### ❌ BEFORE (Bad - Fat Interface)

    ```python
    from abc import ABC, abstractmethod

    class Worker(ABC):
        @abstractmethod
        def work(self):
            pass

        @abstractmethod
        def eat(self):
            pass

        @abstractmethod
        def sleep(self):
            pass

    class Human(Worker):
        def work(self):
            print("Human working")

        def eat(self):
            print("Human eating")

        def sleep(self):
            print("Human sleeping")

    class Robot(Worker):
        def work(self):
            print("Robot working")

        def eat(self):
            # Robots don't eat!
            raise NotImplementedError("Robots don't eat")

        def sleep(self):
            # Robots don't sleep!
            raise NotImplementedError("Robots don't sleep")
    ```

    **Problem:** Robot forced to implement eat() and sleep() even though it doesn't need them.

    ### ✅ AFTER (Good - Segregated Interfaces)

    ```python
    from abc import ABC, abstractmethod

    # Separate interfaces for different behaviors
    class Workable(ABC):
        @abstractmethod
        def work(self):
            pass

    class Eatable(ABC):
        @abstractmethod
        def eat(self):
            pass

    class Sleepable(ABC):
        @abstractmethod
        def sleep(self):
            pass

    # Human implements all interfaces
    class Human(Workable, Eatable, Sleepable):
        def work(self):
            print("Human working")

        def eat(self):
            print("Human eating")

        def sleep(self):
            print("Human sleeping")

    # Robot only implements what it needs
    class Robot(Workable):
        def work(self):
            print("Robot working")

    # Usage:
    def manage_worker(worker: Workable):
        worker.work()

    def feed_creature(creature: Eatable):
        creature.eat()

    human = Human()
    robot = Robot()

    manage_worker(human)  # Works
    manage_worker(robot)  # Works

    feed_creature(human)  # Works
    # feed_creature(robot)  # Type error - good! Robot doesn't implement Eatable
    ```

    **Benefits:**
    - Classes only implement methods they need
    - Clear, focused interfaces
    - More flexible and maintainable

    ---

    ## 5. Dependency Inversion Principle (DIP)

    **Depend on abstractions, not concretions.**

    - High-level modules should not depend on low-level modules. Both should depend on abstractions.
    - Abstractions should not depend on details. Details should depend on abstractions.

    ### ❌ BEFORE (Bad - Depends on Concretions)

    ```python
    # Low-level module
    class MySQLDatabase:
        def connect(self):
            print("Connecting to MySQL")

        def save_user(self, user):
            print(f"Saving {user} to MySQL")

    # High-level module depends on low-level
    class UserService:
        def __init__(self):
            self.database = MySQLDatabase()  # Tight coupling!

        def create_user(self, name):
            user = f"User: {name}"
            self.database.save_user(user)

    # Problem: Want to switch to PostgreSQL? Must modify UserService!
    ```

    **Problem:** UserService is tightly coupled to MySQLDatabase. Can't easily switch databases.

    ### ✅ AFTER (Good - Depends on Abstractions)

    ```python
    from abc import ABC, abstractmethod

    # Abstraction (interface)
    class Database(ABC):
        @abstractmethod
        def connect(self):
            pass

        @abstractmethod
        def save_user(self, user):
            pass

    # Low-level implementations
    class MySQLDatabase(Database):
        def connect(self):
            print("Connecting to MySQL")

        def save_user(self, user):
            print(f"Saving {user} to MySQL")

    class PostgreSQLDatabase(Database):
        def connect(self):
            print("Connecting to PostgreSQL")

        def save_user(self, user):
            print(f"Saving {user} to PostgreSQL")

    class MongoDBDatabase(Database):
        def connect(self):
            print("Connecting to MongoDB")

        def save_user(self, user):
            print(f"Saving {user} to MongoDB")

    # High-level module depends on abstraction
    class UserService:
        def __init__(self, database: Database):  # Inject dependency!
            self.database = database

        def create_user(self, name):
            self.database.connect()
            user = f"User: {name}"
            self.database.save_user(user)

    # Usage: Easy to swap implementations
    service1 = UserService(MySQLDatabase())
    service1.create_user("Alice")

    service2 = UserService(PostgreSQLDatabase())
    service2.create_user("Bob")

    service3 = UserService(MongoDBDatabase())
    service3.create_user("Charlie")
    ```

    **Benefits:**
    - Loose coupling
    - Easy to test (inject mock database)
    - Easy to switch implementations
    - Follows Dependency Injection pattern

    ---

    ## Real-World Violation and Fix

    ### E-Commerce System Example

    #### ❌ BEFORE (Violates Multiple SOLID Principles)

    ```python
    class Order:
        def __init__(self, items):
            self.items = items
            self.total = 0

        # Violates SRP: Too many responsibilities
        def calculate_total(self):
            self.total = sum(item['price'] * item['quantity'] for item in self.items)
            return self.total

        def apply_discount(self, discount_code):
            if discount_code == 'SUMMER10':
                self.total *= 0.9
            elif discount_code == 'WINTER20':
                self.total *= 0.8
            # Violates OCP: Must modify for new discount codes

        def process_payment(self, payment_type):
            if payment_type == 'credit_card':
                print(f"Processing credit card: ${self.total}")
            elif payment_type == 'paypal':
                print(f"Processing PayPal: ${self.total}")
            # Violates OCP and DIP: Depends on concrete payment types

        def save_to_database(self):
            # Violates SRP and DIP: Direct database dependency
            import mysql.connector
            db = mysql.connector.connect(host="localhost", user="root")
            cursor = db.cursor()
            cursor.execute(f"INSERT INTO orders VALUES ({self.total})")

        def send_confirmation_email(self):
            # Violates SRP: Order shouldn't know about emails
            print(f"Sending email: Order total ${self.total}")
    ```

    #### ✅ AFTER (Follows SOLID Principles)

    ```python
    from abc import ABC, abstractmethod

    # Order only handles order data (SRP)
    class Order:
        def __init__(self, items):
            self.items = items
            self.subtotal = self._calculate_subtotal()

        def _calculate_subtotal(self):
            return sum(item['price'] * item['quantity'] for item in self.items)

    # Discount strategy (OCP)
    class DiscountStrategy(ABC):
        @abstractmethod
        def apply(self, amount):
            pass

    class PercentageDiscount(DiscountStrategy):
        def __init__(self, percentage):
            self.percentage = percentage

        def apply(self, amount):
            return amount * (1 - self.percentage / 100)

    class FixedDiscount(DiscountStrategy):
        def __init__(self, amount):
            self.amount = amount

        def apply(self, amount):
            return amount - self.amount

    # Payment processing (OCP, DIP)
    class PaymentProcessor(ABC):
        @abstractmethod
        def process(self, amount):
            pass

    class CreditCardProcessor(PaymentProcessor):
        def process(self, amount):
            print(f"Processing credit card: ${amount}")

    class PayPalProcessor(PaymentProcessor):
        def process(self, amount):
            print(f"Processing PayPal: ${amount}")

    # Database abstraction (DIP)
    class OrderRepository(ABC):
        @abstractmethod
        def save(self, order, total):
            pass

    class MySQLOrderRepository(OrderRepository):
        def save(self, order, total):
            print(f"Saving order to MySQL: ${total}")

    # Email service (SRP)
    class EmailService:
        def send_order_confirmation(self, order, total):
            print(f"Sending confirmation email: Order total ${total}")

    # Order service coordinates everything
    class OrderService:
        def __init__(self, repository: OrderRepository, email_service: EmailService):
            self.repository = repository
            self.email_service = email_service

        def place_order(self, order: Order, discount: DiscountStrategy,
                       payment_processor: PaymentProcessor):
            # Calculate total with discount
            total = discount.apply(order.subtotal)

            # Process payment
            payment_processor.process(total)

            # Save order
            self.repository.save(order, total)

            # Send email
            self.email_service.send_order_confirmation(order, total)

    # Usage:
    items = [{'price': 100, 'quantity': 2}, {'price': 50, 'quantity': 1}]
    order = Order(items)

    service = OrderService(
        MySQLOrderRepository(),
        EmailService()
    )

    service.place_order(
        order,
        PercentageDiscount(10),
        CreditCardProcessor()
    )
    ```

    **Benefits:**
    - ✅ SRP: Each class has one responsibility
    - ✅ OCP: Easy to add new discounts/payments without modifying existing code
    - ✅ LSP: All strategies/processors are interchangeable
    - ✅ ISP: Focused interfaces
    - ✅ DIP: Depends on abstractions, not concretions

    ---

    ## Summary

    | Principle | Key Idea | Benefit |
    |-----------|----------|---------|
    | **SRP** | One class, one job | Easy to maintain |
    | **OCP** | Open for extension, closed for modification | Add features without risk |
    | **LSP** | Subtypes must be substitutable | Reliable inheritance |
    | **ISP** | Many small interfaces | No unnecessary dependencies |
    | **DIP** | Depend on abstractions | Loose coupling, testability |

    **Next**: We'll explore creational design patterns that help you create objects in flexible ways.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 10 microlessons for Solid Principles"
