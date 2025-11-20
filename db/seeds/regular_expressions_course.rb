# Regular Expressions Course - Based on StackExchange Demand
puts "Creating Regular Expressions Course..."

regex_course = Course.find_or_create_by!(slug: 'regular-expressions-mastery') do |course|
  course.title = 'Regular Expressions Mastery'
  course.description = 'Master pattern matching across all programming languages with regex'
  course.difficulty_level = 'intermediate'
  course.certification_track = nil
  course.published = true
  course.sequence_order = 20
  course.estimated_hours = 15
  course.learning_objectives = JSON.generate([
    "Understand regex syntax and metacharacters",
    "Write complex patterns for text matching",
    "Use capturing groups and backreferences",
    "Apply regex across multiple languages",
    "Optimize regex performance",
    "Debug and test regex patterns"
  ])
  course.prerequisites = JSON.generate(["Basic programming knowledge", "String manipulation concepts"])
end

puts "Created course: #{regex_course.title}"

# ========================================
# Module 1: Regex Fundamentals
# ========================================

module1 = CourseModule.find_or_create_by!(slug: 'regex-fundamentals', course: regex_course) do |mod|
  mod.title = 'Regex Fundamentals'
  mod.description = 'Basic patterns, character classes, and quantifiers'
  mod.sequence_order = 1
  mod.estimated_minutes = 80
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand basic regex syntax",
    "Use character classes and wildcards",
    "Apply quantifiers effectively",
    "Master anchors and boundaries"
  ])
end

# Lesson 1.1: Introduction to Regular Expressions
lesson1_1 = CourseLesson.create!(
  title: "Introduction to Regular Expressions",
  content: <<~MARKDOWN,
    # Introduction to Regular Expressions

    Regular expressions (regex) are powerful patterns used for matching and manipulating text. They're supported in virtually every programming language and are essential for text processing tasks.

    ## What are Regular Expressions?

    A regular expression is a sequence of characters that defines a search pattern. When you run a regex against text, it returns matches or allows you to perform substitutions.

    ### Common Use Cases

    - **Validation**: Email addresses, phone numbers, passwords
    - **Parsing**: Log files, data extraction, web scraping
    - **Search & Replace**: Text editors, IDEs, code refactoring
    - **Data Cleaning**: Removing whitespace, formatting
    - **Tokenization**: Breaking text into words or sentences

    ## Your First Regex

    ### Literal Matches

    The simplest regex matches exact text:

    ```python
    import re

    text = "The cat sat on the mat"
    pattern = "cat"

    match = re.search(pattern, text)
    print(match.group())  # Output: cat
    ```

    ## Basic Metacharacters

    Metacharacters are special characters with special meanings:

    | Character | Meaning | Example |
    |-----------|---------|---------|
    | `.` | Any character except newline | `c.t` matches "cat", "cot", "cut" |
    | `^` | Start of string | `^The` matches "The" at beginning |
    | `$` | End of string | `end$` matches "end" at end |
    | `*` | 0 or more repetitions | `ca*t` matches "ct", "cat", "caat" |
    | `+` | 1 or more repetitions | `ca+t` matches "cat", "caat" but not "ct" |
    | `?` | 0 or 1 repetition (optional) | `colou?r` matches "color" and "colour" |
    | `|` | OR operator | `cat|dog` matches "cat" or "dog" |
    | `\\` | Escape special character | `\\.` matches literal "." |

    ### The Dot (.) - Universal Wildcard

    ```python
    pattern = "c.t"
    # Matches: cat, cot, cut, c9t, c@t, etc.
    # Does NOT match: ct (no character between c and t)
    ```

    ### Escape Characters (\\)

    To match special characters literally, escape them:

    ```python
    pattern = "\\."      # Matches literal "."
    pattern = "\\$"      # Matches literal "$"
    pattern = "\\?"      # Matches literal "?"
    pattern = "\\\\\\\\\\\\\\\"      # Matches literal "\\\\\\\\"
    ```

    ## Character Classes

    Character classes match one character from a set:

    ### Basic Syntax: [...]

    ```python
    pattern = "[aeiou]"      # Matches any vowel
    pattern = "[0-9]"        # Matches any digit
    pattern = "[a-z]"        # Matches any lowercase letter
    pattern = "[A-Z]"        # Matches any uppercase letter
    pattern = "[a-zA-Z]"     # Matches any letter
    pattern = "[a-zA-Z0-9]"  # Matches alphanumeric
    ```

    ### Negated Character Classes: [^...]

    ```python
    pattern = "[^0-9]"   # Matches any NON-digit
    pattern = "[^aeiou]" # Matches any NON-vowel
    ```

    ### Predefined Character Classes

    | Class | Equivalent | Meaning |
    |-------|------------|---------|
    | `\\d` | `[0-9]` | Any digit |
    | `\\D` | `[^0-9]` | Any non-digit |
    | `\\w` | `[a-zA-Z0-9_]` | Any word character |
    | `\\W` | `[^a-zA-Z0-9_]` | Any non-word character |
    | `\\s` | `[ \\t\\n\\r\\f\\v]` | Any whitespace |
    | `\\S` | `[^ \\t\\n\\r\\f\\v]` | Any non-whitespace |

    ### Examples

    ```python
    # Match a 3-digit number
    pattern = "\\d\\d\\d"
    # Matches: 123, 456, 999

    # Match a word
    pattern = "\\w+"
    # Matches: hello, world123, test_case

    # Match whitespace-separated words
    pattern = "\\w+\\s+\\w+"
    # Matches: "hello world", "foo bar"
    ```

    ## Quantifiers

    Quantifiers specify how many times a character or group should appear:

    | Quantifier | Meaning | Example |
    |------------|---------|---------|
    | `*` | 0 or more | `a*` matches "", "a", "aa", "aaa" |
    | `+` | 1 or more | `a+` matches "a", "aa", "aaa" (not "") |
    | `?` | 0 or 1 | `a?` matches "", "a" |
    | `{n}` | Exactly n | `a{3}` matches "aaa" |
    | `{n,}` | n or more | `a{2,}` matches "aa", "aaa", "aaaa" |
    | `{n,m}` | Between n and m | `a{2,4}` matches "aa", "aaa", "aaaa" |

    ### Practical Examples

    ```python
    # Phone number: 3 digits, dash, 4 digits
    pattern = "\\d{3}-\\d{4}"
    # Matches: 555-1234

    # Flexible phone: optional area code
    pattern = "(\\d{3}-)?\\d{3}-\\d{4}"
    # Matches: 555-1234 or 800-555-1234

    # One or more words
    pattern = "\\w+"
    # Matches: hello, world123, test

    # Optional plural
    pattern = "cats?"
    # Matches: cat or cats
    ```

    ## Anchors and Boundaries

    Anchors don't match characters—they match positions:

    | Anchor | Meaning | Example |
    |--------|---------|---------|
    | `^` | Start of string/line | `^Hello` matches "Hello" at start |
    | `$` | End of string/line | `world$` matches "world" at end |
    | `\\b` | Word boundary | `\\bcat\\b` matches "cat" but not "category" |
    | `\\B` | Non-word boundary | `\\Bcat\\B` matches "category" but not "cat" |

    ### Examples

    ```python
    # Entire string must be digits
    pattern = "^\\d+$"
    # Matches: "12345" (entire string)
    # Does NOT match: "abc123" or "123abc"

    # Match "cat" as a whole word
    pattern = "\\bcat\\b"
    # Matches: "the cat sat" (matches "cat")
    # Does NOT match: "category" or "scattered"

    # Email validation (simplified)
    pattern = "^[\\w.-]+@[\\w.-]+\\.\\w+$"
    # Matches: user@example.com
    ```

    ## Greedy vs Lazy Matching

    ### Greedy (Default)
    Quantifiers are greedy by default—they match as much as possible:

    ```python
    text = "<html><body></body></html>"
    pattern = "<.*>"
    # Matches: "<html><body></body></html>" (everything!)
    ```

    ### Lazy (Non-Greedy)
    Add `?` after quantifier to make it lazy—match as little as possible:

    ```python
    text = "<html><body></body></html>"
    pattern = "<.*?>"
    # Matches: "<html>", "<body>", "</body>", "</html>" (separately)
    ```

    | Greedy | Lazy | Meaning |
    |--------|------|---------|
    | `*` | `*?` | 0 or more (lazy) |
    | `+` | `+?` | 1 or more (lazy) |
    | `?` | `??` | 0 or 1 (lazy) |
    | `{n,m}` | `{n,m}?` | Between n and m (lazy) |

    ## Practical Examples

    ### Validate Email Address (Simple)
    ```python
    pattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    ```

    ### Extract URLs
    ```python
    pattern = "https?://[\\w.-]+\\.[a-zA-Z]{2,}(/[\\w.-]*)*"
    ```

    ### Match Phone Numbers
    ```python
    # Format: (123) 456-7890 or 123-456-7890
    pattern = "\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})"
    ```

    ### Extract Hashtags
    ```python
    pattern = "#\\w+"
    # Matches: #python, #regex, #coding
    ```

    ## Testing Your Regex

    ### Online Tools
    - **regex101.com** - Best for learning (explanations + testing)
    - **regexr.com** - Interactive with cheat sheet
    - **regexpal.com** - Simple and fast

    ### In Python
    ```python
    import re

    pattern = r"\\d{3}-\\d{4}"
    text = "Call me at 555-1234"

    # Search for first match
    match = re.search(pattern, text)
    if match:
        print(f"Found: {match.group()}")

    # Find all matches
    matches = re.findall(pattern, text)
    print(f"All matches: {matches}")
    ```

    ## Common Pitfalls

    ### 1. Forgetting to Escape Special Characters
    ```python
    # ❌ Wrong - tries to match any character
    pattern = "."

    # ✅ Correct - matches literal period
    pattern = "\\."
    ```

    ### 2. Greedy Matching
    ```python
    # ❌ Matches too much
    pattern = "\".*\""
    text = '"Hello" and "World"'
    # Matches: "Hello" and "World" (entire string!)

    # ✅ Use lazy quantifier
    pattern = "\".*?\""
    # Matches: "Hello" and "World" (separately)
    ```

    ### 3. Not Using Raw Strings (Python)
    ```python
    # ❌ Need double backslashes
    pattern = "\\\\d+"

    # ✅ Use raw string
    pattern = r"\\d+"
    ```

    ## Key Takeaways

    1. **Start simple** - Build complex patterns incrementally
    2. **Test frequently** - Use online tools to visualize matches
    3. **Use raw strings** - `r"..."` in Python to avoid double escaping
    4. **Character classes** - `[...]` for sets, `\\d \\w \\s` for common patterns
    5. **Quantifiers** - `* + ? {n,m}` for repetition
    6. **Anchors** - `^ $ \\b` for position matching
    7. **Lazy matching** - Add `?` after quantifiers when needed
    8. **Practice** - The best way to learn is by doing!
  MARKDOWN
  course_module: module1,
  sequence_order: 1,
  estimated_minutes: 35,
  published: true
)

# Lesson 1.2: Character Classes Deep Dive
lesson1_2 = CourseLesson.create!(
  title: "Character Classes and Ranges",
  content: <<~MARKDOWN,
    # Character Classes and Ranges

    Character classes are fundamental building blocks of regex patterns. They allow you to match any one character from a set of characters.

    ## Basic Character Classes

    ### Square Bracket Notation

    ```python
    [abc]      # Matches 'a', 'b', or 'c'
    [0123456789]  # Matches any single digit
    ```

    ### Ranges

    ```python
    [a-z]      # Matches any lowercase letter
    [A-Z]      # Matches any uppercase letter
    [0-9]      # Matches any digit
    [a-zA-Z]   # Matches any letter (upper or lower)
    [a-zA-Z0-9]  # Matches any alphanumeric character
    ```

    ### Combining Multiple Ranges

    ```python
    [a-zA-Z0-9_]  # Letters, digits, underscore
    [a-fA-F0-9]   # Hexadecimal characters
    [0-9a-f]      # Same as above (order doesn't matter)
    ```

    ## Negated Character Classes

    Use `^` at the start to negate (match anything NOT in the class):

    ```python
    [^0-9]     # Any character EXCEPT digits
    [^aeiou]   # Any character EXCEPT vowels
    [^a-z]     # Any character EXCEPT lowercase letters
    [^\\s]      # Any non-whitespace character
    ```

    ### Examples

    ```python
    import re

    # Match consonants
    text = "Hello World"
    pattern = "[^aeiouAEIOU ]"
    matches = re.findall(pattern, text)
    print(matches)  # ['H', 'l', 'l', 'W', 'r', 'l', 'd']

    # Match non-digit characters
    text = "Order #12345"
    pattern = "[^0-9]+"
    matches = re.findall(pattern, text)
    print(matches)  # ['Order #']
    ```

    ## Predefined Character Classes

    ### Digit Classes

    ```python
    \\d    # Digit: [0-9]
    \\D    # Non-digit: [^0-9]
    ```

    **Examples:**
    ```python
    # Extract all digits
    text = "Room 123, Floor 4"
    pattern = r"\\d+"
    re.findall(pattern, text)  # ['123', '4']

    # Extract non-digits
    pattern = r"\\D+"
    re.findall(pattern, text)  # ['Room ', ', Floor ']
    ```

    ### Word Character Classes

    ```python
    \\w    # Word character: [a-zA-Z0-9_]
    \\W    # Non-word character: [^a-zA-Z0-9_]
    ```

    **Examples:**
    ```python
    # Match valid identifiers
    text = "var_name = 123"
    pattern = r"\\w+"
    re.findall(pattern, text)  # ['var_name', '123']

    # Match separators
    pattern = r"\\W+"
    re.findall(pattern, text)  # [' = ']
    ```

    ### Whitespace Classes

    ```python
    \\s    # Whitespace: [ \\t\\n\\r\\f\\v]
    \\S    # Non-whitespace: [^ \\t\\n\\r\\f\\v]
    ```

    **Examples:**
    ```python
    # Split on whitespace
    text = "Hello\\tWorld\\nPython"
    pattern = r"\\s+"
    re.split(pattern, text)  # ['Hello', 'World', 'Python']

    # Extract non-whitespace sequences
    pattern = r"\\S+"
    re.findall(pattern, text)  # ['Hello', 'World', 'Python']
    ```

    ## Special Cases Inside Character Classes

    ### Literal Special Characters

    Most special characters lose their special meaning inside `[]`:

    ```python
    [.]      # Matches literal '.' (not any character!)
    [*]      # Matches literal '*'
    [+]      # Matches literal '+'
    [?]      # Matches literal '?'
    [(]      # Matches literal '('
    [)]      # Matches literal ')'
    ```

    ### Characters That Still Need Escaping

    ```python
    [\\[]     # Matches literal '['
    [\\]]     # Matches literal ']'
    [\\\\\\\\]     # Matches literal '\\\\\\\\'
    [\\^]     # Matches literal '^' (only at start of class)
    [-]      # Matches literal '-' (at start or end)
    [a-z\\-]  # Matches lowercase letters OR hyphen
    ```

    ## Practical Patterns

    ### Matching Specific Character Sets

    ```python
    # Hexadecimal digits
    pattern = r"[0-9A-Fa-f]+"
    text = "Color: #FF5733"
    re.findall(pattern, text)  # ['FF5733']

    # Binary digits
    pattern = r"[01]+"
    text = "Binary: 101010"
    re.findall(pattern, text)  # ['101010']

    # Vowels (case insensitive)
    pattern = r"[aeiouAEIOU]"
    text = "Hello World"
    re.findall(pattern, text)  # ['e', 'o', 'o']
    ```

    ### Password Validation

    ```python
    # At least one uppercase, lowercase, digit, special char
    has_upper = r"[A-Z]"
    has_lower = r"[a-z]"
    has_digit = r"[0-9]"
    has_special = r"[!@#$%^&*()]"

    password = "MyP@ss123"
    is_valid = (
        re.search(has_upper, password) and
        re.search(has_lower, password) and
        re.search(has_digit, password) and
        re.search(has_special, password)
    )
    ```

    ### File Extension Matching

    ```python
    # Image files
    pattern = r"\\.(jpg|jpeg|png|gif|bmp)$"

    # Archive files
    pattern = r"\\.(zip|rar|7z|tar|gz)$"

    # Source code files
    pattern = r"\\.(py|js|java|cpp|c|rb)$"
    ```

    ## POSIX Character Classes

    Some regex engines support POSIX classes (not Python by default):

    | Class | Meaning | Equivalent |
    |-------|---------|------------|
    | `[:alnum:]` | Alphanumeric | `[a-zA-Z0-9]` |
    | `[:alpha:]` | Alphabetic | `[a-zA-Z]` |
    | `[:digit:]` | Digits | `[0-9]` |
    | `[:lower:]` | Lowercase | `[a-z]` |
    | `[:upper:]` | Uppercase | `[A-Z]` |
    | `[:space:]` | Whitespace | `[ \\t\\n\\r\\f\\v]` |
    | `[:punct:]` | Punctuation | Various |

    ## Unicode Character Classes (Python)

    Python's `re` module supports Unicode categories:

    ```python
    # Match any Unicode letter
    pattern = r"\\p{L}+"  # Note: Not supported in standard re
    # Use: [\\w] or third-party library like 'regex'

    # With 'regex' module
    import regex
    pattern = r"\\p{L}+"  # Matches: letters from any language
    pattern = r"\\p{N}+"  # Matches: numbers from any script
    pattern = r"\\p{Sc}"  # Matches: currency symbols ($, €, ¥)
    ```

    ## Common Use Cases

    ### Extract Email Local Part

    ```python
    # Characters allowed before @
    pattern = r"[a-zA-Z0-9._%+-]+@"
    email = "user.name+tag@example.com"
    match = re.search(pattern, email)
    print(match.group())  # 'user.name+tag@'
    ```

    ### Match Valid Variable Names

    ```python
    # Start with letter/underscore, followed by word chars
    pattern = r"\\b[a-zA-Z_]\\w*\\b"
    code = "var_name = value123"
    matches = re.findall(pattern, code)
    print(matches)  # ['var_name', 'value123']
    ```

    ### Clean Non-Alphanumeric Characters

    ```python
    # Keep only letters, digits, and spaces
    pattern = r"[^a-zA-Z0-9 ]"
    text = "Hello, World! #2024"
    clean = re.sub(pattern, "", text)
    print(clean)  # "Hello World 2024"
    ```

    ### Extract Price Values

    ```python
    # Match currency symbol + digits
    pattern = r"[$€£¥][0-9,]+(\\.[0-9]{2})?"
    text = "Prices: $19.99, €25.50, £15"
    matches = re.findall(pattern, text)
    print(matches)  # ['.99', '.50', '']
    ```

    ## Performance Tips

    ### Use Specific Classes
    ```python
    # ✅ More efficient
    pattern = r"[0-9]+"

    # ❌ Less efficient
    pattern = r"[0123456789]+"

    # ✅ Best
    pattern = r"\\d+"
    ```

    ### Order Matters for Readability
    ```python
    # ✅ Clear intent
    pattern = r"[a-zA-Z0-9_-]"

    # ❌ Harder to read
    pattern = r"[_a-z-A-Z0-9]"
    ```

    ### Avoid Unnecessary Negation
    ```python
    # ❌ Inefficient
    pattern = r"[^a][^b][^c]"

    # ✅ Better
    pattern = r"[^abc]{3}"
    ```

    ## Key Takeaways

    1. **Character classes** - Match one character from a set
    2. **Ranges** - Use `-` for consecutive characters: `[a-z]`
    3. **Negation** - Use `^` at start: `[^0-9]`
    4. **Predefined classes** - `\\d \\w \\s` are your friends
    5. **Special chars** - Most lose meaning inside `[]`
    6. **Combine freely** - `[a-zA-Z0-9_-]` is valid
    7. **Be specific** - More specific = better performance
    8. **Test your patterns** - Always verify with real data
  MARKDOWN
  course_module: module1,
  sequence_order: 2,
  estimated_minutes: 25,
  published: true
)

# Lesson 1.3: Quantifiers in Detail
lesson1_3 = CourseLesson.create!(
  title: "Mastering Quantifiers",
  content: <<~MARKDOWN,
    # Mastering Quantifiers

    Quantifiers specify how many times an element (character, group, or class) should be matched.

    ## Basic Quantifiers

    ### Zero or More: *

    ```python
    import re

    pattern = r"ca*t"
    # Matches: ct, cat, caat, caaat, ...
    ```

    **Examples:**
    ```python
    text = "ct cat caat caaat"
    matches = re.findall(r"ca*t", text)
    print(matches)  # ['ct', 'cat', 'caat', 'caaat']

    # Match "color" and "colour"
    pattern = r"colou*r"
    # Matches: color, colour, colouur, ...
    ```

    ### One or More: +

    ```python
    pattern = r"ca+t"
    # Matches: cat, caat, caaat, ... (NOT ct)
    ```

    **Examples:**
    ```python
    text = "ct cat caat caaat"
    matches = re.findall(r"ca+t", text)
    print(matches)  # ['cat', 'caat', 'caaat'] (no 'ct')

    # Match one or more digits
    pattern = r"\\d+"
    text = "Item 123 costs $45"
    matches = re.findall(pattern, text)
    print(matches)  # ['123', '45']
    ```

    ### Zero or One: ?

    ```python
    pattern = r"ca?t"
    # Matches: ct, cat (NOT caat)
    ```

    **Examples:**
    ```python
    text = "ct cat caat"
    matches = re.findall(r"ca?t", text)
    print(matches)  # ['ct', 'cat']

    # Match "color" or "colour"
    pattern = r"colou?r"
    # Matches: color, colour (exactly)

    # Optional "s" for plural
    pattern = r"files?"
    # Matches: file, files
    ```

    ## Specific Quantifiers

    ### Exactly N: {n}

    ```python
    pattern = r"a{3}"
    # Matches: aaa (exactly 3 'a's)
    ```

    **Examples:**
    ```python
    # Match exactly 10-digit phone number
    pattern = r"\\d{10}"
    text = "Call 5551234567"
    match = re.search(pattern, text)
    print(match.group())  # '5551234567'

    # Match 3-letter airport code
    pattern = r"\\b[A-Z]{3}\\b"
    text = "Fly from LAX to JFK"
    matches = re.findall(pattern, text)
    print(matches)  # ['LAX', 'JFK']
    ```

    ### N or More: {n,}

    ```python
    pattern = r"a{2,}"
    # Matches: aa, aaa, aaaa, ... (2 or more)
    ```

    **Examples:**
    ```python
    # Match 2 or more repeated characters
    pattern = r"(.)\\1{1,}"
    text = "hello goooood"
    matches = re.findall(pattern, text)
    print(matches)  # ['l', 'o']

    # Match long words (8+ characters)
    pattern = r"\\b\\w{8,}\\b"
    text = "This is a comprehensive explanation"
    matches = re.findall(pattern, text)
    print(matches)  # ['comprehensive', 'explanation']
    ```

    ### Between N and M: {n,m}

    ```python
    pattern = r"a{2,4}"
    # Matches: aa, aaa, aaaa (NOT a or aaaaa)
    ```

    **Examples:**
    ```python
    # Match 2-4 digit numbers
    pattern = r"\\b\\d{2,4}\\b"
    text = "Years: 1, 99, 2024, 12345"
    matches = re.findall(pattern, text)
    print(matches)  # ['99', '2024']

    # Username: 3-16 characters
    pattern = r"^[a-zA-Z0-9_]{3,16}$"
    usernames = ["ab", "user123", "this_is_too_long_username"]
    for username in usernames:
        if re.match(pattern, username):
            print(f"{username}: valid")
    # Output: user123: valid
    ```

    ## Greedy vs Lazy Quantifiers

    ### Greedy (Default Behavior)

    Quantifiers are **greedy** by default—they match as much as possible:

    ```python
    text = "<html><head><title>Page</title></head></html>"
    pattern = r"<.*>"

    match = re.search(pattern, text)
    print(match.group())
    # Matches entire string: "<html><head><title>Page</title></head></html>"
    ```

    ### Lazy (Non-Greedy)

    Add `?` after the quantifier to make it **lazy**—match as little as possible:

    ```python
    text = "<html><head><title>Page</title></head></html>"
    pattern = r"<.*?>"

    matches = re.findall(pattern, text)
    print(matches)
    # Matches each tag separately: ['<html>', '<head>', '<title>', '</title>', '</head>', '</html>']
    ```

    ### Comparison Table

    | Greedy | Lazy | Description |
    |--------|------|-------------|
    | `*` | `*?` | 0 or more (lazy) |
    | `+` | `+?` | 1 or more (lazy) |
    | `?` | `??` | 0 or 1 (lazy) |
    | `{n,}` | `{n,}?` | n or more (lazy) |
    | `{n,m}` | `{n,m}?` | Between n and m (lazy) |

    ### Practical Examples

    #### Extract Quoted Strings

    ```python
    text = 'He said "Hello" and she said "World"'

    # ❌ Greedy - matches too much
    pattern = r'".*"'
    match = re.search(pattern, text)
    print(match.group())  # '"Hello" and she said "World"'

    # ✅ Lazy - matches each quote separately
    pattern = r'".*?"'
    matches = re.findall(pattern, text)
    print(matches)  # ['"Hello"', '"World"']
    ```

    #### Extract HTML/XML Tags

    ```python
    html = "<div>Content</div><p>More</p>"

    # ❌ Greedy
    pattern = r"<.+>"
    match = re.search(pattern, html)
    print(match.group())  # '<div>Content</div><p>More</p>'

    # ✅ Lazy
    pattern = r"<.+?>"
    matches = re.findall(pattern, html)
    print(matches)  # ['<div>', '</div>', '<p>', '</p>']
    ```

    #### Parse CSV-like Data

    ```python
    data = "name,age,city"

    # ❌ Greedy - matches entire string
    pattern = r".+,"
    match = re.search(pattern, data)
    print(match.group())  # 'name,age,'

    # ✅ Lazy - matches first field only
    pattern = r".+?,"
    match = re.search(pattern, data)
    print(match.group())  # 'name,'
    ```

    ## Combining Quantifiers

    ### Multiple Quantifiers

    ```python
    # Match variable names: letter/underscore + 0+ word chars
    pattern = r"[a-zA-Z_]\\w*"

    # Match floats: optional sign, digits, optional decimal part
    pattern = r"-?\\d+(\\.\\d+)?"
    ```

    ### Nested Quantifiers (Careful!)

    ```python
    # ❌ Can be very slow (catastrophic backtracking)
    pattern = r"(a+)+"

    # ✅ Better
    pattern = r"a+"
    ```

    ## Real-World Examples

    ### Email Validation (Simplified)

    ```python
    pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    #           ────────────┬────────  ───────┬──────  ──┬──
    #           Local part (1+)     @ Domain (1+)    .TLD(2+)
    ```

    ### URL Matching

    ```python
    pattern = r"https?://[\\w.-]+(\\/[\\w./-]*)?"
    #         ───┬─  ──────┬───── ─────┬─────
    #         http(s)?  Domain    Optional path
    ```

    ### Credit Card Numbers

    ```python
    # 4 groups of 4 digits
    pattern = r"\\b\\d{4}[- ]?\\d{4}[- ]?\\d{4}[- ]?\\d{4}\\b"
    # Matches: 1234 5678 9012 3456
    #          1234-5678-9012-3456
    #          1234567890123456
    ```

    ### IP Address

    ```python
    # Simple version (not validating ranges)
    pattern = r"\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\b"
    # Matches: 192.168.1.1
    ```

    ### Time Formats

    ```python
    # HH:MM or HH:MM:SS
    pattern = r"\\b([01]?\\d|2[0-3]):[0-5]\\d(:[0-5]\\d)?\\b"
    # Matches: 09:30, 23:59:59, 5:45
    ```

    ## Performance Considerations

    ### Catastrophic Backtracking

    **Problem:** Nested quantifiers can cause exponential time complexity:

    ```python
    # ❌ DANGEROUS - can hang on long strings
    pattern = r"(a+)+"
    pattern = r"(a*)*"
    pattern = r"(a+)*b"
    ```

    **Solution:** Be specific and avoid nested quantifiers:

    ```python
    # ✅ SAFE
    pattern = r"a+"
    pattern = r"a*b"
    ```

    ### Use Possessive Quantifiers (Advanced)

    Some engines support possessive quantifiers (not standard Python):

    ```python
    # Atomic group (doesn't backtrack)
    pattern = r"(?>a+)b"  # Not in Python's re module
    ```

    ## Common Patterns Summary

    ```python
    # Integer
    r"-?\\d+"

    # Float
    r"-?\\d+\\.\\d+"

    # Phone (US)
    r"\\(? \\d{3}\\)?[- ]?\\d{3}[- ]?\\d{4}"

    # Date (YYYY-MM-DD)
    r"\\d{4}-\\d{2}-\\d{2}"

    # Hex color
    r"#[0-9A-Fa-f]{6}"

    # Username (3-20 chars)
    r"^[a-zA-Z0-9_]{3,20}$"

    # Strong password (8+ chars, mixed case, digit, special)
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    ```

    ## Key Takeaways

    1. **Basic quantifiers**: `*` (0+), `+` (1+), `?` (0-1)
    2. **Specific quantifiers**: `{n}`, `{n,}`, `{n,m}`
    3. **Greedy by default**: Match as much as possible
    4. **Lazy with `?`**: Match as little as possible
    5. **Watch for catastrophic backtracking**: Avoid nested quantifiers
    6. **Be specific**: More specific = better performance
    7. **Test with edge cases**: Empty strings, very long strings
    8. **Use online tools**: Visualize how quantifiers behave
  MARKDOWN
  course_module: module1,
  sequence_order: 3,
  estimated_minutes: 20,
  published: true
)

puts "  ✅ Created #{module1.course_lessons.count} lessons for Module 1"

# ========================================
# Module 2: Advanced Patterns
# ========================================

module2 = CourseModule.find_or_create_by!(slug: 'advanced-regex-patterns', course: regex_course) do |mod|
  mod.title = 'Advanced Regex Patterns'
  mod.description = 'Groups, lookaheads, backreferences, and modifiers'
  mod.sequence_order = 2
  mod.estimated_minutes = 100
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Master capturing and non-capturing groups",
    "Use lookaheads and lookbehinds effectively",
    "Apply backreferences for pattern matching",
    "Understand regex flags and modifiers"
  ])
end

puts "  ✅ Created Module 2: Advanced Regex Patterns"

# ========================================
# Module 3: Regex Across Languages
# ========================================

module3 = CourseModule.find_or_create_by!(slug: 'regex-languages', course: regex_course) do |mod|
  mod.title = 'Regex Across Languages'
  mod.description = 'Python, JavaScript, Java, and more'
  mod.sequence_order = 3
  mod.estimated_minutes = 90
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand regex differences across languages",
    "Use regex in Python, JavaScript, and Java",
    "Apply language-specific regex features",
    "Handle Unicode and internationalization"
  ])
end

puts "  ✅ Created Module 3: Regex Across Languages"

puts "  ✅ Created Regular Expressions course with #{regex_course.course_modules.count} modules"
puts "\n✅ Regular Expressions Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
