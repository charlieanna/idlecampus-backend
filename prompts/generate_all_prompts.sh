#!/bin/bash

# Batch Generate All 45 Course Prompts
# Usage: cd prompts && bash generate_all_prompts.sh

echo "🚀 Generating prompts for all 45 courses..."

# Function to create prompt file
create_prompt() {
    local category=$1
    local number=$2
    local course_name=$3
    shift 3
    local files=("$@")

    local filename="${category}/${number}_$(echo $course_name | tr ' ' '_' | tr '[:upper:]' '[:lower:]')_prompt.txt"

    cat > "$filename" << EOF
=======================================
MICROLESSON GENERATOR - ${course_name^^}
=======================================

[Copy this prompt + attach files below to GPT-5 Pro]

ATTACH FILES from idlecampus/backend/db/seeds/:

$(printf '□ %s\n' "${files[@]}")

COURSE: $course_name

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You are an expert educational content designer. Convert the attached seed files into microlesson format.

# CONVERSION RULES

- **Microlessons**: 1 concept, 2-3 minutes each
- **Exercises**: 1-4 per lesson based on difficulty
- **Types**: terminal (CLI), mcq (4 options), code (programming)
- **Hints**: 3 progressive hints per exercise
- **Prerequisites**: Infer from content analysis

# OUTPUT FORMAT

Generate complete Ruby seed files with MicroLesson and Exercise models.

See UNIVERSAL_TEMPLATE.txt for detailed format.

START GENERATION NOW.
EOF

    echo "  ✓ Created: $filename"
}

# DevOps Courses (4-10, we already have 1-3)
create_prompt "devops" "04" "PostgreSQL" \
    "postgresql_course.rb" "postgresql_lessons.rb"

create_prompt "devops" "05" "Git Version Control" \
    "git_version_control_course.rb"

create_prompt "devops" "06" "AWS" \
    "aws_course_complete.rb"

create_prompt "devops" "07" "Networking" \
    "networking_course_complete.rb" "tcp_ip_networking_course.rb" "tls_network_security_course.rb"

create_prompt "devops" "08" "Infrastructure as Code" \
    "infrastructure_as_code_course.rb"

create_prompt "devops" "09" "CI/CD Pipelines" \
    "cicd_pipelines_course.rb"

create_prompt "devops" "10" "Security Fundamentals" \
    "security_fundamentals_course.rb"

# Programming Courses (11-19)
create_prompt "programming" "11" "Python" \
    "python_course.rb" "python_course_enhanced.rb"

create_prompt "programming" "12" "Golang" \
    "golang_course.rb" "golang_concurrency_units.rb"

create_prompt "programming" "13" "JavaScript Node.js" \
    "javascript_nodejs_course.rb"

create_prompt "programming" "14" "TypeScript" \
    "typescript_course.rb"

create_prompt "programming" "15" "Rust" \
    "rust_programming_course.rb"

create_prompt "programming" "16" "React Advanced" \
    "react_advanced_course.rb" "react_advanced_patterns_course.rb"

create_prompt "programming" "17" "GraphQL API" \
    "graphql_api_course.rb"

create_prompt "programming" "18" "Regular Expressions" \
    "regular_expressions_course.rb"

create_prompt "programming" "19" "Bash Shell Scripting" \
    "bash_shell_scripting_course.rb"

# IIT JEE Courses (20-26)
create_prompt "iit_jee" "20" "Inorganic Chemistry" \
    "iit_jee/iit_jee_inorganic_chemistry.rb" \
    "inorganic/inorganic_interactive_units.rb" \
    "inorganic/module_04_s_block.rb" \
    "inorganic/module_05_p_block_part1.rb" \
    "inorganic/module_05_p_block_part2.rb" \
    "inorganic/module_06_d_block.rb" \
    "inorganic/module_06_p_block_groups_15_18.rb" \
    "inorganic/module_07_d_f_block_elements.rb" \
    "inorganic/module_08_coordination_compounds.rb"

create_prompt "iit_jee" "21" "Organic Chemistry" \
    "iit_jee/iit_jee_organic_chemistry_formulas.rb"

create_prompt "iit_jee" "22" "Physical Chemistry" \
    "iit_jee/iit_jee_physical_chemistry_formulas.rb"

create_prompt "iit_jee" "23" "Mathematics Algebra" \
    "iit_jee_mathematics_algebra.rb"

create_prompt "iit_jee" "24" "Mathematics Calculus" \
    "iit_jee_mathematics_calculus.rb"

create_prompt "iit_jee" "25" "Mathematics Trigonometry" \
    "iit_jee_mathematics_trigonometry.rb"

create_prompt "iit_jee" "26" "Calculus Linear Algebra" \
    "calculus_linear_algebra_course.rb"

# Software Engineering (27-38)
create_prompt "software_engineering" "27" "System Design Architecture" \
    "system_design_architecture_course.rb" "system_design_complete.rb"

create_prompt "software_engineering" "28" "Microservices" \
    "microservices_architecture_course.rb"

create_prompt "software_engineering" "29" "Design Patterns" \
    "design_patterns_course.rb"

create_prompt "software_engineering" "30" "Clean Code Refactoring" \
    "clean_code_refactoring_course.rb"

create_prompt "software_engineering" "31" "Testing Masterclass" \
    "testing_masterclass_course.rb"

create_prompt "software_engineering" "32" "Concurrency Programming" \
    "concurrency_programming_course.rb"

create_prompt "software_engineering" "33" "Message Queues" \
    "message_queues_course.rb" "message_queues_event_driven_course.rb"

create_prompt "software_engineering" "34" "Redis Caching" \
    "redis_caching_course.rb"

create_prompt "software_engineering" "35" "Web Performance" \
    "web_performance_course.rb"

create_prompt "software_engineering" "36" "Envoy Proxy" \
    "envoy_course_complete.rb"

# Data Science (39-40)
create_prompt "data_science" "39" "Machine Learning" \
    "machine_learning_fundamentals_course.rb"

create_prompt "data_science" "40" "Pandas NumPy" \
    "pandas_numpy_data_science_course.rb"

# Interview Prep (41-42)
create_prompt "interview_prep" "41" "Coding Interview" \
    "coding_interview_course.rb"

create_prompt "interview_prep" "42" "Data Structures Algorithms" \
    "data_structures_algorithms_course.rb"

# Other (43-44)
create_prompt "other" "43" "UPSC Civil Services" \
    "upsc_civil_services_course.rb"

create_prompt "other" "44" "Linux Browser" \
    "linux_browser_course.rb" "linux_browser_course_part2.rb" "linux_browser_course_part3.rb"

echo ""
echo "✅ Generated 41 new prompt files (+ 3 existing = 44 total)"
echo ""
echo "📊 Summary:"
echo "   DevOps: 10 prompts"
echo "   Programming: 9 prompts"
echo "   IIT JEE: 7 prompts"
echo "   Software Engineering: 10 prompts"
echo "   Data Science: 2 prompts"
echo "   Interview Prep: 2 prompts"
echo "   Other: 2 prompts"
echo ""
echo "🚀 Ready to use! Check each category folder."
