#!/usr/bin/env python3
"""
Remove reflection and checkpoint exercises from all course YAML files
"""

import os
import sys
import yaml
from pathlib import Path

def process_yaml_file(filepath):
    """
    Remove reflection and checkpoint exercises from a YAML file
    Returns True if file was modified, False otherwise
    """
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)

        if not data or 'exercises' not in data:
            return False

        original_exercises = data['exercises']
        if not original_exercises:
            return False

        # Filter out reflection and checkpoint exercises
        filtered_exercises = [
            ex for ex in original_exercises
            if ex.get('type') not in ['reflection', 'checkpoint']
        ]

        # If nothing was removed, skip
        if len(filtered_exercises) == len(original_exercises):
            return False

        # Renumber sequence_order
        for idx, exercise in enumerate(filtered_exercises, start=1):
            exercise['sequence_order'] = idx

        # Update the data
        data['exercises'] = filtered_exercises

        # Write back to file
        with open(filepath, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, default_flow_style=False, allow_unicode=True, sort_keys=False)

        removed_count = len(original_exercises) - len(filtered_exercises)
        return True, removed_count

    except Exception as e:
        print(f"Error processing {filepath}: {e}")
        return False, 0

def main():
    """
    Main function to process all YAML files
    """
    base_path = Path('/home/user/idlecampus-backend/db/seeds')

    # Find all YAML files in microlessons directories
    yaml_files = list(base_path.rglob('microlessons/*.yml'))

    print(f"Found {len(yaml_files)} YAML files to process")
    print("=" * 80)

    modified_count = 0
    total_removed = 0

    for yaml_file in yaml_files:
        result = process_yaml_file(yaml_file)
        if result and result[0]:
            modified_count += 1
            removed = result[1]
            total_removed += removed
            print(f"✓ {yaml_file.name}: removed {removed} exercises")

    print("=" * 80)
    print(f"\nSummary:")
    print(f"  Files modified: {modified_count}")
    print(f"  Total exercises removed: {total_removed}")
    print(f"  Files unchanged: {len(yaml_files) - modified_count}")

if __name__ == "__main__":
    main()
