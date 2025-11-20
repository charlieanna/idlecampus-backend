#!/usr/bin/env ruby
# Script to update all prompt files with correct information from MASTER_COURSE_INDEX.md

# Course definitions from MASTER_COURSE_INDEX.md
COURSES = {
  # DevOps
  '04_postgresql' => {
    name: 'PostgreSQL Fundamentals',
    files: ['postgresql_course.rb', 'postgresql_lessons.rb'],
    language: 'sql'
  },
  '05_git_version_control' => {
    name: 'Git & Version Control',
    files: ['git_version_control_course.rb'],
    language: 'bash'
  },
  '06_aws' => {
    name: 'AWS',
    files: ['aws_course_complete.rb'],
    language: 'bash'
  },
  '07_networking' => {
    name: 'Networking Fundamentals',
    files: ['networking_course_complete.rb', 'tcp_ip_networking_course.rb', 'tls_network_security_course.rb'],
    language: 'bash'
  },
  '08_infrastructure_as_code' => {
    name: 'Infrastructure as Code',
    files: ['infrastructure_as_code_course.rb'],
    language: 'hcl'
  },
  '09_cicd_pipelines' => {
    name: 'CI/CD Pipelines',
    files: ['cicd_pipelines_course.rb'],
    language: 'yaml'
  },
  '10_security_fundamentals' => {
    name: 'Security Fundamentals',
    files: ['security_fundamentals_course.rb'],
    language: 'bash'
  },

  # Programming
  '11_python' => {
    name: 'Python Programming',
    files: ['python_course.rb', 'python_course_enhanced.rb', 'python_advanced_course.rb'],
    language: 'python'
  },
  '12_golang' => {
    name: 'Golang',
    files: ['golang_course.rb', 'golang_course_enhanced.rb', 'golang_concurrency_units.rb'],
    language: 'go'
  },
  '13_javascript_node.js' => {
    name: 'JavaScript/Node.js',
    files: ['javascript_nodejs_course.rb'],
    language: 'javascript'
  },
  '14_typescript' => {
    name: 'TypeScript',
    files: ['typescript_course.rb'],
    language: 'typescript'
  },
  '15_rust' => {
    name: 'Rust Programming',
    files: ['rust_programming_course.rb'],
    language: 'rust'
  },
  '16_react_advanced' => {
    name: 'React Advanced',
    files: ['react_advanced_course.rb', 'react_advanced_patterns_course.rb'],
    language: 'javascript'
  },
  '17_graphql_api' => {
    name: 'GraphQL API',
    files: ['graphql_api_course.rb'],
    language: 'graphql'
  },
  '18_regular_expressions' => {
    name: 'Regular Expressions',
    files: ['regular_expressions_course.rb'],
    language: 'regex'
  },
  '19_bash_shell_scripting' => {
    name: 'Bash Shell Scripting',
    files: ['bash_shell_scripting_course.rb'],
    language: 'bash'
  },

  # IIT JEE
  '20_inorganic_chemistry' => {
    name: 'IIT JEE - Inorganic Chemistry',
    files: ['iit_jee/iit_jee_inorganic_chemistry.rb', 'inorganic/inorganic_interactive_units.rb',
            'inorganic/module_04_s_block.rb', 'inorganic/module_05_p_block_part1.rb',
            'inorganic/module_05_p_block_part2.rb', 'inorganic/module_06_d_block.rb',
            'inorganic/module_06_p_block_groups_15_18.rb', 'inorganic/module_07_d_f_block_elements.rb',
            'inorganic/module_08_coordination_compounds.rb'],
    language: 'text'
  },
  '21_organic_chemistry' => {
    name: 'IIT JEE - Organic Chemistry',
    files: ['iit_jee/iit_jee_organic_chemistry_formulas.rb'],
    language: 'text'
  },
  '22_physical_chemistry' => {
    name: 'IIT JEE - Physical Chemistry',
    files: ['iit_jee/iit_jee_physical_chemistry_formulas.rb'],
    language: 'text'
  },
  '23_mathematics_algebra' => {
    name: 'IIT JEE - Mathematics (Algebra)',
    files: ['iit_jee_mathematics_algebra.rb'],
    language: 'text'
  },
  '24_mathematics_calculus' => {
    name: 'IIT JEE - Mathematics (Calculus)',
    files: ['iit_jee_mathematics_calculus.rb'],
    language: 'text'
  },
  '25_mathematics_trigonometry' => {
    name: 'IIT JEE - Mathematics (Trigonometry)',
    files: ['iit_jee_mathematics_trigonometry.rb'],
    language: 'text'
  },
  '26_calculus_linear_algebra' => {
    name: 'Calculus & Linear Algebra',
    files: ['calculus_linear_algebra_course.rb'],
    language: 'text'
  },

  # Software Engineering
  '27_system_design_architecture' => {
    name: 'System Design & Architecture',
    files: ['system_design_architecture_course.rb', 'system_design_complete.rb'],
    language: 'text'
  },
  '28_microservices' => {
    name: 'Microservices Architecture',
    files: ['microservices_architecture_course.rb'],
    language: 'text'
  },
  '29_design_patterns' => {
    name: 'Design Patterns',
    files: ['design_patterns_course.rb'],
    language: 'text'
  },
  '30_clean_code_refactoring' => {
    name: 'Clean Code & Refactoring',
    files: ['clean_code_refactoring_course.rb'],
    language: 'text'
  },
  '31_testing_masterclass' => {
    name: 'Testing Masterclass',
    files: ['testing_masterclass_course.rb'],
    language: 'text'
  },
  '32_concurrency_programming' => {
    name: 'Concurrency Programming',
    files: ['concurrency_programming_course.rb'],
    language: 'text'
  },
  '33_message_queues' => {
    name: 'Message Queues',
    files: ['message_queues_course.rb', 'message_queues_event_driven_course.rb'],
    language: 'text'
  },
  '34_redis_caching' => {
    name: 'Redis & Caching',
    files: ['redis_caching_course.rb'],
    language: 'text'
  },
  '35_web_performance' => {
    name: 'Web Performance',
    files: ['web_performance_course.rb'],
    language: 'text'
  },
  '36_envoy_proxy' => {
    name: 'Envoy Proxy',
    files: ['envoy_course_complete.rb'],
    language: 'text'
  },

  # Data Science
  '39_machine_learning' => {
    name: 'Machine Learning Fundamentals',
    files: ['machine_learning_fundamentals_course.rb'],
    language: 'python'
  },
  '40_pandas_numpy' => {
    name: 'Pandas & NumPy Data Science',
    files: ['pandas_numpy_data_science_course.rb'],
    language: 'python'
  },

  # Interview Prep
  '41_coding_interview' => {
    name: 'Coding Interview Prep',
    files: ['coding_interview_course.rb'],
    language: 'python'
  },
  '42_data_structures_algorithms' => {
    name: 'Data Structures & Algorithms',
    files: ['data_structures_algorithms_course.rb'],
    language: 'python'
  },

  # Other
  '43_upsc_civil_services' => {
    name: 'UPSC Civil Services',
    files: ['upsc_civil_services_course.rb'],
    language: 'text'
  },
  '44_linux_browser' => {
    name: 'Linux Browser Course',
    files: ['linux_browser_course.rb', 'linux_browser_course_part2.rb', 'linux_browser_course_part3.rb'],
    language: 'bash'
  }
}

def generate_prompt(course_name, files, language)
  files_list = files.map { |f| "□ #{f}" }.join("\n")

  <<~PROMPT
=======================================
MICROLESSON GENERATOR - #{course_name.upcase}
=======================================

[READY TO USE: Copy this entire prompt + attach all files listed below to GPT-5 Pro]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: ATTACH THESE FILES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

From: idlecampus/backend/db/seeds/

#{files_list}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: PASTE THIS PROMPT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You are an expert educational content designer and Ruby on Rails developer.

I've attached seed files for the #{course_name} course. Convert them into microlesson format.

# TASK

Split each attached seed file into very small microlessons with exercises.

# MICROLESSON RULES

**Size:** 1 concept per microlesson, 2-3 minutes each

**Content Structure:**
```markdown
# [Title] 🚀

## What is [concept]?
[2-3 sentence explanation]

## Syntax/Command
\`\`\`#{language}
[code or command]
\`\`\`

## Example
\`\`\`#{language}
[specific example with output]
\`\`\`

## Key Points
- Point 1
- Point 2
- Point 3
```

# EXERCISE RULES

**Count based on difficulty:**
- Easy: 1-2 exercises
- Medium: 2-3 exercises
- Hard: 3-4 exercises

**Types:**
1. **terminal**: CLI commands (for terminal/CLI courses)
2. **mcq**: Multiple choice with 4 options
3. **code**: Programming challenges (for coding courses)

**Progressive Hints (3 per exercise):**
- Hint 1: Gentle nudge
- Hint 2: More specific
- Hint 3: Nearly the answer

# PREREQUISITES

Analyze content to infer dependencies:
- First lesson: `prerequisite_ids: []`
- Sequential lessons: Previous lesson as prerequisite
- Advanced topics: Multiple prerequisites

# OUTPUT FORMAT

Generate complete Ruby seed files:

```ruby
# db/seeds/microlessons/[module_name]_microlessons.rb
# AUTO-GENERATED from [original_file].rb

puts "Creating Microlessons for [Module Name]..."

module_var = CourseModule.find_by(slug: '[module-slug]')

# === MICROLESSON 1: [Title] ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: '[Short, clear title]',
  content: <<~MARKDOWN,
    # [Title] 🚀

    ## What is [concept]?

    [Explanation]

    ## Syntax/Command

    \`\`\`#{language}
    [code or command]
    \`\`\`

    ## Example

    \`\`\`#{language}
    [example]
    \`\`\`

    [Expected output or result]

    ## Key Points

    - Point 1
    - Point 2
    - Point 3
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['concept1', 'concept2'],
  prerequisite_ids: []
)

# Exercise 1: [Type]
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: '[terminal|mcq|code]',
  sequence_order: 1,
  exercise_data: {
    # For terminal:
    command: '[exact command]',
    description: '[what to do]',

    # For MCQ:
    question: '[question]',
    options: ['[correct]', '[wrong]', '[wrong]', '[wrong]'],
    correct_answer: 0,
    explanation: '[why]',

    # For code:
    starter_code: '[starter]',
    solution: '[solution]',
    test_cases: [{input: '...', expected: '...'}],

    # All types:
    difficulty: 'easy',
    hints: [
      '[Hint 1: gentle]',
      '[Hint 2: specific]',
      '[Hint 3: nearly answer]'
    ]
  }
)

# [More microlessons...]

puts "✓ Created [N] microlessons for [Module Name]"
```

# QUALITY CHECKLIST

For EACH microlesson:
- [ ] Covers exactly 1 concept
- [ ] 2-3 minutes estimated time
- [ ] Clear, practical examples
- [ ] Exercises test understanding
- [ ] MCQ options are plausible
- [ ] Hints progress logically
- [ ] Prerequisites make sense
- [ ] Ruby syntax is valid

# OUTPUT INSTRUCTIONS

For each seed file, generate output with clear labels:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FILE: [module_name]_microlessons.rb
FROM: [original_file].rb
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Complete Ruby code here]
```

After all files, provide summary:

```
=== GENERATION SUMMARY ===

Course: #{course_name}

Files Generated:
1. [file1]_microlessons.rb
   - Original units: X
   - Microlessons created: Y
   - Total exercises: Z
   - Prerequisites linked: N

[... for each file ...]

Grand Total:
- Microlessons: XX
- Exercises: YY
- Terminal: ZZ
- MCQ: AA
- Code: BB
```

# NOW GENERATE

Process all attached seed files and generate microlesson files following all rules above.

START GENERATION NOW.
  PROMPT
end

# Generate all prompts
COURSES.each do |file_key, config|
  # Determine directory and filename
  parts = file_key.split('_')
  number = parts.shift
  category = case number
  when '01', '02', '03', '04', '05', '06', '07', '08', '09', '10'
    'devops'
  when '11', '12', '13', '14', '15', '16', '17', '18', '19'
    'programming'
  when '20', '21', '22', '23', '24', '25', '26'
    'iit_jee'
  when '27', '28', '29', '30', '31', '32', '33', '34', '35', '36'
    'software_engineering'
  when '39', '40'
    'data_science'
  when '41', '42'
    'interview_prep'
  when '43', '44'
    'other'
  end

  filename = "#{file_key}_prompt.txt"
  filepath = File.join(File.dirname(__FILE__), category, filename)

  content = generate_prompt(config[:name], config[:files], config[:language])

  File.write(filepath, content)
  puts "Generated: #{filepath}"
end

puts "\n✓ All prompts generated successfully!"
