# frozen_string_literal: true

puts "🌱 Starting UPSC seed data..."

# ============================================
# UPSC SUBJECTS
# ============================================

puts "\n📚 Creating UPSC Subjects..."

prelims_gs = Upsc::Subject.create!(
  name: "General Studies Paper I (Prelims)",
  code: "PRELIMS_GS",
  exam_type: "prelims",
  paper_number: 1,
  total_marks: 200,
  duration_minutes: 120,
  description: "Current events of national and international importance, History of India and Indian National Movement, Indian and World Geography, Indian Polity and Governance, Economic and Social Development, Environmental Ecology, Biodiversity and Climate Change, General Science",
  is_optional: false,
  is_active: true,
  order_index: 1,
  color_code: "#3B82F6"
)

csat = Upsc::Subject.create!(
  name: "CSAT (Prelims)",
  code: "CSAT",
  exam_type: "prelims",
  paper_number: 2,
  total_marks: 200,
  duration_minutes: 120,
  description: "Comprehension, Interpersonal skills, Logical reasoning and analytical ability, Decision-making and problem-solving, General mental ability, Basic numeracy, Data interpretation",
  is_optional: false,
  is_active: true,
  order_index: 2,
  color_code: "#10B981"
)

mains_gs1 = Upsc::Subject.create!(
  name: "General Studies Paper I (Mains)",
  code: "MAINS_GS1",
  exam_type: "mains",
  paper_number: 1,
  total_marks: 250,
  duration_minutes: 180,
  description: "Indian Heritage and Culture, History and Geography of the World and Society",
  is_optional: false,
  is_active: true,
  order_index: 3,
  color_code: "#F59E0B"
)

mains_gs2 = Upsc::Subject.create!(
  name: "General Studies Paper II (Mains)",
  code: "MAINS_GS2",
  exam_type: "mains",
  paper_number: 2,
  total_marks: 250,
  duration_minutes: 180,
  description: "Governance, Constitution, Polity, Social Justice and International Relations",
  is_optional: false,
  is_active: true,
  order_index: 4,
  color_code: "#EF4444"
)

mains_gs3 = Upsc::Subject.create!(
  name: "General Studies Paper III (Mains)",
  code: "MAINS_GS3",
  exam_type: "mains",
  paper_number: 3,
  total_marks: 250,
  duration_minutes: 180,
  description: "Technology, Economic Development, Bio-diversity, Environment, Security and Disaster Management",
  is_optional: false,
  is_active: true,
  order_index: 5,
  color_code: "#8B5CF6"
)

mains_gs4 = Upsc::Subject.create!(
  name: "General Studies Paper IV (Mains)",
  code: "MAINS_GS4",
  exam_type: "mains",
  paper_number: 4,
  total_marks: 250,
  duration_minutes: 180,
  description: "Ethics, Integrity and Aptitude",
  is_optional: false,
  is_active: true,
  order_index: 6,
  color_code: "#EC4899"
)

essay = Upsc::Subject.create!(
  name: "Essay (Mains)",
  code: "ESSAY",
  exam_type: "mains",
  total_marks: 250,
  duration_minutes: 180,
  description: "Essay Paper - Candidates may be required to write essays on multiple topics",
  is_optional: false,
  is_active: true,
  order_index: 7,
  color_code: "#06B6D4"
)

# Optional subjects
optional_history = Upsc::Subject.create!(
  name: "History (Optional)",
  code: "OPT_HISTORY",
  exam_type: "mains",
  total_marks: 500,
  description: "History Optional - Paper I and Paper II",
  is_optional: true,
  is_active: true,
  order_index: 8,
  color_code: "#F97316"
)

optional_geography = Upsc::Subject.create!(
  name: "Geography (Optional)",
  code: "OPT_GEOGRAPHY",
  exam_type: "mains",
  total_marks: 500,
  description: "Geography Optional - Paper I and Paper II",
  is_optional: true,
  is_active: true,
  order_index: 9,
  color_code: "#14B8A6"
)

puts "✅ Created #{Upsc::Subject.count} subjects"

# ============================================
# TOPICS FOR PRELIMS GS
# ============================================

puts "\n📖 Creating Topics for Prelims GS..."

# History Topics
history_topic = prelims_gs.topics.create!(
  name: "Indian History",
  slug: "indian-history",
  description: "Ancient, Medieval and Modern Indian History",
  difficulty_level: "intermediate",
  estimated_hours: 80,
  is_high_yield: true,
  pyq_frequency: 25,
  learning_objectives: ["Understand chronology of Indian history", "Analyze major historical events", "Connect historical developments with present"],
  order_index: 1
)

ancient_history = history_topic.child_topics.create!(
  upsc_subject_id: prelims_gs.id,
  name: "Ancient India",
  slug: "ancient-india",
  description: "Indus Valley Civilization to Gupta Period",
  difficulty_level: "beginner",
  estimated_hours: 20,
  is_high_yield: true,
  pyq_frequency: 8,
  tags: ["indus_valley", "mauryas", "guptas"],
  order_index: 1
)

modern_history = history_topic.child_topics.create!(
  upsc_subject_id: prelims_gs.id,
  name: "Modern India (1757-1947)",
  slug: "modern-india",
  description: "British Rule and Indian National Movement",
  difficulty_level: "intermediate",
  estimated_hours: 35,
  is_high_yield: true,
  pyq_frequency: 15,
  tags: ["british_rule", "freedom_struggle", "gandhiji"],
  order_index: 2
)

# Polity Topics
polity_topic = prelims_gs.topics.create!(
  name: "Indian Polity",
  slug: "indian-polity",
  description: "Constitution, Governance, Political System",
  difficulty_level: "intermediate",
  estimated_hours: 100,
  is_high_yield: true,
  pyq_frequency: 30,
  learning_objectives: ["Understand Indian Constitution", "Know structure of government", "Analyze constitutional provisions"],
  order_index: 2
)

constitution_basics = polity_topic.child_topics.create!(
  upsc_subject_id: prelims_gs.id,
  name: "Indian Constitution Basics",
  slug: "constitution-basics",
  description: "Making, Features, Preamble, Fundamental Rights & Duties",
  difficulty_level: "beginner",
  estimated_hours: 25,
  is_high_yield: true,
  pyq_frequency: 12,
  tags: ["constitution", "fundamental_rights", "dpsp"],
  order_index: 1
)

# Geography Topics
geography_topic = prelims_gs.topics.create!(
  name: "Indian Geography",
  slug: "indian-geography",
  description: "Physical, Economic and Social Geography of India",
  difficulty_level: "intermediate",
  estimated_hours: 60,
  is_high_yield: true,
  pyq_frequency: 20,
  order_index: 3
)

# Economy Topics
economy_topic = prelims_gs.topics.create!(
  name: "Indian Economy",
  slug: "indian-economy",
  description: "Economic Development, Planning, Budgeting, Banking",
  difficulty_level: "intermediate",
  estimated_hours: 70,
  is_high_yield: true,
  pyq_frequency: 22,
  order_index: 4
)

# Environment Topics
environment_topic = prelims_gs.topics.create!(
  name: "Environment & Ecology",
  slug: "environment-ecology",
  description: "Biodiversity, Climate Change, Environmental Issues",
  difficulty_level: "intermediate",
  estimated_hours: 50,
  is_high_yield: true,
  pyq_frequency: 18,
  order_index: 5
)

# Science & Technology
science_topic = prelims_gs.topics.create!(
  name: "Science & Technology",
  slug: "science-technology",
  description: "General Science, Space, IT, Biotechnology",
  difficulty_level: "intermediate",
  estimated_hours: 40,
  is_high_yield: true,
  pyq_frequency: 15,
  order_index: 6
)

# Current Affairs
current_affairs_topic = prelims_gs.topics.create!(
  name: "Current Affairs",
  slug: "current-affairs",
  description: "National and International Current Events",
  difficulty_level: "beginner",
  estimated_hours: 120,
  is_high_yield: true,
  pyq_frequency: 35,
  order_index: 7
)

puts "✅ Created #{Upsc::Topic.count} topics"

# ============================================
# SAMPLE MCQ QUESTIONS
# ============================================

puts "\n❓ Creating Sample Questions..."

# Question 1 - History
q1 = Upsc::Question.create!(
  upsc_subject: prelims_gs,
  upsc_topic: modern_history,
  question_type: "mcq",
  difficulty: "medium",
  marks: 2,
  negative_marks: 0.66,
  time_limit_seconds: 90,
  question_text: "The Quit India Movement was launched in which year?",
  options: [
    {id: 'A', text: '1940', is_correct: false},
    {id: 'B', text: '1942', is_correct: true},
    {id: 'C', text: '1945', is_correct: false},
    {id: 'D', text: '1947', is_correct: false}
  ],
  correct_answer: 'B',
  explanation: "The Quit India Movement was launched by Mahatma Gandhi on 8 August 1942, during World War II, demanding an end to British rule of India.",
  pyq_year: 2019,
  pyq_paper: "Prelims GS",
  tags: ["freedom_struggle", "gandhi", "pyq"],
  relevance_score: 90,
  status: "active"
)

# Question 2 - Polity
q2 = Upsc::Question.create!(
  upsc_subject: prelims_gs,
  upsc_topic: constitution_basics,
  question_type: "mcq",
  difficulty: "easy",
  marks: 2,
  negative_marks: 0.66,
  time_limit_seconds: 60,
  question_text: "Which Article of the Indian Constitution abolishes untouchability?",
  options: [
    {id: 'A', text: 'Article 14', is_correct: false},
    {id: 'B', text: 'Article 15', is_correct: false},
    {id: 'C', text: 'Article 17', is_correct: true},
    {id: 'D', text: 'Article 21', is_correct: false}
  ],
  correct_answer: 'C',
  explanation: "Article 17 of the Indian Constitution abolishes untouchability and forbids its practice in any form.",
  hints: ["Look for social reform articles", "Part III of Constitution"],
  tags: ["fundamental_rights", "social_justice"],
  relevance_score: 85,
  status: "active"
)

# Question 3 - Environment (MSQ)
q3 = Upsc::Question.create!(
  upsc_subject: prelims_gs,
  upsc_topic: environment_topic,
  question_type: "msq",
  difficulty: "hard",
  marks: 2,
  negative_marks: 0.66,
  time_limit_seconds: 120,
  question_text: "Which of the following are Biodiversity Hotspots in India? (Select all that apply)",
  options: [
    {id: 'A', text: 'Western Ghats', is_correct: true},
    {id: 'B', text: 'Eastern Ghats', is_correct: false},
    {id: 'C', text: 'Himalayas', is_correct: true},
    {id: 'D', text: 'Indo-Burma Region', is_correct: true}
  ],
  correct_answer: 'A,C,D',
  explanation: "India has four biodiversity hotspots: Western Ghats, Eastern Himalayas, Indo-Burma region, and Sundaland (Nicobar Islands).",
  pyq_year: 2020,
  pyq_paper: "Prelims GS",
  tags: ["biodiversity", "environment", "pyq"],
  relevance_score: 88,
  status: "active"
)

puts "✅ Created #{Upsc::Question.count} sample questions"

# ============================================
# MOCK TEST
# ============================================

puts "\n📝 Creating Mock Test..."

mock_test = Upsc::Test.create!(
  upsc_subject: prelims_gs,
  test_type: "mock_prelims",
  title: "UPSC Prelims Mock Test 1 - 2025",
  description: "Full-length mock test covering all Prelims GS topics",
  instructions: "This test contains 100 questions. Each question carries 2 marks. There is negative marking of 0.66 marks for each wrong answer. Total time: 120 minutes.",
  duration_minutes: 120,
  total_marks: 200,
  passing_marks: 70,
  negative_marking_enabled: true,
  negative_marking_ratio: 0.33,
  is_live: true,
  is_free: true,
  scheduled_at: 1.day.ago,
  starts_at: 1.day.ago,
  ends_at: 30.days.from_now,
  shuffle_questions: true,
  shuffle_options: true,
  show_answers_after_submit: true,
  difficulty_level: "medium",
  tags: ["prelims", "mock", "full_length"]
)

# Add questions to test
mock_test.add_questions([q1.id, q2.id, q3.id], 2)

puts "✅ Created mock test with #{mock_test.questions.count} questions"

# ============================================
# WRITING QUESTIONS
# ============================================

puts "\n✍️  Creating Writing Questions..."

essay_q1 = Upsc::WritingQuestion.create!(
  upsc_subject: mains_gs1,
  upsc_topic: modern_history,
  question_type: "analytical",
  question_text: "Critically analyze the role of Subhas Chandra Bose in India's freedom struggle and his contribution to nation-building.",
  question_context: "Subhas Chandra Bose was one of the most prominent leaders of Indian independence movement.",
  word_limit: 250,
  marks: 15,
  time_limit_minutes: 20,
  difficulty: "medium",
  directive_keywords: ["critically analyze", "role", "contribution"],
  evaluation_criteria: {
    relevance: 20,
    structure: 15,
    content_depth: 30,
    examples: 15,
    language: 10,
    critical_analysis: 10
  },
  key_points: [
    "Formation of Forward Bloc",
    "INA (Azad Hind Fauj) formation",
    "Differences with Gandhi's approach",
    "Legacy and impact"
  ],
  suggested_structure: {
    introduction: "Brief intro about Bose (50 words)",
    body: "Main contributions and analysis (150 words)",
    conclusion: "Overall assessment (50 words)"
  },
  tags: ["freedom_struggle", "leaders", "analytical"],
  relevance_score: 85
)

case_study_q1 = Upsc::WritingQuestion.create!(
  upsc_subject: mains_gs4,
  question_type: "case_study",
  question_text: "You are a District Collector. A communal riot breaks out in your district. Some influential politicians are instigating people. The police force is inadequate. What ethical dilemmas do you face and how will you handle the situation?",
  word_limit: 200,
  marks: 10,
  time_limit_minutes: 15,
  difficulty: "hard",
  directive_keywords: ["ethical dilemmas", "handle situation"],
  evaluation_criteria: {
    understanding: 15,
    ethical_issues_identification: 25,
    stakeholders_analysis: 15,
    solution: 25,
    conclusion: 20
  },
  key_points: [
    "Identify stakeholders",
    "List ethical issues",
    "Consider options",
    "Propose solution with reasoning"
  ],
  tags: ["ethics", "case_study", "administration"],
  relevance_score: 92
)

# Daily Question
daily_q = Upsc::WritingQuestion.create!(
  upsc_subject: mains_gs2,
  question_type: "general",
  question_text: "Discuss the challenges faced by India in implementing the Goods and Services Tax (GST) and suggest measures to address them.",
  word_limit: 150,
  marks: 10,
  time_limit_minutes: 12,
  difficulty: "medium",
  directive_keywords: ["discuss", "challenges", "suggest measures"],
  current_affairs_date: Date.current,
  tags: ["gst", "economy", "governance", "daily_question"],
  relevance_score: 88
)

puts "✅ Created #{Upsc::WritingQuestion.count} writing questions"

# ============================================
# NEWS ARTICLES
# ============================================

puts "\n📰 Creating Sample News Articles..."

news1 = Upsc::NewsArticle.create!(
  title: "India's GDP Growth Reaches 7.2% in Q2 FY 2025",
  slug: "india-gdp-growth-q2-fy2025",
  summary: "India's economy showed strong growth momentum with GDP expanding at 7.2% in the second quarter, driven by manufacturing and services sectors.",
  full_content: "India's Gross Domestic Product (GDP) grew at 7.2% in the July-September quarter of FY 2025, surpassing economist expectations... [Full analysis of growth drivers, sector-wise performance, government initiatives, and implications for UPSC perspective]",
  source: "Ministry of Statistics",
  published_date: Date.current,
  categories: ["economy", "current_affairs", "gdp"],
  tags: ["gdp", "economic_growth", "manufacturing", "services_sector"],
  relevance_score: 90,
  importance_level: "high",
  is_featured: true,
  exam_perspective: "Important for GS3 - Economy questions. Understand growth drivers, sectoral performance, and policy implications.",
  key_points: [
    "GDP growth at 7.2%",
    "Manufacturing sector growth at 8.1%",
    "Services sector contribution increased",
    "Government's economic policies impact"
  ],
  related_subject_ids: [mains_gs3.id],
  status: "published"
)

news2 = Upsc::NewsArticle.create!(
  title: "Supreme Court Landmark Judgment on Right to Privacy",
  slug: "supreme-court-right-to-privacy-judgment",
  summary: "The Supreme Court delivered a historic judgment recognizing Right to Privacy as a Fundamental Right under Article 21.",
  full_content: "In a landmark 9-judge bench decision, the Supreme Court unanimously held that Right to Privacy is intrinsic to life and personal liberty... [Complete judgment analysis, implications, and UPSC relevance]",
  source: "Supreme Court of India",
  published_date: 2.days.ago,
  categories: ["polity", "judiciary", "constitutional_law"],
  tags: ["supreme_court", "fundamental_rights", "privacy", "article_21"],
  relevance_score: 95,
  importance_level: "critical",
  is_featured: true,
  exam_perspective: "Crucial for GS2 - Polity and Constitution. Link with Fundamental Rights, judicial activism, and recent developments.",
  key_points: [
    "Right to Privacy declared Fundamental Right",
    "Part of Article 21 - Right to Life",
    "Overruled previous judgments",
    "Implications for Aadhaar and data protection"
  ],
  related_subject_ids: [mains_gs2.id, prelims_gs.id],
  related_topic_ids: [constitution_basics.id],
  status: "published"
)

puts "✅ Created #{Upsc::NewsArticle.count} news articles"

# ============================================
# SUMMARY
# ============================================

puts "\n" + "="*50
puts "🎉 UPSC Seed Data Creation Complete!"
puts "="*50
puts "\n📊 Summary:"
puts "  Subjects:          #{Upsc::Subject.count}"
puts "  Topics:            #{Upsc::Topic.count}"
puts "  Questions:         #{Upsc::Question.count}"
puts "  Tests:             #{Upsc::Test.count}"
puts "  Writing Questions: #{Upsc::WritingQuestion.count}"
puts "  News Articles:     #{Upsc::NewsArticle.count}"
puts "\n✅ Database is ready for UPSC preparation platform!"
puts "\nNext steps:"
puts "1. Test in Rails console: rails console"
puts "2. Create API controllers"
puts "3. Build frontend components"
puts "\nExample console commands:"
puts "  Upsc::Subject.all"
puts "  Upsc::Topic.root_topics"
puts "  Upsc::Question.pyqs"
puts "  Upsc::Test.live"
