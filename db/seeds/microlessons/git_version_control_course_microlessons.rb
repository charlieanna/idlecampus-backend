# AUTO-GENERATED from git_version_control_course.rb
puts "Creating Microlessons for Git Fundamentals..."

module_var = CourseModule.find_by(slug: 'git-fundamentals')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Git Basics and Core Concepts

    Git is the most popular distributed version control system, essential for modern software development.

    ## Why Git?

    ✓ **Distributed**: Every developer has full repository history
    ✓ **Fast**: Most operations are local
    ✓ **Branching**: Lightweight and powerful
    ✓ **Data Integrity**: Everything is checksummed (SHA-1)
    ✓ **Staging Area**: Review changes before committing

    ## Git's Three States

    Files can be in three states:

    ### 1. Modified
    - Changed but not committed
    - In working directory

    ### 2. Staged
    - Marked for next commit
    - In staging area (index)

    ### 3. Committed
    - Safely stored in repository
    - In .git directory

    ```
    Working Directory  →  Staging Area  →  Repository
         (modify)      (git add)      (git commit)
    ```

    ## Initial Setup

    ```bash
    # Set your identity (required)
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"

    # Set default editor
    git config --global core.editor "code --wait"  # VS Code
    git config --global core.editor "vim"          # Vim

    # Set default branch name
    git config --global init.defaultBranch main

    # Check configuration
    git config --list
    git config user.name
    ```

    ## Creating a Repository

    ### Initialize New Repo

    ```bash
    # Create new repository
    mkdir myproject
    cd myproject
    git init

    # Output: Initialized empty Git repository in /path/to/myproject/.git/
    ```

    ### Clone Existing Repo

    ```bash
    # Clone repository
    git clone https://github.com/user/repo.git

    # Clone to specific directory
    git clone https://github.com/user/repo.git my-folder

    # Clone specific branch
    git clone -b develop https://github.com/user/repo.git
    ```

    ## Basic Workflow

    ### 1. Check Status

    ```bash
    git status

    # Output shows:
    # - Current branch
    # - Untracked files
    # - Modified files
    # - Staged files
    ```

    ### 2. Stage Changes

    ```bash
    # Stage specific file
    git add filename.txt

    # Stage all changes in directory
    git add .

    # Stage all changes (including deletions)
    git add -A

    # Stage interactively
    git add -p  # Review each change
    ```

    ### 3. Commit Changes

    ```bash
    # Commit with message
    git commit -m "Add user authentication feature"

    # Commit with detailed message (opens editor)
    git commit

    # Stage and commit in one step
    git commit -am "Fix bug in login form"

    # Amend last commit
    git commit --amend -m "New commit message"
    ```

    ## Viewing History

    ```bash
    # Show commit history
    git log

    # One line per commit
    git log --oneline

    # With graph
    git log --oneline --graph --all

    # Show changes in each commit
    git log -p

    # Last N commits
    git log -3

    # Specific file history
    git log filename.txt

    # Search commits
    git log --grep="bug fix"
    git log --author="John"

    # Show file at specific commit
    git show abc123:path/to/file.txt
    ```

    ## Viewing Changes

    ```bash
    # Unstaged changes
    git diff

    # Staged changes
    git diff --staged
    git diff --cached

    # Changes between commits
    git diff abc123 def456

    # Changes in specific file
    git diff filename.txt

    # Statistics
    git diff --stat
    ```

    ## Undoing Changes

    ### Discard Working Directory Changes

    ```bash
    # Discard changes in file
    git restore filename.txt
    # Old syntax: git checkout -- filename.txt

    # Discard all changes
    git restore .
    ```

    ### Unstage Files

    ```bash
    # Unstage file
    git restore --staged filename.txt
    # Old syntax: git reset HEAD filename.txt

    # Unstage all
    git restore --staged .
    ```

    ### Undo Commits

    ```bash
    # Undo last commit, keep changes staged
    git reset --soft HEAD~1

    # Undo last commit, unstage changes
    git reset HEAD~1
    git reset --mixed HEAD~1  # same

    # Undo last commit, discard changes (DANGEROUS!)
    git reset --hard HEAD~1

    # Create new commit that undoes changes (safe)
    git revert abc123
    ```

    ## Ignoring Files

    Create `.gitignore` file:

    ```gitignore
    # Node.js
    node_modules/
    npm-debug.log

    # Python
    __pycache__/
    *.pyc
    .env

    # IDEs
    .vscode/
    .idea/
    *.swp

    # OS
    .DS_Store
    Thumbs.db

    # Build outputs
    dist/
    build/
    *.log

    # Secrets
    .env
    config/secrets.yml
    *.key
    *.pem
    ```

    ## Tagging

    ```bash
    # Lightweight tag
    git tag v1.0.0

    # Annotated tag (recommended)
    git tag -a v1.0.0 -m "Release version 1.0.0"

    # Tag specific commit
    git tag -a v0.9.0 abc123 -m "Version 0.9.0"

    # List tags
    git tag
    git tag -l "v1.*"

    # Show tag details
    git show v1.0.0

    # Push tags
    git push origin v1.0.0
    git push origin --tags  # all tags

    # Delete tag
    git tag -d v1.0.0
    git push origin --delete v1.0.0
    ```

    ## Stashing

    **Save work-in-progress without committing**

    ```bash
    # Stash changes
    git stash
    git stash save "Work in progress on feature X"

    # List stashes
    git stash list

    # Apply most recent stash
    git stash apply

    # Apply and remove from stash list
    git stash pop

    # Apply specific stash
    git stash apply stash@{2}

    # Show stash contents
    git stash show
    git stash show -p  # with diff

    # Drop stash
    git stash drop stash@{0}

    # Clear all stashes
    git stash clear
    ```

    ## Working with Remotes

    ```bash
    # List remotes
    git remote -v

    # Add remote
    git remote add origin https://github.com/user/repo.git

    # Rename remote
    git remote rename origin upstream

    # Remove remote
    git remote remove origin

    # Fetch from remote
    git fetch origin

    # Pull (fetch + merge)
    git pull origin main

    # Pull with rebase
    git pull --rebase origin main

    # Push to remote
    git push origin main

    # Push and set upstream
    git push -u origin feature-branch

    # Force push (DANGEROUS!)
    git push --force origin main
    git push --force-with-lease origin main  # safer
    ```

    ## Useful Aliases

    ```bash
    # Set up aliases
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.visual 'log --oneline --graph --all'

    # Use aliases
    git st
    git co main
    git unstage file.txt
    ```

    ## Best Practices

    1. **Commit Often**: Small, focused commits
    2. **Write Good Messages**: Clear, descriptive commit messages
    3. **Pull Before Push**: Stay up-to-date
    4. **Use Branches**: Never work directly on main
    5. **Review Before Commit**: Use `git diff` and `git status`
    6. **Don't Commit Secrets**: Use `.gitignore`

    ## Common Scenarios

    ### Oops, I committed to the wrong branch!

    ```bash
    # Move commit to new branch
    git branch new-branch
    git reset --hard HEAD~1
    git checkout new-branch
    ```

    ### I need to fix the last commit message

    ```bash
    git commit --amend -m "Correct message"
    ```

    ### I want to undo a public commit

    ```bash
    # Use revert (creates new commit)
    git revert abc123
    ```

    **Next**: We'll explore branching strategies and workflows!
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

# Git Basics and Core Concepts

    Git is the most popular distributed version control system, essential for modern software development.

    ## Why Git?

    ✓ **Distributed**: Every developer has full repository history
    ✓ **Fast**: Most operations are local
    ✓ **Branching**: Lightweight and powerful
    ✓ **Data Integrity**: Everything is checksummed (SHA-1)
    ✓ **Staging Area**: Review changes before committing

    ## Git's Three States

    Files can be in three states:

    ### 1. Modified
    - Changed but not committed
    - In working directory

    ### 2. Staged
    - Marked for next commit
    - In staging area (index)

    ### 3. Committed
    - Safely stored in repository
    - In .git directory

    ```
    Working Directory  →  Staging Area  →  Repository
         (modify)      (git add)      (git commit)
    ```

    ## Initial Setup

    ```bash
    # Set your identity (required)
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"

    # Set default editor
    git config --global core.editor "code --wait"  # VS Code
    git config --global core.editor "vim"          # Vim

    # Set default branch name
    git config --global init.defaultBranch main

    # Check configuration
    git config --list
    git config user.name
    ```

    ## Creating a Repository

    ### Initialize New Repo

    ```bash
    # Create new repository
    mkdir myproject
    cd myproject
    git init

    # Output: Initialized empty Git repository in /path/to/myproject/.git/
    ```

    ### Clone Existing Repo

    ```bash
    # Clone repository
    git clone https://github.com/user/repo.git

    # Clone to specific directory
    git clone https://github.com/user/repo.git my-folder

    # Clone specific branch
    git clone -b develop https://github.com/user/repo.git
    ```

    ## Basic Workflow

    ### 1. Check Status

    ```bash
    git status

    # Output shows:
    # - Current branch
    # - Untracked files
    # - Modified files
    # - Staged files
    ```

    ### 2. Stage Changes

    ```bash
    # Stage specific file
    git add filename.txt

    # Stage all changes in directory
    git add .

    # Stage all changes (including deletions)
    git add -A

    # Stage interactively
    git add -p  # Review each change
    ```

    ### 3. Commit Changes

    ```bash
    # Commit with message
    git commit -m "Add user authentication feature"

    # Commit with detailed message (opens editor)
    git commit

    # Stage and commit in one step
    git commit -am "Fix bug in login form"

    # Amend last commit
    git commit --amend -m "New commit message"
    ```

    ## Viewing History

    ```bash
    # Show commit history
    git log

    # One line per commit
    git log --oneline

    # With graph
    git log --oneline --graph --all

    # Show changes in each commit
    git log -p

    # Last N commits
    git log -3

    # Specific file history
    git log filename.txt

    # Search commits
    git log --grep="bug fix"
    git log --author="John"

    # Show file at specific commit
    git show abc123:path/to/file.txt
    ```

    ## Viewing Changes

    ```bash
    # Unstaged changes
    git diff

    # Staged changes
    git diff --staged
    git diff --cached

    # Changes between commits
    git diff abc123 def456

    # Changes in specific file
    git diff filename.txt

    # Statistics
    git diff --stat
    ```

    ## Undoing Changes

    ### Discard Working Directory Changes

    ```bash
    # Discard changes in file
    git restore filename.txt
    # Old syntax: git checkout -- filename.txt

    # Discard all changes
    git restore .
    ```

    ### Unstage Files

    ```bash
    # Unstage file
    git restore --staged filename.txt
    # Old syntax: git reset HEAD filename.txt

    # Unstage all
    git restore --staged .
    ```

    ### Undo Commits

    ```bash
    # Undo last commit, keep changes staged
    git reset --soft HEAD~1

    # Undo last commit, unstage changes
    git reset HEAD~1
    git reset --mixed HEAD~1  # same

    # Undo last commit, discard changes (DANGEROUS!)
    git reset --hard HEAD~1

    # Create new commit that undoes changes (safe)
    git revert abc123
    ```

    ## Ignoring Files

    Create `.gitignore` file:

    ```gitignore
    # Node.js
    node_modules/
    npm-debug.log

    # Python
    __pycache__/
    *.pyc
    .env

    # IDEs
    .vscode/
    .idea/
    *.swp

    # OS
    .DS_Store
    Thumbs.db

    # Build outputs
    dist/
    build/
    *.log

    # Secrets
    .env
    config/secrets.yml
    *.key
    *.pem
    ```

    ## Tagging

    ```bash
    # Lightweight tag
    git tag v1.0.0

    # Annotated tag (recommended)
    git tag -a v1.0.0 -m "Release version 1.0.0"

    # Tag specific commit
    git tag -a v0.9.0 abc123 -m "Version 0.9.0"

    # List tags
    git tag
    git tag -l "v1.*"

    # Show tag details
    git show v1.0.0

    # Push tags
    git push origin v1.0.0
    git push origin --tags  # all tags

    # Delete tag
    git tag -d v1.0.0
    git push origin --delete v1.0.0
    ```

    ## Stashing

    **Save work-in-progress without committing**

    ```bash
    # Stash changes
    git stash
    git stash save "Work in progress on feature X"

    # List stashes
    git stash list

    # Apply most recent stash
    git stash apply

    # Apply and remove from stash list
    git stash pop

    # Apply specific stash
    git stash apply stash@{2}

    # Show stash contents
    git stash show
    git stash show -p  # with diff

    # Drop stash
    git stash drop stash@{0}

    # Clear all stashes
    git stash clear
    ```

    ## Working with Remotes

    ```bash
    # List remotes
    git remote -v

    # Add remote
    git remote add origin https://github.com/user/repo.git

    # Rename remote
    git remote rename origin upstream

    # Remove remote
    git remote remove origin

    # Fetch from remote
    git fetch origin

    # Pull (fetch + merge)
    git pull origin main

    # Pull with rebase
    git pull --rebase origin main

    # Push to remote
    git push origin main

    # Push and set upstream
    git push -u origin feature-branch

    # Force push (DANGEROUS!)
    git push --force origin main
    git push --force-with-lease origin main  # safer
    ```

    ## Useful Aliases

    ```bash
    # Set up aliases
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.visual 'log --oneline --graph --all'

    # Use aliases
    git st
    git co main
    git unstage file.txt
    ```

    ## Best Practices

    1. **Commit Often**: Small, focused commits
    2. **Write Good Messages**: Clear, descriptive commit messages
    3. **Pull Before Push**: Stay up-to-date
    4. **Use Branches**: Never work directly on main
    5. **Review Before Commit**: Use `git diff` and `git status`
    6. **Don't Commit Secrets**: Use `.gitignore`

    ## Common Scenarios

    ### Oops, I committed to the wrong branch!

    ```bash
    # Move commit to new branch
    git branch new-branch
    git reset --hard HEAD~1
    git checkout new-branch
    ```

    ### I need to fix the last commit message

    ```bash
    git commit --amend -m "Correct message"
    ```

    ### I want to undo a public commit

    ```bash
    # Use revert (creates new commit)
    git revert abc123
    ```

    **Next**: We'll explore branching strategies and workflows!
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 2 microlessons for Git Fundamentals"
