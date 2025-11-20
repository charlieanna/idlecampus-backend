#!/bin/bash
# Populate all empty prompt files with content

cd /Users/ankurkothari/Documents/workspace/idlecampus/backend/prompts

# Function to create a complete prompt file
create_prompt() {
    local file_path=$1
    local course_name=$2
    shift 2
    local seed_files=("$@")

    cat > "$file_path" << 'TEMPLATE_END'
=======================================
MICROLESSON GENERATOR - COURSE_NAME_PLACEHOLDER
=======================================

ATTACH FILES from idlecampus/backend/db/seeds/:
SEED_FILES_PLACEHOLDER

COURSE: COURSE_NAME_SIMPLE

# YOUR TASK
Transform the attached InteractiveLearningUnit seed files into the new MicroLesson + Exercise format.

# MICROLESSON PRINCIPLES
1. **Very Small Size**: 1 concept per microlesson (2-3 minutes to complete)
2. **Immediate Practice**: Every microlesson followed by 1-4 exercises
3. **Exercise Count by Difficulty**:
   - Easy lessons: 1-2 exercises
   - Medium lessons: 2-3 exercises
   - Hard lessons: 3-4 exercises
4. **Progressive Hints**: Each exercise has 3 hints (gentle → specific → answer)
5. **Smart Prerequisites**: AI infers which prior lessons are needed
6. **Remediation**: If user fails, show prerequisite content inline

# EXERCISE TYPES TO USE
- **terminal**: For CLI commands
  - Include command to run, expected output, validation
- **mcq**: Multiple choice with 4 options (exactly 1 correct)
  - For concepts, theory, best practices
- **code**: For programming challenges
  - Include starter code, test cases, solution
- **short_answer**: For explanations and design questions

# CONVERSION RULES
For each InteractiveLearningUnit in the seed files:
1. Break down into microlessons (1 concept each)
2. Add 1-4 exercises after each microlesson
3. Infer prerequisites by analyzing concept dependencies
4. Create 3 progressive hints per exercise
5. Use appropriate exercise types based on content

# OUTPUT FORMAT
Generate complete Ruby seed files with this structure:

```ruby
# Microlesson model
MicroLesson.create!(
  title: "Lesson Title",
  content: "...", # Markdown content (2-3 minutes)
  duration_minutes: 2,
  difficulty: "easy", # easy/medium/hard
  module_id: "module-slug",
  order: 1,
  prerequisites: [] # IDs of required prior microlessons
)

# Exercise model with polymorphic exercise_data
Exercise.create!(
  micro_lesson_id: 1,
  exercise_type: "terminal", # terminal/mcq/code/short_answer
  order: 1,
  exercise_data: {
    description: "Exercise description",
    # Type-specific fields here
  },
  hints: [
    "Hint 1: Gentle nudge",
    "Hint 2: More specific guidance",
    "Hint 3: Nearly the full answer"
  ]
)
```

# QUALITY CHECKLIST
- [ ] Each microlesson covers exactly 1 concept
- [ ] Every microlesson has 1-4 exercises
- [ ] All exercises have 3 progressive hints
- [ ] Prerequisites are inferred and linked
- [ ] Exercise types match the content
- [ ] Difficulty progression is logical

Generate the complete seed file now.
TEMPLATE_END

    # Now replace placeholders
    local course_upper=$(echo "$course_name" | tr '[:lower:]' '[:upper:]')
    sed -i '' "s/COURSE_NAME_PLACEHOLDER/$course_upper/g" "$file_path"
    sed -i '' "s/COURSE_NAME_SIMPLE/$course_name/g" "$file_path"

    # Create seed files list
    local seed_list=""
    for seed in "${seed_files[@]}"; do
        seed_list="${seed_list}□ ${seed}\n"
    done
    # Remove trailing newline
    seed_list=$(echo -e "$seed_list" | sed '$ d')

    # Replace seed files (using | as delimiter since files have forward slashes)
    perl -i -pe "s|SEED_FILES_PLACEHOLDER|$seed_list|g" "$file_path"
}

echo "Populating empty prompt files..."

# DevOps (5 empty)
create_prompt "devops/05_git_version_control_prompt.txt" "Git Version Control" \
    "git_basics_units.rb" "git_branching_units.rb" "git_advanced_units.rb"

create_prompt "devops/06_aws_prompt.txt" "AWS Cloud" \
    "aws_ec2_units.rb" "aws_s3_units.rb" "aws_rds_units.rb"

create_prompt "devops/07_networking_prompt.txt" "Networking Fundamentals" \
    "networking_basics_units.rb" "networking_protocols_units.rb"

create_prompt "devops/08_infrastructure_as_code_prompt.txt" "Infrastructure as Code" \
    "iac_terraform_units.rb" "iac_ansible_units.rb"

create_prompt "devops/10_security_fundamentals_prompt.txt" "Security Fundamentals" \
    "security_basics_units.rb" "security_best_practices_units.rb"

# Programming (9 empty)
create_prompt "programming/11_python_prompt.txt" "Python Programming" \
    "python_basics_units.rb" "python_advanced_units.rb"

create_prompt "programming/12_golang_prompt.txt" "Golang Programming" \
    "golang_basics_units.rb" "golang_advanced_units.rb"

create_prompt "programming/13_javascript_node.js_prompt.txt" "JavaScript & Node.js" \
    "javascript_basics_units.rb" "nodejs_units.rb"

create_prompt "programming/14_typescript_prompt.txt" "TypeScript" \
    "typescript_basics_units.rb" "typescript_advanced_units.rb"

create_prompt "programming/15_rust_prompt.txt" "Rust Programming" \
    "rust_basics_units.rb" "rust_ownership_units.rb"

create_prompt "programming/16_react_advanced_prompt.txt" "React Advanced" \
    "react_hooks_units.rb" "react_performance_units.rb"

create_prompt "programming/17_graphql_api_prompt.txt" "GraphQL API" \
    "graphql_basics_units.rb" "graphql_advanced_units.rb"

create_prompt "programming/18_regular_expressions_prompt.txt" "Regular Expressions" \
    "regex_basics_units.rb" "regex_advanced_units.rb"

create_prompt "programming/19_bash_shell_scripting_prompt.txt" "Bash Shell Scripting" \
    "bash_basics_units.rb" "bash_scripting_units.rb"

# IIT JEE (7 empty)
create_prompt "iit_jee/20_inorganic_chemistry_prompt.txt" "Inorganic Chemistry" \
    "iitjee_inorganic_chem_units.rb"

create_prompt "iit_jee/21_organic_chemistry_prompt.txt" "Organic Chemistry" \
    "iitjee_organic_chem_units.rb"

create_prompt "iit_jee/22_physical_chemistry_prompt.txt" "Physical Chemistry" \
    "iitjee_physical_chem_units.rb"

create_prompt "iit_jee/23_mathematics_algebra_prompt.txt" "Mathematics - Algebra" \
    "iitjee_math_algebra_units.rb"

create_prompt "iit_jee/24_mathematics_calculus_prompt.txt" "Mathematics - Calculus" \
    "iitjee_math_calculus_units.rb"

create_prompt "iit_jee/25_mathematics_trigonometry_prompt.txt" "Mathematics - Trigonometry" \
    "iitjee_math_trigonometry_units.rb"

create_prompt "iit_jee/26_calculus_linear_algebra_prompt.txt" "Calculus & Linear Algebra" \
    "calculus_units.rb" "linear_algebra_units.rb"

# Software Engineering (10 empty)
create_prompt "software_engineering/27_system_design_architecture_prompt.txt" "System Design & Architecture" \
    "system_design_units.rb" "architecture_patterns_units.rb"

create_prompt "software_engineering/28_microservices_prompt.txt" "Microservices" \
    "microservices_fundamentals_units.rb" "microservices_patterns_units.rb"

create_prompt "software_engineering/29_design_patterns_prompt.txt" "Design Patterns" \
    "design_patterns_creational_units.rb" "design_patterns_structural_units.rb"

create_prompt "software_engineering/30_clean_code_refactoring_prompt.txt" "Clean Code & Refactoring" \
    "clean_code_principles_units.rb" "refactoring_techniques_units.rb"

create_prompt "software_engineering/31_testing_masterclass_prompt.txt" "Testing Masterclass" \
    "testing_unit_units.rb" "testing_integration_units.rb"

create_prompt "software_engineering/32_concurrency_programming_prompt.txt" "Concurrency Programming" \
    "concurrency_basics_units.rb" "concurrency_patterns_units.rb"

create_prompt "software_engineering/33_message_queues_prompt.txt" "Message Queues" \
    "message_queues_fundamentals_units.rb" "rabbitmq_units.rb"

create_prompt "software_engineering/34_redis_caching_prompt.txt" "Redis & Caching" \
    "redis_basics_units.rb" "caching_strategies_units.rb"

create_prompt "software_engineering/35_web_performance_prompt.txt" "Web Performance" \
    "web_performance_fundamentals_units.rb" "optimization_techniques_units.rb"

create_prompt "software_engineering/36_envoy_proxy_prompt.txt" "Envoy Proxy" \
    "envoy_basics_units.rb" "envoy_advanced_units.rb"

# Data Science (2 empty)
create_prompt "data_science/39_machine_learning_prompt.txt" "Machine Learning" \
    "ml_fundamentals_units.rb" "ml_algorithms_units.rb"

create_prompt "data_science/40_pandas_numpy_prompt.txt" "Pandas & NumPy" \
    "pandas_basics_units.rb" "numpy_basics_units.rb"

# Interview Prep (2 empty)
create_prompt "interview_prep/41_coding_interview_prompt.txt" "Coding Interview Preparation" \
    "coding_interview_patterns_units.rb" "coding_interview_practice_units.rb"

create_prompt "interview_prep/42_data_structures_algorithms_prompt.txt" "Data Structures & Algorithms" \
    "ds_arrays_linked_lists_units.rb" "ds_trees_graphs_units.rb" "algorithms_sorting_searching_units.rb"

echo ""
echo "✅ Populated all 35 empty prompt files!"
echo ""
echo "Summary:"
echo "  DevOps: 5 files"
echo "  Programming: 9 files"
echo "  IIT JEE: 7 files"
echo "  Software Engineering: 10 files"
echo "  Data Science: 2 files"
echo "  Interview Prep: 2 files"
echo ""
echo "Total: 35 prompt files now have content"
