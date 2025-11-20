# Bash/Shell Scripting Course - Based on StackExchange Demand
puts "Creating Bash/Shell Scripting Course..."

bash_course = Course.find_or_create_by!(slug: 'bash-shell-scripting') do |course|
  course.title = 'Bash/Shell Scripting Mastery'
  course.description = 'Master command-line automation and shell scripting'
  course.difficulty_level = 'intermediate'
  course.certification_track = nil
  course.published = true
  course.sequence_order = 21
  course.estimated_hours = 22
  course.learning_objectives = JSON.generate([
    "Master Bash fundamentals and syntax",
    "Write robust shell scripts",
    "Use pipes, redirects, and process substitution",
    "Handle errors and edge cases",
    "Automate system administration tasks",
    "Apply shell scripting best practices"
  ])
  course.prerequisites = JSON.generate(["Basic Linux/Unix knowledge", "Command-line familiarity"])
end

puts "Created course: #{bash_course.title}"

# ========================================
# Module 1: Bash Basics
# ========================================

module1 = CourseModule.find_or_create_by!(slug: 'bash-basics', course: bash_course) do |mod|
  mod.title = 'Bash Basics'
  mod.description = 'Commands, variables, and basic syntax'
  mod.sequence_order = 1
  mod.estimated_minutes = 100
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand Bash fundamentals",
    "Work with variables and parameters",
    "Use command-line tools effectively",
    "Master basic shell operations"
  ])
end

# Lesson 1.1: Introduction to Bash
lesson1_1 = CourseLesson.create!(
  title: "Introduction to Bash and Shell Scripting",
  content: <<~MARKDOWN,
    # Introduction to Bash and Shell Scripting

    Bash (Bourne Again Shell) is the default shell on most Linux and macOS systems. It's both a command-line interface and a powerful scripting language.

    ## What is a Shell?

    A **shell** is a program that:
    - Provides an interface between the user and the operating system
    - Interprets commands typed by the user
    - Executes programs and scripts
    - Manages input/output redirection

    ### Types of Shells

    | Shell | Description |
    |-------|-------------|
    | **sh** | Bourne Shell (original) |
    | **bash** | Bourne Again Shell (most popular) |
    | **zsh** | Z Shell (macOS default since Catalina) |
    | **fish** | Friendly Interactive Shell |
    | **ksh** | Korn Shell |
    | **csh/tcsh** | C Shell / TENEX C Shell |

    ## Why Learn Bash?

    ### 1. Automation
    - Automate repetitive tasks
    - Schedule jobs with cron
    - Batch process files
    - System maintenance scripts

    ### 2. System Administration
    - Manage users and permissions
    - Monitor system resources
    - Configure services
    - Deploy applications

    ### 3. DevOps & CI/CD
    - Build and deployment scripts
    - Infrastructure automation
    - Docker and Kubernetes workflows
    - Git hooks

    ### 4. Data Processing
    - Parse log files
    - Transform text data
    - ETL pipelines
    - Report generation

    ## Your First Shell Script

    ### Hello World

    Create a file named `hello.sh`:

    ```bash
    #!/bin/bash
    # My first shell script

    echo "Hello, World!"
    ```

    ### Make it Executable

    ```bash
    chmod +x hello.sh
    ```

    ### Run it

    ```bash
    ./hello.sh
    # Output: Hello, World!
    ```

    ## The Shebang (#!)

    The first line `#!/bin/bash` is called the **shebang**:

    ```bash
    #!/bin/bash         # Use bash
    #!/bin/sh           # Use sh (POSIX shell)
    #!/usr/bin/env bash # Use bash from PATH (portable)
    #!/usr/bin/python3  # Use Python 3
    ```

    **Best Practice:** Use `#!/usr/bin/env bash` for portability.

    ## Basic Commands

    ### Navigation

    ```bash
    pwd          # Print working directory
    cd /path     # Change directory
    cd ~         # Go to home directory
    cd -         # Go to previous directory
    ls           # List files
    ls -la       # List all files (long format, including hidden)
    ```

    ### File Operations

    ```bash
    touch file.txt       # Create empty file
    mkdir directory      # Create directory
    mkdir -p dir1/dir2   # Create nested directories
    cp file1 file2       # Copy file
    cp -r dir1 dir2      # Copy directory recursively
    mv file1 file2       # Move/rename file
    rm file.txt          # Remove file
    rm -r directory      # Remove directory recursively
    rm -rf directory     # Force remove (be careful!)
    ```

    ### Viewing Files

    ```bash
    cat file.txt         # Display entire file
    less file.txt        # View file page by page (q to quit)
    head file.txt        # Show first 10 lines
    head -n 5 file.txt   # Show first 5 lines
    tail file.txt        # Show last 10 lines
    tail -n 5 file.txt   # Show last 5 lines
    tail -f log.txt      # Follow file (live updates)
    ```

    ### Searching

    ```bash
    grep "pattern" file.txt          # Search for pattern
    grep -i "pattern" file.txt       # Case-insensitive search
    grep -r "pattern" directory/     # Recursive search
    grep -n "pattern" file.txt       # Show line numbers
    find . -name "*.txt"             # Find files by name
    find . -type f -mtime -7         # Files modified in last 7 days
    ```

    ## Input and Output

    ### Standard Streams

    - **stdin (0)**: Standard input (keyboard)
    - **stdout (1)**: Standard output (terminal)
    - **stderr (2)**: Standard error (terminal)

    ### Output with echo

    ```bash
    echo "Hello"              # Print to stdout
    echo -n "No newline"      # No trailing newline
    echo -e "Line1\\nLine2"   # Enable escape sequences
    ```

    ### Output with printf

    ```bash
    printf "Hello, %s!\\n" "World"      # Formatted output
    printf "%d + %d = %d\\n" 1 2 3      # Integer formatting
    printf "%.2f\\n" 3.14159            # Float with 2 decimals
    ```

    ## Redirection

    ### Output Redirection

    ```bash
    echo "Hello" > file.txt         # Overwrite file
    echo "World" >> file.txt        # Append to file
    command 2> error.log            # Redirect stderr
    command > output.log 2>&1       # Redirect both stdout and stderr
    command &> all.log              # Redirect both (shorthand)
    ```

    ### Input Redirection

    ```bash
    command < input.txt             # Read from file
    cat < file.txt                  # Same as: cat file.txt
    ```

    ### Here Documents

    ```bash
    cat << EOF
    Line 1
    Line 2
    EOF
    # Outputs multiple lines
    ```

    ### Here Strings

    ```bash
    grep "pattern" <<< "string to search"
    ```

    ## Pipes

    Pipes (`|`) connect the output of one command to the input of another:

    ```bash
    ls -la | grep ".txt"               # List only .txt files
    cat file.txt | sort | uniq         # Sort and remove duplicates
    ps aux | grep nginx                # Find nginx processes
    cat access.log | wc -l             # Count lines in file
    ```

    ### Common Pipeline Patterns

    ```bash
    # Count files in directory
    ls | wc -l

    # Top 10 largest files
    du -sh * | sort -rh | head -10

    # Find most common words
    cat file.txt | tr ' ' '\\n' | sort | uniq -c | sort -rn | head -10

    # Monitor log file in real-time
    tail -f /var/log/syslog | grep error
    ```

    ## Command Substitution

    Capture command output in a variable:

    ```bash
    # Modern syntax (preferred)
    current_date=$(date)
    file_count=$(ls | wc -l)

    # Old syntax (backticks)
    current_date=`date`
    file_count=`ls | wc -l`
    ```

    ### Example

    ```bash
    #!/bin/bash
    echo "Current user: $(whoami)"
    echo "Current directory: $(pwd)"
    echo "Number of files: $(ls | wc -l)"
    ```

    ## Exit Status

    Every command returns an **exit status** (0 = success, non-zero = error):

    ```bash
    command
    echo $?  # Print exit status of last command

    # Common exit codes
    # 0   = Success
    # 1   = General error
    # 2   = Misuse of command
    # 126 = Command not executable
    # 127 = Command not found
    # 130 = Ctrl+C pressed
    ```

    ### Using Exit Status

    ```bash
    if ls /nonexistent 2>/dev/null; then
        echo "Directory exists"
    else
        echo "Directory does not exist"
    fi

    # Short-circuit evaluation
    command1 && command2  # Run command2 only if command1 succeeds
    command1 || command2  # Run command2 only if command1 fails
    ```

    ## Common Utilities

    ### Text Processing

    ```bash
    sort file.txt              # Sort lines
    uniq file.txt              # Remove adjacent duplicates
    cut -d: -f1 /etc/passwd    # Extract first field (delimiter :)
    tr 'a-z' 'A-Z'             # Translate lowercase to uppercase
    sed 's/old/new/g' file     # Replace text
    awk '{print $1}' file      # Print first column
    ```

    ### File Information

    ```bash
    wc file.txt                # Count lines, words, bytes
    wc -l file.txt             # Count lines only
    du -sh directory           # Disk usage
    df -h                      # Filesystem disk space
    file document.pdf          # Determine file type
    ```

    ### Process Management

    ```bash
    ps aux                     # List all processes
    top                        # Interactive process viewer
    htop                       # Better alternative to top
    kill <PID>                 # Send SIGTERM to process
    kill -9 <PID>              # Force kill process
    killall process_name       # Kill all matching processes
    ```

    ## Practical Examples

    ### Example 1: Backup Script

    ```bash
    #!/bin/bash
    # Simple backup script

    SOURCE="/home/user/documents"
    DEST="/backup"
    DATE=$(date +%Y-%m-%d)

    tar -czf "$DEST/backup-$DATE.tar.gz" "$SOURCE"
    echo "Backup completed: backup-$DATE.tar.gz"
    ```

    ### Example 2: System Information

    ```bash
    #!/bin/bash
    # Display system information

    echo "=== System Information ==="
    echo "Hostname: $(hostname)"
    echo "OS: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
    echo "Disk Usage:"
    df -h | grep -v tmpfs
    ```

    ### Example 3: Log Analyzer

    ```bash
    #!/bin/bash
    # Analyze nginx access log

    LOG_FILE="/var/log/nginx/access.log"

    echo "Top 10 IP addresses:"
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10

    echo ""
    echo "Top 10 requested URLs:"
    awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10

    echo ""
    echo "HTTP status codes:"
    awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn
    ```

    ## Best Practices

    ### 1. Always Use Shebang

    ```bash
    #!/usr/bin/env bash
    ```

    ### 2. Add Comments

    ```bash
    # This script does something important
    # Author: Your Name
    # Date: 2024-01-01
    ```

    ### 3. Quote Variables

    ```bash
    # ❌ Bad - can break with spaces
    echo $variable

    # ✅ Good
    echo "$variable"
    ```

    ### 4. Use `set -e`

    Exit immediately if any command fails:

    ```bash
    #!/bin/bash
    set -e  # Exit on error

    mkdir /path/to/dir
    cd /path/to/dir
    # If mkdir fails, script stops
    ```

    ### 5. Use `set -u`

    Treat unset variables as errors:

    ```bash
    #!/bin/bash
    set -u  # Error on undefined variable

    echo "$undefined_var"  # This will cause an error
    ```

    ### 6. Use `set -x`

    Print commands before executing (debugging):

    ```bash
    #!/bin/bash
    set -x  # Debug mode

    echo "Hello"
    # Output: + echo Hello
    #         Hello
    ```

    ### Combine Options

    ```bash
    #!/bin/bash
    set -euo pipefail  # Exit on error, undefined var, pipe failure
    ```

    ## Key Takeaways

    1. **Bash is powerful** - Automate tasks, manage systems
    2. **Shebang matters** - Use `#!/usr/bin/env bash`
    3. **Pipes are your friend** - Chain commands together
    4. **Quote variables** - Prevent word splitting and globbing
    5. **Check exit status** - Use `$?` or `&&` / `||`
    6. **Use set options** - `set -euo pipefail` for robust scripts
    7. **Learn core utilities** - grep, sed, awk, find, etc.
    8. **Practice regularly** - The more you use it, the better you get
  MARKDOWN
  course_module: module1,
  sequence_order: 1,
  estimated_minutes: 45,
  published: true
)

# Lesson 1.2: Variables and Data Types
lesson1_2 = CourseLesson.create!(
  title: "Variables and Data Types",
  content: <<~MARKDOWN,
    # Variables and Data Types

    Bash variables are fundamental to shell scripting. Unlike many programming languages, Bash is dynamically typed and treats everything as strings by default.

    ## Variable Declaration

    ### Basic Syntax

    ```bash
    # Declaration (no spaces around =)
    name="John"
    age=30
    is_active=true

    # ❌ Wrong - spaces cause errors
    name = "John"    # Error!
    ```

    ### Accessing Variables

    ```bash
    name="Alice"
    echo $name       # Output: Alice
    echo "$name"     # Output: Alice (quoted - preferred)
    echo "${name}"   # Output: Alice (curly braces - safe)
    ```

    ### Why Quote Variables?

    ```bash
    filename="my file.txt"

    # ❌ Without quotes - breaks with spaces
    cat $filename    # Looks for files: "my" and "file.txt"

    # ✅ With quotes - works correctly
    cat "$filename"  # Looks for "my file.txt"
    ```

    ## Variable Types

    ### String Variables

    ```bash
    # Single quotes - literal string (no expansion)
    message='Hello $USER'
    echo $message  # Output: Hello $USER

    # Double quotes - allows variable expansion
    message="Hello $USER"
    echo $message  # Output: Hello john

    # No quotes - subject to word splitting and globbing
    message=Hello
    ```

    ### Integer Variables

    ```bash
    # Arithmetic with ((  ))
    count=10
    ((count = count + 1))
    echo $count  # Output: 11

    # Arithmetic with let
    let count=count+5
    echo $count  # Output: 16

    # Arithmetic with $((  ))
    count=$((count * 2))
    echo $count  # Output: 32
    ```

    ### Array Variables

    ```bash
    # Indexed arrays
    fruits=("apple" "banana" "cherry")

    # Access elements
    echo "${fruits[0]}"  # Output: apple
    echo "${fruits[1]}"  # Output: banana

    # All elements
    echo "${fruits[@]}"  # Output: apple banana cherry

    # Number of elements
    echo "${#fruits[@]}" # Output: 3

    # Add element
    fruits+=("date")

    # Iterate over array
    for fruit in "${fruits[@]}"; do
        echo "$fruit"
    done
    ```

    ### Associative Arrays (Bash 4+)

    ```bash
    # Declare associative array
    declare -A user

    # Set values
    user[name]="Alice"
    user[age]=30
    user[city]="NYC"

    # Access values
    echo "${user[name]}"  # Output: Alice

    # Get all keys
    echo "${!user[@]}"    # Output: name age city

    # Get all values
    echo "${user[@]}"     # Output: Alice 30 NYC

    # Iterate
    for key in "${!user[@]}"; do
        echo "$key: ${user[$key]}"
    done
    ```

    ## Special Variables

    ### Positional Parameters

    ```bash
    #!/bin/bash
    # Script: greet.sh

    echo "Script name: $0"
    echo "First argument: $1"
    echo "Second argument: $2"
    echo "All arguments: $@"
    echo "Number of arguments: $#"
    echo "Exit status of last command: $?"
    echo "Process ID: $$"
    echo "Background PID: $!"
    ```

    **Usage:**
    ```bash
    ./greet.sh Alice Bob
    # Output:
    # Script name: ./greet.sh
    # First argument: Alice
    # Second argument: Bob
    # All arguments: Alice Bob
    # Number of arguments: 2
    ```

    ### Special Parameters Table

    | Variable | Meaning |
    |----------|---------|
    | `$0` | Script name |
    | `$1, $2, ...` | Positional arguments |
    | `$#` | Number of arguments |
    | `$@` | All arguments (array) |
    | `$*` | All arguments (string) |
    | `$?` | Exit status of last command |
    | `$$` | Current process ID |
    | `$!` | PID of last background command |
    | `$_` | Last argument of previous command |

    ### Environment Variables

    ```bash
    echo $HOME      # User's home directory
    echo $USER      # Current username
    echo $PATH      # Executable search path
    echo $PWD       # Current directory
    echo $OLDPWD    # Previous directory
    echo $SHELL     # Current shell
    echo $HOSTNAME  # Machine hostname
    echo $RANDOM    # Random number (0-32767)
    ```

    ## Variable Expansion

    ### Parameter Expansion

    ```bash
    name="john"

    # Uppercase first letter
    echo "${name^}"      # Output: John

    # Uppercase all
    echo "${name^^}"     # Output: JOHN

    # Lowercase
    echo "${name,,}"     # Output: john
    ```

    ### Default Values

    ```bash
    # Use default if variable is unset
    echo "${name:-Anonymous}"

    # Assign default if unset
    echo "${name:=Anonymous}"

    # Error if unset
    echo "${name:?Variable is not set}"

    # Use alternative if set
    echo "${name:+Variable is set}"
    ```

    ### String Length

    ```bash
    text="Hello, World!"
    echo "${#text}"  # Output: 13
    ```

    ### Substring Extraction

    ```bash
    text="Hello, World!"

    # From position 7 to end
    echo "${text:7}"      # Output: World!

    # From position 7, length 5
    echo "${text:7:5}"    # Output: World

    # Last 6 characters
    echo "${text: -6}"    # Output: World!
    ```

    ### Pattern Removal

    ```bash
    filename="document.txt"

    # Remove shortest match from end
    echo "${filename%.txt}"     # Output: document

    # Remove longest match from end
    echo "${filename%%.txt}"    # Output: document

    path="/home/user/documents/file.txt"

    # Remove shortest match from beginning
    echo "${path#*/}"           # Output: home/user/documents/file.txt

    # Remove longest match from beginning
    echo "${path##*/}"          # Output: file.txt
    ```

    ### Pattern Replacement

    ```bash
    text="Hello World, World!"

    # Replace first occurrence
    echo "${text/World/Universe}"     # Output: Hello Universe, World!

    # Replace all occurrences
    echo "${text//World/Universe}"    # Output: Hello Universe, Universe!

    # Replace at beginning
    echo "${text/#Hello/Hi}"          # Output: Hi World, World!

    # Replace at end
    echo "${text/%World!/Universe!}"  # Output: Hello World, Universe!
    ```

    ## Variable Scopes

    ### Local Variables

    ```bash
    #!/bin/bash

    function my_function() {
        local var="local"
        echo "Inside function: $var"
    }

    var="global"
    echo "Before function: $var"
    my_function
    echo "After function: $var"

    # Output:
    # Before function: global
    # Inside function: local
    # After function: global
    ```

    ### Export Variables

    ```bash
    # Make variable available to child processes
    export MY_VAR="value"

    # Or combine declaration and export
    export MY_VAR="value"

    # Child script can access $MY_VAR
    ./child_script.sh
    ```

    ## Read-Only Variables

    ```bash
    readonly PI=3.14159
    PI=3.14  # Error: PI is read-only

    # Or
    declare -r VERSION="1.0.0"
    ```

    ## Arithmetic Operations

    ### Using (( ))

    ```bash
    a=10
    b=5

    ((sum = a + b))
    ((diff = a - b))
    ((prod = a * b))
    ((quot = a / b))
    ((mod = a % b))

    echo "Sum: $sum"      # Output: 15
    echo "Diff: $diff"    # Output: 5
    echo "Prod: $prod"    # Output: 50
    echo "Quot: $quot"    # Output: 2
    echo "Mod: $mod"      # Output: 0
    ```

    ### Using $(( ))

    ```bash
    result=$((10 + 5))
    echo $result  # Output: 15

    counter=0
    counter=$((counter + 1))
    echo $counter  # Output: 1
    ```

    ### Using let

    ```bash
    let a=10+5
    let b=a*2
    let c=b/3

    echo $a  # Output: 15
    echo $b  # Output: 30
    echo $c  # Output: 10
    ```

    ### Using expr (legacy)

    ```bash
    result=$(expr 10 + 5)
    echo $result  # Output: 15

    # Note: requires spaces around operators
    ```

    ### Increment/Decrement

    ```bash
    count=10

    # Post-increment
    echo $((count++))  # Output: 10, count is now 11

    # Pre-increment
    echo $((++count))  # Output: 12, count is now 12

    # Post-decrement
    echo $((count--))  # Output: 12, count is now 11

    # Pre-decrement
    echo $((--count))  # Output: 10, count is now 10

    # Shorthand
    ((count += 5))    # count = count + 5
    ((count -= 3))    # count = count - 3
    ((count *= 2))    # count = count * 2
    ((count /= 4))    # count = count / 4
    ```

    ## Floating Point Arithmetic

    Bash doesn't support floating point natively. Use `bc` or `awk`:

    ### Using bc

    ```bash
    result=$(echo "scale=2; 10 / 3" | bc)
    echo $result  # Output: 3.33

    # More complex calculation
    result=$(echo "scale=4; sqrt(2)" | bc)
    echo $result  # Output: 1.4142
    ```

    ### Using awk

    ```bash
    result=$(awk "BEGIN {print 10 / 3}")
    echo $result  # Output: 3.33333
    ```

    ## Practical Examples

    ### Example 1: Calculator Script

    ```bash
    #!/bin/bash

    read -p "Enter first number: " num1
    read -p "Enter second number: " num2
    read -p "Enter operation (+, -, *, /): " op

    case $op in
        +) result=$((num1 + num2)) ;;
        -) result=$((num1 - num2)) ;;
        \\*) result=$((num1 * num2)) ;;
        /) result=$((num1 / num2)) ;;
        *) echo "Invalid operation"; exit 1 ;;
    esac

    echo "Result: $result"
    ```

    ### Example 2: File Renamer

    ```bash
    #!/bin/bash
    # Rename all .txt files to .bak

    for file in *.txt; do
        # Get filename without extension
        basename="${file%.txt}"

        # Rename
        mv "$file" "${basename}.bak"
        echo "Renamed: $file -> ${basename}.bak"
    done
    ```

    ### Example 3: Environment Info

    ```bash
    #!/bin/bash

    echo "=== Environment Information ==="
    echo "User: $USER"
    echo "Home: $HOME"
    echo "Shell: $SHELL"
    echo "Path: $PATH"
    echo "Current Directory: $PWD"
    echo "Hostname: $HOSTNAME"
    echo "Terminal: $TERM"
    ```

    ## Best Practices

    ### 1. Always Quote Variables

    ```bash
    # ❌ Bad
    echo $name

    # ✅ Good
    echo "$name"
    ```

    ### 2. Use Curly Braces

    ```bash
    # ❌ Ambiguous
    echo "$prefixsuffix"

    # ✅ Clear
    echo "${prefix}suffix"
    ```

    ### 3. Initialize Variables

    ```bash
    # ✅ Good practice
    count=0
    message=""
    items=()
    ```

    ### 4. Use Meaningful Names

    ```bash
    # ❌ Bad
    x=10
    tmp="file"

    # ✅ Good
    user_count=10
    config_file="file"
    ```

    ### 5. Use readonly for Constants

    ```bash
    readonly MAX_USERS=100
    readonly CONFIG_FILE="/etc/app/config"
    ```

    ### 6. Check if Variable is Set

    ```bash
    if [[ -z "$variable" ]]; then
        echo "Variable is not set or empty"
    fi

    if [[ -n "$variable" ]]; then
        echo "Variable is set and not empty"
    fi
    ```

    ## Key Takeaways

    1. **No spaces around `=`** - `var=value` not `var = value`
    2. **Quote variables** - Use `"$var"` to prevent word splitting
    3. **Use `${var}`** - Curly braces for safety and clarity
    4. **Arrays are powerful** - Indexed and associative arrays
    5. **Special variables** - `$#`, `$@`, `$?`, etc.
    6. **Parameter expansion** - Advanced string manipulation
    7. **Arithmetic** - Use `(( ))` or `$(( ))`
    8. **Floating point** - Use `bc` or `awk`
  MARKDOWN
  course_module: module1,
  sequence_order: 2,
  estimated_minutes: 35,
  published: true
)

# Lesson 1.3: Command-Line Arguments
lesson1_3 = CourseLesson.create!(
  title: "Working with Command-Line Arguments",
  content: <<~MARKDOWN,
    # Working with Command-Line Arguments

    Command-line arguments allow users to pass information to your scripts, making them flexible and reusable.

    ## Basic Argument Access

    ### Positional Parameters

    ```bash
    #!/bin/bash
    # script.sh

    echo "Script: $0"
    echo "Arg 1: $1"
    echo "Arg 2: $2"
    echo "Arg 3: $3"
    ```

    **Usage:**
    ```bash
    ./script.sh apple banana cherry
    # Output:
    # Script: ./script.sh
    # Arg 1: apple
    # Arg 2: banana
    # Arg 3: cherry
    ```

    ### All Arguments

    ```bash
    # $@ - All arguments as separate words
    for arg in "$@"; do
        echo "Argument: $arg"
    done

    # $* - All arguments as single word
    echo "All args: $*"

    # $# - Number of arguments
    echo "Count: $#"
    ```

    ## Shifting Arguments

    The `shift` command moves arguments left:

    ```bash
    #!/bin/bash

    echo "First arg: $1"
    shift
    echo "After shift: $1"
    shift 2
    echo "After shift 2: $1"
    ```

    **Usage:**
    ```bash
    ./script.sh a b c d
    # Output:
    # First arg: a
    # After shift: b
    # After shift 2: d
    ```

    ## Processing Options

    ### Simple Option Processing

    ```bash
    #!/bin/bash

    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                echo "Usage: $0 [-h] [-v] [-o output] input"
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            -o|--output)
                output_file="$2"
                shift 2
                ;;
            -*)
                echo "Unknown option: $1"
                exit 1
                ;;
            *)
                input_file="$1"
                shift
                ;;
        esac
    done

    echo "Input: $input_file"
    echo "Output: $output_file"
    echo "Verbose: $verbose"
    ```

    ### Using getopts

    Built-in command for parsing short options:

    ```bash
    #!/bin/bash

    while getopts "hvo:f:" opt; do
        case $opt in
            h)
                echo "Help message"
                exit 0
                ;;
            v)
                verbose=true
                ;;
            o)
                output="$OPTARG"
                ;;
            f)
                file="$OPTARG"
                ;;
            \\?)
                echo "Invalid option: -$OPTARG"
                exit 1
                ;;
            :)
                echo "Option -$OPTARG requires an argument"
                exit 1
                ;;
        esac
    done

    shift $((OPTIND - 1))
    ```

    **Usage:**
    ```bash
    ./script.sh -v -o output.txt -f input.txt remaining args
    ```

    ## Validation

    ### Check Argument Count

    ```bash
    #!/bin/bash

    if [[ $# -lt 2 ]]; then
        echo "Error: At least 2 arguments required"
        echo "Usage: $0 <source> <destination>"
        exit 1
    fi

    source="$1"
    destination="$2"
    ```

    ### Check if File Exists

    ```bash
    #!/bin/bash

    if [[ ! -f "$1" ]]; then
        echo "Error: File '$1' not found"
        exit 1
    fi

    echo "Processing file: $1"
    ```

    ## Reading Input

    ### Interactive Input

    ```bash
    #!/bin/bash

    read -p "Enter your name: " name
    read -p "Enter your age: " age

    echo "Hello, $name! You are $age years old."
    ```

    ### Reading with Timeout

    ```bash
    #!/bin/bash

    if read -t 5 -p "Enter your name (5 seconds): " name; then
        echo "Hello, $name!"
    else
        echo "\\nTimeout! Using default name."
        name="Guest"
    fi
    ```

    ### Reading Passwords

    ```bash
    #!/bin/bash

    read -sp "Enter password: " password
    echo ""
    echo "Password length: ${#password}"
    ```

    ### Reading into Array

    ```bash
    #!/bin/bash

    echo "Enter multiple values (space-separated):"
    read -a values

    echo "You entered ${#values[@]} values:"
    for val in "${values[@]}"; do
        echo "- $val"
    done
    ```

    ## Practical Examples

    ### Example 1: File Backup Script

    ```bash
    #!/bin/bash
    # backup.sh - Backup files with validation

    # Check arguments
    if [[ $# -lt 2 ]]; then
        echo "Usage: $0 <source> <destination>"
        exit 1
    fi

    source="$1"
    dest="$2"

    # Validate source
    if [[ ! -e "$source" ]]; then
        echo "Error: Source '$source' does not exist"
        exit 1
    fi

    # Create destination directory
    mkdir -p "$dest"

    # Perform backup
    if cp -r "$source" "$dest"; then
        echo "Backup successful: $source -> $dest"
    else
        echo "Backup failed"
        exit 1
    fi
    ```

    ### Example 2: Log Analyzer with Options

    ```bash
    #!/bin/bash
    # loganalyzer.sh

    verbose=false
    count=10

    while getopts "vn:h" opt; do
        case $opt in
            v) verbose=true ;;
            n) count="$OPTARG" ;;
            h)
                echo "Usage: $0 [-v] [-n count] <logfile>"
                echo "  -v         Verbose output"
                echo "  -n count   Number of entries (default: 10)"
                exit 0
                ;;
            \\?) exit 1 ;;
        esac
    done

    shift $((OPTIND - 1))

    if [[ $# -eq 0 ]]; then
        echo "Error: Log file required"
        exit 1
    fi

    logfile="$1"

    if [[ ! -f "$logfile" ]]; then
        echo "Error: File '$logfile' not found"
        exit 1
    fi

    [[ $verbose == true ]] && echo "Analyzing: $logfile"

    echo "Top $count errors:"
    grep -i error "$logfile" | head -n "$count"
    ```

    ### Example 3: Interactive Menu

    ```bash
    #!/bin/bash
    # menu.sh

    show_menu() {
        echo "=== Main Menu ==="
        echo "1. List files"
        echo "2. Show disk usage"
        echo "3. Display date"
        echo "4. Exit"
        echo ""
    }

    while true; do
        show_menu
        read -p "Enter choice [1-4]: " choice

        case $choice in
            1)
                ls -la
                ;;
            2)
                df -h
                ;;
            3)
                date
                ;;
            4)
                echo "Goodbye!"
                exit 0
                ;;
            *)
                echo "Invalid choice"
                ;;
        esac

        echo ""
        read -p "Press Enter to continue..."
    done
    ```

    ## Best Practices

    ### 1. Validate All Inputs

    ```bash
    if [[ $# -eq 0 ]]; then
        echo "Error: No arguments provided"
        exit 1
    fi
    ```

    ### 2. Provide Help

    ```bash
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "Usage: $0 <input> [options]"
        echo "Options:"
        echo "  -h, --help     Show this help"
        echo "  -v, --verbose  Verbose output"
        exit 0
    fi
    ```

    ### 3. Use Meaningful Variable Names

    ```bash
    # ❌ Bad
    arg1="$1"
    arg2="$2"

    # ✅ Good
    input_file="$1"
    output_file="$2"
    ```

    ### 4. Quote Arguments

    ```bash
    # ❌ Bad - breaks with spaces
    cp $1 $2

    # ✅ Good
    cp "$1" "$2"
    ```

    ### 5. Set Defaults

    ```bash
    output_dir="${1:-./output}"
    verbose="${2:-false}"
    count="${3:-10}"
    ```

    ## Key Takeaways

    1. **`$1, $2, ...`** - Access positional arguments
    2. **`$@`** - All arguments (array)
    3. **`$#`** - Count arguments
    4. **`getopts`** - Parse short options
    5. **`shift`** - Move arguments left
    6. **`read`** - Get interactive input
    7. **Validate inputs** - Check count, file existence, etc.
    8. **Provide help** - `-h` or `--help` flag
  MARKDOWN
  course_module: module1,
  sequence_order: 3,
  estimated_minutes: 20,
  published: true
)

puts "  ✅ Created #{module1.course_lessons.count} lessons for Module 1"

# ========================================
# Module 2: Shell Scripting
# ========================================

module2 = CourseModule.find_or_create_by!(slug: 'bash-scripting', course: bash_course) do |mod|
  mod.title = 'Shell Scripting'
  mod.description = 'Control flow, functions, and script structure'
  mod.sequence_order = 2
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Master control flow structures",
    "Write reusable functions",
    "Handle errors effectively",
    "Structure scripts properly"
  ])
end

puts "  ✅ Created Module 2: Shell Scripting"

# ========================================
# Module 3: Advanced Bash
# ========================================

module3 = CourseModule.find_or_create_by!(slug: 'bash-advanced', course: bash_course) do |mod|
  mod.title = 'Advanced Bash'
  mod.description = 'Process management, text processing, automation'
  mod.sequence_order = 3
  mod.estimated_minutes = 110
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Master process management",
    "Use advanced text processing tools",
    "Create automation scripts",
    "Apply debugging techniques"
  ])
end

puts "  ✅ Created Module 3: Advanced Bash"

puts "  ✅ Created Bash course with #{bash_course.course_modules.count} modules"
puts "\n✅ Bash/Shell Scripting Course Created!\n"
