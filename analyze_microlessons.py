#!/usr/bin/env python3
import yaml
import os
from pathlib import Path
from collections import defaultdict

# Directory containing microlesson files
LESSONS_DIR = "/home/user/idlecampus-backend/db/seeds/security_complete_enhanced/microlessons"

# Track issues
issues = defaultdict(list)
stats = {
    'total_files': 0,
    'files_with_exercises': 0,
    'files_without_exercises': 0,
    'mcq_with_placeholder_options': 0,
    'mcq_without_question': 0,
    'mcq_without_explanation': 0,
    'generic_exercises': 0,
    'terminal_exercises_incomplete': 0,
    'sandbox_exercises_incomplete': 0,
    'missing_content': 0,
    'yaml_errors': 0
}

def analyze_lesson(file_path):
    """Analyze a single lesson file"""
    filename = os.path.basename(file_path)

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)

        stats['total_files'] += 1
        file_issues = []

        # Check basic structure
        if not data:
            stats['yaml_errors'] += 1
            file_issues.append("Empty or invalid YAML")
            issues['yaml_errors'].append(filename)
            return file_issues

        # Check required fields
        required_fields = ['slug', 'title', 'content_md', 'exercises']
        missing_fields = [f for f in required_fields if f not in data]
        if missing_fields:
            file_issues.append(f"Missing fields: {', '.join(missing_fields)}")

        # Check content quality
        if 'content_md' in data:
            content = data['content_md']
            if not content or len(content.strip()) < 100:
                stats['missing_content'] += 1
                file_issues.append("Content is missing or too short")

        # Check exercises
        if 'exercises' not in data or not data['exercises']:
            stats['files_without_exercises'] += 1
            file_issues.append("No exercises found")
            issues['no_exercises'].append(filename)
        else:
            stats['files_with_exercises'] += 1
            exercises = data['exercises']

            for i, exercise in enumerate(exercises):
                ex_type = exercise.get('type', 'unknown')

                # Check MCQ exercises
                if ex_type == 'mcq':
                    mcq_issues = []

                    # Check for placeholder options (A, B, C, D)
                    options = exercise.get('options', [])
                    if options == ['A', 'B', 'C', 'D']:
                        stats['mcq_with_placeholder_options'] += 1
                        mcq_issues.append("Placeholder options (A, B, C, D)")
                        issues['placeholder_mcq'].append(filename)

                    # Check for missing question
                    question = exercise.get('question', '')
                    if not question or question == "Which statement is correct for this topic?":
                        stats['mcq_without_question'] += 1
                        mcq_issues.append("Generic/missing question")
                        issues['generic_mcq_question'].append(filename)

                    # Check for generic explanation
                    explanation = exercise.get('explanation', '')
                    if explanation == "Revisit the definitions and tool outputs for accuracy.":
                        stats['mcq_without_explanation'] += 1
                        mcq_issues.append("Generic explanation")
                        issues['generic_explanation'].append(filename)

                    # Check for missing options
                    if not options:
                        mcq_issues.append("No options provided")

                    # Check for correct answer
                    if 'correct_answer_index' not in exercise:
                        mcq_issues.append("No correct answer specified")

                    if mcq_issues:
                        file_issues.append(f"MCQ #{i+1}: {', '.join(mcq_issues)}")

                # Check terminal exercises
                elif ex_type == 'terminal':
                    if 'description' not in exercise or not exercise['description']:
                        stats['terminal_exercises_incomplete'] += 1
                        file_issues.append(f"Terminal exercise #{i+1}: Missing description")
                        issues['incomplete_terminal'].append(filename)

                # Check sandbox exercises
                elif ex_type == 'sandbox':
                    # Sandbox exercises might be minimal, but track them
                    if len(exercise.keys()) <= 1:  # Only has 'type'
                        stats['sandbox_exercises_incomplete'] += 1
                        file_issues.append(f"Sandbox exercise #{i+1}: Minimal/incomplete")
                        issues['incomplete_sandbox'].append(filename)

                # Check reflection exercises
                elif ex_type == 'reflection':
                    prompt = exercise.get('prompt', '')
                    if prompt == "Where does this show up in real incidents or reviews? What would you check first?":
                        stats['generic_exercises'] += 1
                        file_issues.append(f"Reflection #{i+1}: Generic prompt")
                        issues['generic_reflection'].append(filename)

                # Check checkpoint exercises
                elif ex_type == 'checkpoint':
                    prompt = exercise.get('prompt', '')
                    if prompt == "Write the exact steps/commands/config needed to apply this concept.":
                        stats['generic_exercises'] += 1
                        file_issues.append(f"Checkpoint #{i+1}: Generic prompt")
                        issues['generic_checkpoint'].append(filename)

        return file_issues

    except yaml.YAMLError as e:
        stats['yaml_errors'] += 1
        issues['yaml_errors'].append(filename)
        return [f"YAML parsing error: {str(e)}"]
    except Exception as e:
        return [f"Error: {str(e)}"]

def main():
    """Main analysis function"""
    all_files_issues = {}

    # Get all YAML files
    yaml_files = sorted(Path(LESSONS_DIR).glob('*.yml'))

    print(f"Analyzing {len(yaml_files)} microlesson files...\n")

    # Analyze each file
    for file_path in yaml_files:
        file_issues = analyze_lesson(str(file_path))
        if file_issues:
            all_files_issues[file_path.name] = file_issues

    # Print summary statistics
    print("=" * 80)
    print("MICROLESSON REVIEW REPORT")
    print("=" * 80)
    print()

    print("OVERALL STATISTICS:")
    print(f"  Total files reviewed: {stats['total_files']}")
    print(f"  Files with exercises: {stats['files_with_exercises']}")
    print(f"  Files without exercises: {stats['files_without_exercises']}")
    print()

    print("EXERCISE QUALITY ISSUES:")
    print(f"  MCQ with placeholder options (A,B,C,D): {stats['mcq_with_placeholder_options']}")
    print(f"  MCQ with generic/missing questions: {stats['mcq_without_question']}")
    print(f"  MCQ with generic explanations: {stats['mcq_without_explanation']}")
    print(f"  Generic reflection/checkpoint prompts: {stats['generic_exercises']}")
    print(f"  Incomplete terminal exercises: {stats['terminal_exercises_incomplete']}")
    print(f"  Incomplete sandbox exercises: {stats['sandbox_exercises_incomplete']}")
    print()

    print("CONTENT ISSUES:")
    print(f"  Missing or insufficient content: {stats['missing_content']}")
    print(f"  YAML parsing errors: {stats['yaml_errors']}")
    print()

    # Print pattern summary
    print("=" * 80)
    print("PATTERN ANALYSIS:")
    print("=" * 80)
    print()

    for issue_type, files in sorted(issues.items()):
        if files:
            print(f"{issue_type.upper().replace('_', ' ')} ({len(files)} files)")
    print()

    # Print sample of files with issues
    print("=" * 80)
    print("SAMPLE FILES WITH ISSUES (First 15):")
    print("=" * 80)
    print()

    count = 0
    for filename, file_issues in sorted(all_files_issues.items()):
        if count >= 15:
            break
        print(f"\n{filename}:")
        for issue in file_issues:
            print(f"  - {issue}")
        count += 1

    if len(all_files_issues) > 15:
        print(f"\n... and {len(all_files_issues) - 15} more files with issues")

    # Estimate files needing fixes
    print()
    print("=" * 80)
    print("REPAIR ESTIMATE:")
    print("=" * 80)
    print()

    files_needing_fixes = len(all_files_issues)
    print(f"Files needing fixes: {files_needing_fixes} out of {stats['total_files']} ({files_needing_fixes/stats['total_files']*100:.1f}%)")

    # Categorize severity
    critical = []
    moderate = []
    minor = []

    for filename, file_issues in all_files_issues.items():
        issue_count = len(file_issues)
        has_placeholder = any('Placeholder options' in issue for issue in file_issues)
        has_no_exercises = any('No exercises' in issue for issue in file_issues)

        if has_no_exercises or issue_count >= 5:
            critical.append(filename)
        elif has_placeholder or issue_count >= 3:
            moderate.append(filename)
        else:
            minor.append(filename)

    print(f"\nSeverity breakdown:")
    print(f"  Critical (no exercises or 5+ issues): {len(critical)}")
    print(f"  Moderate (placeholder MCQs or 3-4 issues): {len(moderate)}")
    print(f"  Minor (1-2 issues): {len(minor)}")

    print()
    print("=" * 80)
    print("RECOMMENDATIONS:")
    print("=" * 80)
    print()
    print("1. Replace all placeholder MCQ options (A,B,C,D) with real, content-specific options")
    print("2. Create specific, meaningful questions for each MCQ based on lesson content")
    print("3. Write detailed explanations for each MCQ answer")
    print("4. Customize reflection and checkpoint prompts to match lesson topics")
    print("5. Complete terminal exercise descriptions with specific tasks")
    print("6. Review and enhance sandbox exercises with clear objectives")
    print("7. Ensure all exercises test concepts actually covered in the lesson content")
    print()

if __name__ == '__main__':
    main()
