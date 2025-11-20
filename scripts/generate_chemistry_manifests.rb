#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'

# Define the consolidated chemistry courses
chemistry_courses = {
  'physical-chemistry-complete' => {
    'title' => 'Physical Chemistry - JEE/NEET Complete',
    'description' => 'Master physical chemistry with comprehensive coverage of atomic structure, thermodynamics, equilibrium, kinetics, and electrochemistry. Perfect preparation for JEE, NEET, and undergraduate chemistry.',
    'estimated_hours' => 20,
    'level' => 'intermediate',
    'prerequisites' => [
      'Class 11/12 Mathematics (algebra, calculus basics)',
      'Basic chemistry concepts'
    ],
    'learning_outcomes' => [
      'Solve numerical problems in thermodynamics and equilibrium',
      'Apply rate laws and Arrhenius equation',
      'Master electrochemistry calculations',
      'Understand quantum mechanics and atomic structure',
      'Analyze colligative properties and solutions'
    ],
    'tags' => ['chemistry', 'physical-chemistry', 'JEE', 'NEET', 'thermodynamics', 'equilibrium', 'electrochemistry'],
    'exam_prep' => ['JEE Advanced', 'JEE Main', 'NEET'],
    'modules' => [
      {
        'slug' => 'atomic-structure-bonding',
        'title' => 'Atomic Structure & Chemical Bonding',
        'description' => 'Quantum mechanics, electronic configuration, VSEPR theory, and molecular orbital theory',
        'order' => 1,
        'estimated_hours' => 4,
        'source_courses' => ['atomic-structure-quantum-mechanics', 'chemical-bonding-molecular-structure']
      },
      {
        'slug' => 'states-of-matter-solutions',
        'title' => 'States of Matter & Solutions',
        'description' => 'Gas laws, liquid state, solid state chemistry, and colligative properties',
        'order' => 2,
        'estimated_hours' => 5,
        'source_courses' => ['states-of-matter', 'solutions-colligative-properties', 'solid-state-chemistry']
      },
      {
        'slug' => 'equilibrium-kinetics',
        'title' => 'Chemical Equilibrium & Kinetics',
        'description' => 'Chemical equilibrium, ionic equilibrium, and chemical kinetics',
        'order' => 3,
        'estimated_hours' => 5,
        'source_courses' => ['chemical-equilibrium', 'ionic-equilibrium', 'chemical-kinetics']
      },
      {
        'slug' => 'electrochemistry-redox',
        'title' => 'Electrochemistry & Redox Reactions',
        'description' => 'Redox reactions, electrochemical cells, and Nernst equation',
        'order' => 4,
        'estimated_hours' => 3,
        'source_courses' => ['redox-reactions', 'electrochemistry']
      },
      {
        'slug' => 'thermodynamics',
        'title' => 'Thermodynamics',
        'description' => 'Laws of thermodynamics, enthalpy, and Hess\'s law',
        'order' => 5,
        'estimated_hours' => 1,
        'source_courses' => ['module-01-thermodynamics-part1']
      },
      {
        'slug' => 'surface-chemistry',
        'title' => 'Surface Chemistry',
        'description' => 'Colloids, adsorption, and catalysis',
        'order' => 6,
        'estimated_hours' => 3,
        'source_courses' => ['surface-chemistry']
      },
      {
        'slug' => 'mole-concept',
        'title' => 'Mole Concept & Stoichiometry',
        'description' => 'Mole calculations, limiting reagent, and percentage yield',
        'order' => 7,
        'estimated_hours' => 2,
        'source_courses' => ['mole-concept-stoichiometry']
      }
    ]
  },

  'inorganic-chemistry-complete' => {
    'title' => 'Inorganic Chemistry - JEE/NEET Complete',
    'description' => 'Complete inorganic chemistry covering periodic trends, s/p/d/f block elements, coordination compounds, and qualitative analysis. JEE and NEET focused content.',
    'estimated_hours' => 18,
    'level' => 'intermediate',
    'prerequisites' => [
      'Basic chemistry concepts',
      'Periodic table familiarity'
    ],
    'learning_outcomes' => [
      'Master periodic trends and element properties',
      'Understand coordination chemistry (VBT, CFT)',
      'Analyze s, p, d, f block element reactions',
      'Perform qualitative analysis of salts',
      'Apply metallurgy concepts'
    ],
    'tags' => ['chemistry', 'inorganic-chemistry', 'JEE', 'NEET', 'periodic-table', 'coordination-compounds', 'metallurgy'],
    'exam_prep' => ['JEE Advanced', 'JEE Main', 'NEET'],
    'modules' => [
      {
        'slug' => 'periodic-table',
        'title' => 'Periodic Table & Classification',
        'description' => 'Periodic trends, properties, and element classification',
        'order' => 1,
        'estimated_hours' => 3,
        'source_courses' => ['periodic-table-periodicity']
      },
      {
        'slug' => 's-block-elements',
        'title' => 'S-Block Elements',
        'description' => 'Alkali and alkaline earth metals - properties and reactions',
        'order' => 2,
        'estimated_hours' => 3,
        'source_courses' => ['s-block-elements']
      },
      {
        'slug' => 'p-block-elements',
        'title' => 'P-Block Elements',
        'description' => 'Groups 13-18 elements, properties, and reactions',
        'order' => 3,
        'estimated_hours' => 5,
        'source_courses' => ['p-block-elements', 'module-05-p-block-part2', 'p-block-groups-15-18']
      },
      {
        'slug' => 'd-f-block-elements',
        'title' => 'D & F Block Elements',
        'description' => 'Transition metals, lanthanoids, and actinoids',
        'order' => 4,
        'estimated_hours' => 4,
        'source_courses' => ['d-block-transition-elements', 'd-f-block-elements', 'f-block-elements']
      },
      {
        'slug' => 'coordination-compounds',
        'title' => 'Coordination Compounds',
        'description' => 'Nomenclature, VBT, CFT, and isomerism',
        'order' => 5,
        'estimated_hours' => 2,
        'source_courses' => ['coordination-compounds']
      },
      {
        'slug' => 'hydrogen-chemistry',
        'title' => 'Hydrogen Chemistry',
        'description' => 'Hydrides, water, hydrogen peroxide, and heavy water',
        'order' => 6,
        'estimated_hours' => 2,
        'source_courses' => ['hydrogen-chemistry']
      },
      {
        'slug' => 'metallurgy-analysis',
        'title' => 'Metallurgy & Qualitative Analysis',
        'description' => 'Metal extraction, Ellingham diagrams, and salt analysis',
        'order' => 7,
        'estimated_hours' => 4,
        'source_courses' => ['metallurgy-extraction', 'qualitative-analysis']
      },
      {
        'slug' => 'environmental-chemistry',
        'title' => 'Environmental Chemistry',
        'description' => 'Pollution, green chemistry, and environmental issues',
        'order' => 8,
        'estimated_hours' => 2,
        'source_courses' => ['environmental-chemistry']
      }
    ]
  },

  'organic-chemistry-complete' => {
    'title' => 'Organic Chemistry - JEE/NEET Complete',
    'description' => 'Comprehensive organic chemistry from stereochemistry to reaction mechanisms. Master aromatic chemistry, functional groups, and named reactions for JEE/NEET success.',
    'estimated_hours' => 25,
    'level' => 'intermediate-to-advanced',
    'prerequisites' => [
      'Basic organic chemistry concepts',
      'Understanding of chemical bonding'
    ],
    'learning_outcomes' => [
      'Master stereochemistry and optical isomerism',
      'Understand reaction mechanisms (SN1, SN2, E1, E2, EAS)',
      'Analyze functional group chemistry',
      'Apply name reactions in synthesis',
      'Solve structural elucidation problems'
    ],
    'tags' => ['chemistry', 'organic-chemistry', 'JEE', 'NEET', 'stereochemistry', 'mechanisms', 'functional-groups'],
    'exam_prep' => ['JEE Advanced', 'JEE Main', 'NEET'],
    'modules' => [
      {
        'slug' => 'stereochemistry',
        'title' => 'Stereochemistry',
        'description' => 'Chirality, optical isomerism, conformations, and enantiomers',
        'order' => 1,
        'estimated_hours' => 4,
        'source_courses' => ['module-06-stereochemistry']
      },
      {
        'slug' => 'aromatic-chemistry',
        'title' => 'Aromatic Chemistry',
        'description' => 'Benzene, EAS reactions, directing effects, and aromaticity',
        'order' => 2,
        'estimated_hours' => 5,
        'source_courses' => ['module-07-aromatic-compounds']
      },
      {
        'slug' => 'haloalkanes-haloarenes',
        'title' => 'Haloalkanes & Haloarenes',
        'description' => 'SN1, SN2, E1, E2 mechanisms, and nucleophilic substitution',
        'order' => 3,
        'estimated_hours' => 2,
        'source_courses' => ['haloalkanes-haloarenes']
      },
      {
        'slug' => 'alcohols-phenols-ethers',
        'title' => 'Alcohols, Phenols & Ethers',
        'description' => 'Preparation, reactions, and acidity of oxygen-containing compounds',
        'order' => 4,
        'estimated_hours' => 2,
        'source_courses' => ['alcohols-phenols-ethers']
      },
      {
        'slug' => 'carbonyl-compounds',
        'title' => 'Aldehydes & Ketones',
        'description' => 'Nucleophilic addition reactions and Grignard reactions',
        'order' => 5,
        'estimated_hours' => 2,
        'source_courses' => ['aldehydes-ketones']
      },
      {
        'slug' => 'carboxylic-acids',
        'title' => 'Carboxylic Acids & Derivatives',
        'description' => 'Acidity, ester reactions, and comparative reactivity',
        'order' => 6,
        'estimated_hours' => 2,
        'source_courses' => ['carboxylic-acids-derivatives']
      },
      {
        'slug' => 'nitrogen-compounds',
        'title' => 'Amines & Nitrogen Compounds',
        'description' => 'Basicity, diazonium salts, and coupling reactions',
        'order' => 7,
        'estimated_hours' => 2,
        'source_courses' => ['amines']
      },
      {
        'slug' => 'biomolecules',
        'title' => 'Biomolecules',
        'description' => 'Carbohydrates, proteins, vitamins, and nucleic acids',
        'order' => 8,
        'estimated_hours' => 2,
        'source_courses' => ['biomolecules']
      },
      {
        'slug' => 'polymers',
        'title' => 'Polymers',
        'description' => 'Addition/condensation polymerization and synthetic polymers',
        'order' => 9,
        'estimated_hours' => 2,
        'source_courses' => ['polymers']
      },
      {
        'slug' => 'practical-organic',
        'title' => 'Practical Organic Chemistry',
        'description' => 'Lab techniques, purification, and functional group detection',
        'order' => 10,
        'estimated_hours' => 3,
        'source_courses' => ['module-08-practical-organic-chemistry']
      }
    ]
  }
}

# Read source manifests and get lesson lists
def get_lessons_from_course(course_slug)
  manifest_path = "db/seeds/converted_microlessons/#{course_slug}/manifest.yml"
  return [] unless File.exist?(manifest_path)

  manifest = YAML.load_file(manifest_path)
  lessons = manifest['modules']&.first&.dig('lessons') || []
  lessons
end

# Generate manifest files
chemistry_courses.each do |slug, course_data|
  manifest = {
    'course' => {
      'slug' => slug,
      'title' => course_data['title'],
      'description' => course_data['description'],
      'estimated_hours' => course_data['estimated_hours'],
      'level' => course_data['level'],
      'prerequisites' => course_data['prerequisites'],
      'learning_outcomes' => course_data['learning_outcomes'],
      'tags' => course_data['tags'],
      'exam_prep' => course_data['exam_prep'],
      'related_courses' => chemistry_courses.keys.reject { |k| k == slug },
      'recommended_next' => chemistry_courses.keys.find { |k| k != slug }
    },
    'modules' => []
  }

  # Add modules with lessons from source courses
  course_data['modules'].each do |module_data|
    lessons = []

    # Get lessons from all source courses for this module
    module_data['source_courses'].each do |source_course|
      course_lessons = get_lessons_from_course(source_course)
      lessons.concat(course_lessons)
    end

    manifest['modules'] << {
      'slug' => module_data['slug'],
      'title' => module_data['title'],
      'description' => module_data['description'],
      'order' => module_data['order'],
      'estimated_hours' => module_data['estimated_hours'],
      'lessons' => lessons
    }
  end

  # Write manifest file
  output_dir = "db/seeds/consolidated_courses/#{slug}"
  FileUtils.mkdir_p(output_dir) unless Dir.exist?(output_dir)

  output_file = File.join(output_dir, 'manifest.yml')
  File.write(output_file, manifest.to_yaml)

  total_lessons = manifest['modules'].sum { |m| m['lessons'].count }
  puts "✓ Generated #{slug} manifest"
  puts "  - #{manifest['modules'].count} modules"
  puts "  - #{total_lessons} lessons"
  puts
end

puts "\n✓ All chemistry course manifests generated successfully!"
