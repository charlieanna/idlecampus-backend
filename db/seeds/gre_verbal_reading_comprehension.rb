# GRE Verbal Reasoning - Reading Comprehension
# This seed file creates lessons, passages, and questions for Reading Comprehension

puts "Creating GRE Reading Comprehension content..."

course = Course.find_by!(slug: 'gre-verbal-reasoning')
reading_module = course.course_modules.find_by!(slug: 'reading-comprehension')

# Create quiz for the module
quiz = Quiz.find_or_create_by!(
  course_module: reading_module,
  title: "#{reading_module.title} Practice"
) do |q|
  q.description = "Practice questions for Reading Comprehension"
  q.time_limit_minutes = 60
  q.passing_score = 70
end

# Lesson 1: Introduction to Reading Comprehension
lesson_1 = CourseLesson.find_or_create_by!(
  course_module: reading_module,
  slug: 'intro-reading-comprehension'
) do |l|
  l.title = 'Introduction to GRE Reading Comprehension'
  l.sequence_order = 1
  l.reading_time_minutes = 20
  l.key_concepts = ['Passage types', 'Question types', 'Reading strategies', 'Time management']
  l.content = <<~MD
    # Introduction to GRE Reading Comprehension

    ## Overview
    The Reading Comprehension section of the GRE tests your ability to:
    - Understand, analyze, and apply information from written passages
    - Synthesize information from multiple sources
    - Identify relationships among concepts and words
    - Analyze the structure of a text

    ## Passage Types
    You'll encounter three main types of passages:

    ### 1. Argumentative Passages
    Present a claim and supporting evidence. You must evaluate the strength of arguments.

    ### 2. Expository Passages
    Explain concepts, ideas, or phenomena objectively.

    ### 3. Narrative Passages
    Tell a story or describe events chronologically.

    ## Question Types

    ### Main Idea Questions
    Ask about the primary purpose or central theme of the passage.
    - "The primary purpose of the passage is to..."
    - "Which of the following best describes the main idea?"

    ### Detail Questions
    Ask about specific information explicitly stated in the passage.
    - "According to the passage..."
    - "The author mentions X in order to..."

    ### Inference Questions
    Require you to draw conclusions based on information in the passage.
    - "It can be inferred from the passage that..."
    - "The passage suggests that..."

    ### Tone/Attitude Questions
    Ask about the author's attitude or tone toward the subject.
    - "The author's tone can best be described as..."
    - "The author's attitude toward X is..."

    ### Function Questions
    Ask why the author included specific information.
    - "The author mentions X in order to..."
    - "The function of the second paragraph is to..."

    ## Reading Strategies

    ### Active Reading
    1. **Preview**: Scan the passage for structure and main topics
    2. **Read actively**: Engage with the text, note main ideas
    3. **Annotate**: Mark key points, transitions, and important details
    4. **Summarize**: After each paragraph, briefly note the main point

    ### Time Management
    - Short passages (1 paragraph): ~3 minutes total
    - Medium passages (2-3 paragraphs): ~6-7 minutes total
    - Long passages (4+ paragraphs): ~8-10 minutes total

    ### Answer Strategy
    1. Read the question carefully
    2. Identify question type
    3. Return to relevant passage section
    4. Predict an answer before looking at choices
    5. Eliminate wrong answers
    6. Select the best answer
  MD
  l.content_sections = [
    {
      anchor: 'passage-types',
      title: 'Passage Types',
      content: 'Understanding argumentative, expository, and narrative passages'
    },
    {
      anchor: 'question-types',
      title: 'Question Types',
      content: 'Main idea, detail, inference, tone, and function questions'
    },
    {
      anchor: 'reading-strategies',
      title: 'Reading Strategies',
      content: 'Active reading and time management techniques'
    }
  ]
end

puts "✓ Created lesson: #{lesson_1.title}"

# Lesson 2: Science Passages
lesson_2 = CourseLesson.find_or_create_by!(
  course_module: reading_module,
  slug: 'science-passages'
) do |l|
  l.title = 'Science Passages'
  l.sequence_order = 2
  l.reading_time_minutes = 30
  l.key_concepts = ['Scientific writing', 'Technical vocabulary', 'Experimental design', 'Data interpretation']
  l.content = <<~MD
    # Science Passages

    ## Characteristics of Science Passages
    Science passages on the GRE cover topics from:
    - Biology
    - Chemistry
    - Physics
    - Earth sciences
    - Psychology
    - Medicine

    ## Common Structures

    ### Hypothesis-Driven
    1. Problem/Question
    2. Hypothesis
    3. Methodology
    4. Results
    5. Conclusion/Implications

    ### Descriptive/Explanatory
    1. Phenomenon introduction
    2. Background/Context
    3. Explanation of mechanisms
    4. Examples or applications
    5. Significance or implications

    ## Key Skills

    ### Understanding Technical Terms
    - Use context clues for unfamiliar terms
    - Focus on the function/role rather than memorizing definitions
    - Note key terms that appear multiple times

    ### Following Experimental Logic
    - Identify the research question
    - Understand the methodology
    - Interpret results and data
    - Evaluate conclusions

    ### Analyzing Cause and Effect
    - Track causal relationships
    - Distinguish correlation from causation
    - Identify supporting evidence

    ## Example Passage Structure

    **Paragraph 1**: Introduction to phenomenon
    - What is being studied?
    - Why is it important?

    **Paragraph 2**: Previous understanding/theories
    - What did scientists previously believe?
    - What gaps existed?

    **Paragraph 3**: New findings/research
    - What did the new study discover?
    - How was it conducted?

    **Paragraph 4**: Implications
    - What does this mean?
    - What questions remain?

    ## Common Question Types for Science Passages

    1. **Main purpose**: "The primary purpose of the passage is to..."
    2. **Supporting details**: "According to the passage, which of the following is true about X?"
    3. **Inference**: "The passage suggests that..."
    4. **Function**: "The author mentions X primarily in order to..."
    5. **Strengthening/Weakening**: "Which of the following, if true, would most strengthen the author's argument?"
  MD
  l.content_sections = [
    {
      anchor: 'science-structures',
      title: 'Science Passage Structures',
      content: 'Common organizational patterns in scientific writing'
    },
    {
      anchor: 'technical-vocabulary',
      title: 'Handling Technical Vocabulary',
      content: 'Strategies for understanding unfamiliar terms'
    },
    {
      anchor: 'experimental-logic',
      title: 'Experimental Logic',
      content: 'Following hypothesis, methodology, and conclusions'
    }
  ]
end

puts "✓ Created lesson: #{lesson_2.title}"

# Passage 1: Neuroplasticity (Science - Biology)
passage_1_text = <<~PASSAGE
  Neuroplasticity, the brain's ability to reorganize itself by forming new neural connections throughout life, challenges the long-held belief that the brain's structure is relatively fixed after childhood. This capacity for change allows neurons in the brain to compensate for injury and disease and to adjust their activities in response to new situations or changes in their environment. Research in the past two decades has demonstrated that the brain continues to create new neural pathways and alter existing ones to adapt to new experiences, learn new information, and create new memories.

  The mechanisms underlying neuroplasticity operate at various levels, from cellular changes involving individual neurons to large-scale cortical remapping. At the cellular level, synaptic plasticity—the strengthening or weakening of synapses—plays a crucial role. When neurons are frequently stimulated, the connections between them strengthen through a process called long-term potentiation. Conversely, connections that are rarely used may weaken or disappear through synaptic pruning. This "use it or lose it" principle explains why practice and repetition are essential for learning and why skills deteriorate without continued use.

  Clinical applications of neuroplasticity have proven particularly valuable in rehabilitation medicine. Stroke patients, for instance, can recover lost functions by training other parts of the brain to take over the roles of damaged areas. Physical therapy exploits neuroplasticity by encouraging patients to repeatedly practice movements, thereby strengthening neural pathways. Similarly, cognitive behavioral therapy leverages neuroplasticity to help patients with mental health conditions rewire thought patterns. These applications demonstrate that neuroplasticity is not merely a theoretical concept but a practical foundation for therapeutic interventions.

  However, neuroplasticity is not uniformly beneficial. The same mechanisms that allow for positive changes can also reinforce negative patterns. Chronic pain conditions, for example, can result from maladaptive plasticity, where the nervous system becomes hypersensitive to pain signals. Additionally, while the brain retains plasticity throughout life, the degree of plasticity generally decreases with age, making it more challenging—though not impossible—for older adults to learn new skills or recover from brain injuries compared to younger individuals.
PASSAGE

# Question 1: Main Idea
q1 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "Which of the following best describes the primary purpose of the passage?",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "To argue that neuroplasticity makes the brain immune to age-related decline", correct: false },
    { text: "To explain the mechanisms of neuroplasticity and discuss its applications and limitations", correct: true },
    { text: "To prove that neuroplasticity only occurs during childhood development", correct: false },
    { text: "To describe how neuroplasticity can cure all neurological disorders", correct: false },
    { text: "To challenge the existence of neuroplasticity in adult brains", correct: false }
  ]
  q.difficulty = 0.0
  q.discrimination = 1.3
  q.guessing = 0.2
  q.explanation = "The passage provides a comprehensive overview of neuroplasticity, explaining what it is (paragraph 1), how it works at different levels (paragraph 2), its clinical applications (paragraph 3), and its limitations (paragraph 4). This makes option B the best answer. Options A and D overstate the benefits, C contradicts the passage, and E is the opposite of what's stated."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q1,
  course_lesson: lesson_2,
  relevance_weight: 95,
  section_anchor: 'science-structures'
)

# Question 2: Detail Question
q2 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "According to the passage, synaptic pruning involves:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "The creation of new neural pathways in damaged brain areas", correct: false },
    { text: "The weakening or elimination of rarely used neural connections", correct: true },
    { text: "The strengthening of synapses through frequent stimulation", correct: false },
    { text: "The reorganization of cortical areas after injury", correct: false },
    { text: "The formation of new neurons in the hippocampus", correct: false }
  ]
  q.difficulty = -0.5
  q.discrimination = 1.5
  q.guessing = 0.2
  q.explanation = "The passage explicitly states in paragraph 2 that 'connections that are rarely used may weaken or disappear through synaptic pruning.' This directly supports option B. Option C describes long-term potentiation, not pruning. The other options describe different aspects of neuroplasticity not related to synaptic pruning."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q2,
  course_lesson: lesson_2,
  relevance_weight: 90,
  section_anchor: 'experimental-logic'
)

# Question 3: Inference Question
q3 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The passage suggests that a musician who stops practicing for several years would most likely experience:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Permanent loss of all musical ability due to complete neural pathway destruction", correct: false },
    { text: "No change in musical ability because skills learned in youth are permanent", correct: false },
    { text: "A decline in musical skills due to weakening of associated neural pathways", correct: true },
    { text: "Enhanced musical ability from allowing the brain to rest", correct: false },
    { text: "Immediate recovery of full ability once practice resumes", correct: false }
  ]
  q.difficulty = 0.5
  q.discrimination = 1.4
  q.guessing = 0.2
  q.explanation = "The passage explains the 'use it or lose it' principle, stating that 'skills deteriorate without continued use' due to synaptic pruning of rarely used connections. This supports option C. Option A is too extreme (permanent loss), B contradicts the passage, D has no support, and E is unrealistic given that weakened pathways would need time to strengthen again."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q3,
  course_lesson: lesson_2,
  relevance_weight: 88,
  section_anchor: 'experimental-logic'
)

# Question 4: Function Question
q4 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The author mentions chronic pain conditions in the final paragraph primarily in order to:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Illustrate that neuroplasticity can have negative consequences", correct: true },
    { text: "Argue that neuroplasticity is primarily harmful to health", correct: false },
    { text: "Explain the main focus of neuroplasticity research", correct: false },
    { text: "Demonstrate that pain is purely psychological", correct: false },
    { text: "Suggest that chronic pain cannot be treated", correct: false }
  ]
  q.difficulty = 0.3
  q.discrimination = 1.2
  q.guessing = 0.2
  q.explanation = "The fourth paragraph discusses limitations of neuroplasticity, introducing the point that it 'is not uniformly beneficial.' Chronic pain is presented as an example of 'maladaptive plasticity,' illustrating how the same mechanisms that enable positive changes can reinforce negative patterns. This supports option A. Option B overgeneralizes, and the other options are not supported by the passage."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q4,
  course_lesson: lesson_2,
  relevance_weight: 85,
  section_anchor: 'science-structures'
)

# Question 5: Application/Strengthening Question
q5 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "Which of the following findings, if true, would most strengthen the claim that physical therapy aids stroke recovery through neuroplasticity?",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Stroke patients who receive physical therapy show no changes in brain structure", correct: false },
    { text: "Brain scans reveal that stroke patients develop new neural connections in undamaged areas during physical therapy", correct: true },
    { text: "Physical therapy is more effective when started immediately after birth", correct: false },
    { text: "All stroke patients recover equally regardless of therapy", correct: false },
    { text: "The brain reaches maximum plasticity in elderly patients", correct: false }
  ]
  q.difficulty = 0.8
  q.discrimination = 1.6
  q.guessing = 0.2
  q.explanation = "The passage states that physical therapy 'exploits neuroplasticity by encouraging patients to repeatedly practice movements, thereby strengthening neural pathways.' Evidence of new neural connections forming in undamaged areas (option B) would directly support this mechanism. Option A would weaken the claim, C is irrelevant to stroke recovery, D would weaken it, and E contradicts the passage's statement that plasticity decreases with age."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q5,
  course_lesson: lesson_2,
  relevance_weight: 92,
  section_anchor: 'experimental-logic'
)

puts "✓ Created 5 questions for Neuroplasticity passage"

# Lesson 3: Humanities Passages
lesson_3 = CourseLesson.find_or_create_by!(
  course_module: reading_module,
  slug: 'humanities-passages'
) do |l|
  l.title = 'Humanities Passages'
  l.sequence_order = 3
  l.reading_time_minutes = 30
  l.key_concepts = ['Literary analysis', 'Historical context', 'Argumentation', 'Author perspective']
  l.content = <<~MD
    # Humanities Passages

    ## Topics Covered
    Humanities passages include:
    - Literature and literary criticism
    - History
    - Philosophy
    - Art history
    - Music theory
    - Cultural studies

    ## Passage Characteristics

    ### Argumentative Nature
    Unlike purely expository science passages, humanities passages often:
    - Present multiple viewpoints
    - Evaluate theories or interpretations
    - Build arguments with evidence
    - Challenge conventional wisdom

    ### Subjective Elements
    - Author's opinions and perspectives
    - Critical analysis and interpretation
    - Value judgments
    - Theoretical frameworks

    ## Common Structures

    ### Chronological
    Traces development over time:
    - Historical events
    - Artistic movements
    - Philosophical evolution

    ### Comparative
    Examines similarities and differences:
    - Between time periods
    - Between artists or thinkers
    - Between theories or approaches

    ### Critical Analysis
    Evaluates a work or idea:
    - Summary of the subject
    - Analysis of strengths
    - Discussion of limitations
    - Author's assessment

    ## Reading Strategies for Humanities

    ### Track the Argument
    1. Identify the thesis or main claim
    2. Note supporting evidence
    3. Look for counterarguments
    4. Understand the conclusion

    ### Understand Context
    - Historical background
    - Cultural setting
    - Intellectual tradition
    - Previous scholarship

    ### Identify Tone and Attitude
    Humanities passages often have stronger authorial voice:
    - Supportive vs. critical
    - Objective vs. subjective
    - Enthusiastic vs. skeptical
    - Balanced vs. one-sided

    ### Recognize Rhetorical Devices
    - Examples and illustrations
    - Analogies and metaphors
    - Rhetorical questions
    - Appeals to authority

    ## Common Question Types

    ### Interpretation Questions
    "According to the author, the significance of X is..."

    ### Tone/Attitude Questions
    "The author's attitude toward Y can best be described as..."

    ### Comparison Questions
    "The passage contrasts X and Y primarily in terms of..."

    ### Purpose Questions
    "The author mentions Z in order to..."

    ### Inference Questions
    "It can be inferred that the author believes..."

    ## Tips for Success

    1. **Don't need prior knowledge**: All information needed is in the passage
    2. **Follow the argument**: Track how ideas connect
    3. **Note transitions**: Words like "however," "moreover," "in contrast"
    4. **Identify the author's stance**: Is the author agreeing, disagreeing, or presenting neutrally?
    5. **Watch for qualifying language**: "may," "might," "could," "some scholars believe"
  MD
  l.content_sections = [
    {
      anchor: 'humanities-characteristics',
      title: 'Humanities Passage Characteristics',
      content: 'Argumentative nature and subjective elements'
    },
    {
      anchor: 'common-structures',
      title: 'Common Passage Structures',
      content: 'Chronological, comparative, and critical analysis formats'
    },
    {
      anchor: 'reading-strategies',
      title: 'Reading Strategies',
      content: 'Tracking arguments and identifying tone'
    }
  ]
end

puts "✓ Created lesson: #{lesson_3.title}"

# Passage 2: Impressionism (Humanities - Art History)
passage_2_text = <<~PASSAGE
  The emergence of Impressionism in late nineteenth-century France marked not merely a stylistic departure from academic painting but a fundamental reconceptualization of the artistic enterprise itself. Traditional academic art, with its emphasis on historical and mythological subjects rendered in meticulous detail, operated under the assumption that painting should aspire to an idealized representation of reality. The Impressionists, by contrast, sought to capture the ephemeral qualities of light and atmosphere in everyday scenes, prioritizing immediate visual perception over narrative content or moral instruction.

  This shift in artistic priorities necessitated radical innovations in technique. Rather than building up layers of paint to create smooth, imperceptible brushstrokes, Impressionist painters applied paint in visible, often unmixed strokes, allowing colors to blend optically in the viewer's eye rather than on the palette. They abandoned the dark studios of academic tradition in favor of plein-air painting, working outdoors to capture the changing effects of natural light. These technical choices were not merely stylistic preferences but were intrinsically connected to the Impressionists' goal of representing subjective visual experience rather than objective reality.

  The hostile reception that initially greeted Impressionism reveals much about the conservative nature of the nineteenth-century art establishment. Critics derided the paintings as unfinished sketches, mocking the visible brushstrokes and loose composition. The term "Impressionism" itself originated as a pejorative, derived from Claude Monet's painting "Impression, Sunrise." Yet this criticism inadvertently highlighted the movement's most revolutionary aspect: its challenge to the very criteria by which art was evaluated. By rejecting academic standards of finish and detail, Impressionists implicitly argued that artistic value resided not in technical virtuosity or noble subject matter but in authentic expression of perception.

  The long-term influence of Impressionism extended far beyond its immediate stylistic innovations. By legitimizing personal vision and subjective experience as valid artistic concerns, Impressionism paved the way for the diverse range of modern art movements that followed. Post-Impressionism, Expressionism, and eventually abstract art all built upon the Impressionists' fundamental insight that painting need not represent external reality but could instead express the artist's interior experience or purely formal concerns. In this sense, Impressionism's greatest legacy lies not in its particular techniques or aesthetic choices but in its expansion of the conceptual boundaries of art itself.
PASSAGE

# Question 6: Main Idea
q6 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The primary purpose of the passage is to:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Describe the painting techniques used by Impressionist artists", correct: false },
    { text: "Explain why Impressionism was initially rejected by critics", correct: false },
    { text: "Argue that Impressionism represented a fundamental shift in artistic philosophy and had lasting influence", correct: true },
    { text: "Compare Impressionism with Post-Impressionism and abstract art", correct: false },
    { text: "Analyze specific Impressionist paintings in detail", correct: false }
  ]
  q.difficulty = 0.2
  q.discrimination = 1.4
  q.guessing = 0.2
  q.explanation = "The passage discusses Impressionism as more than just a style change—it was a 'fundamental reconceptualization of the artistic enterprise' (paragraph 1) that challenged how art was evaluated (paragraph 3) and influenced later movements (paragraph 4). Option C captures this comprehensive view. Options A and B are too narrow, D is not the focus, and E never occurs in the passage."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q6,
  course_lesson: lesson_3,
  relevance_weight: 95,
  section_anchor: 'common-structures'
)

# Question 7: Detail Question
q7 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "According to the passage, Impressionist painters applied paint in visible, unmixed strokes in order to:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Save time by avoiding the process of mixing colors on a palette", correct: false },
    { text: "Allow colors to blend optically in the viewer's eye", correct: true },
    { text: "Create texture that would be visible from a distance", correct: false },
    { text: "Demonstrate their technical virtuosity to critics", correct: false },
    { text: "Imitate the brushwork of earlier academic painters", correct: false }
  ]
  q.difficulty = -0.3
  q.discrimination = 1.6
  q.guessing = 0.2
  q.explanation = "Paragraph 2 explicitly states that Impressionists 'applied paint in visible, often unmixed strokes, allowing colors to blend optically in the viewer's eye rather than on the palette.' This directly supports option B. The other options are not mentioned or supported by the passage."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q7,
  course_lesson: lesson_3,
  relevance_weight: 88,
  section_anchor: 'reading-strategies'
)

# Question 8: Tone/Attitude
q8 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The author's attitude toward Impressionism can best be described as:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Dismissive of its artistic merit", correct: false },
    { text: "Appreciative of its revolutionary significance", correct: true },
    { text: "Neutral and detached in evaluation", correct: false },
    { text: "Critical of its technical limitations", correct: false },
    { text: "Ambivalent about its lasting influence", correct: false }
  ]
  q.difficulty = 0.4
  q.discrimination = 1.3
  q.guessing = 0.2
  q.explanation = "The author uses positive language throughout: 'fundamental reconceptualization,' 'radical innovations,' 'most revolutionary aspect,' and describes Impressionism's 'greatest legacy' in expanding art's boundaries. This indicates appreciation for its significance (option B). The author shows no dismissiveness (A), is not neutral (C), doesn't criticize technique (D), and expresses no ambivalence (E)."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q8,
  course_lesson: lesson_3,
  relevance_weight: 92,
  section_anchor: 'reading-strategies'
)

# Question 9: Inference
q9 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The passage suggests that nineteenth-century academic painting was characterized by all of the following EXCEPT:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Emphasis on historical and mythological subjects", correct: false },
    { text: "Meticulous attention to detail", correct: false },
    { text: "Smooth, imperceptible brushstrokes", correct: false },
    { text: "Work completed primarily outdoors", correct: true },
    { text: "Aspiration to idealized representation", correct: false }
  ]
  q.difficulty = 0.6
  q.discrimination = 1.5
  q.guessing = 0.2
  q.explanation = "The passage states that academic art featured historical/mythological subjects (paragraph 1), meticulous detail (paragraph 1), smooth brushstrokes (paragraph 2), and idealized representation (paragraph 1). However, it notes that Impressionists 'abandoned the dark studios of academic tradition in favor of plein-air painting,' implying academic painters worked in studios, not outdoors. Thus D is the exception."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q9,
  course_lesson: lesson_3,
  relevance_weight: 87,
  section_anchor: 'common-structures'
)

# Question 10: Function
q10 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The author mentions Post-Impressionism, Expressionism, and abstract art in the final paragraph primarily to:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Argue that these movements were superior to Impressionism", correct: false },
    { text: "Illustrate the range of movements influenced by Impressionism's conceptual innovations", correct: true },
    { text: "Suggest that Impressionism was merely a transitional phase", correct: false },
    { text: "Compare the techniques of different artistic movements", correct: false },
    { text: "Explain why Impressionism eventually declined in popularity", correct: false }
  ]
  q.difficulty = 0.5
  q.discrimination = 1.4
  q.guessing = 0.2
  q.explanation = "The final paragraph discusses Impressionism's 'long-term influence' and states these movements 'all built upon the Impressionists' fundamental insight.' These examples illustrate how Impressionism influenced later art (option B). The author doesn't rank movements (A), doesn't diminish Impressionism (C), doesn't compare techniques (D), and doesn't discuss decline (E)."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q10,
  course_lesson: lesson_3,
  relevance_weight: 90,
  section_anchor: 'common-structures'
)

puts "✓ Created 5 questions for Impressionism passage"

# Lesson 4: Social Sciences Passages
lesson_4 = CourseLesson.find_or_create_by!(
  course_module: reading_module,
  slug: 'social-sciences-passages'
) do |l|
  l.title = 'Social Sciences Passages'
  l.sequence_order = 4
  l.reading_time_minutes = 30
  l.key_concepts = ['Research methodology', 'Data interpretation', 'Theory application', 'Social phenomena']
  l.content = <<~MD
    # Social Sciences Passages

    ## Topics Covered
    Social science passages include:
    - Psychology
    - Sociology
    - Economics
    - Political science
    - Anthropology
    - Linguistics
    - Education

    ## Passage Characteristics

    ### Empirical Research
    Many passages discuss:
    - Studies and experiments
    - Survey data
    - Statistical findings
    - Research methodologies

    ### Theoretical Frameworks
    - Explanation of theories
    - Application to phenomena
    - Comparison of approaches
    - Critique of existing models

    ### Real-World Applications
    - Policy implications
    - Social issues
    - Behavioral patterns
    - Cultural practices

    ## Common Structures

    ### Research Report Format
    1. **Introduction**: Problem/question
    2. **Background**: Previous research
    3. **Methodology**: How study was conducted
    4. **Results**: What was found
    5. **Discussion**: Implications and significance

    ### Theory Explanation
    1. **Introduction**: Concept or theory
    2. **Development**: How theory evolved
    3. **Application**: Examples in practice
    4. **Evaluation**: Strengths and limitations

    ### Issue Analysis
    1. **Problem statement**: Social issue or phenomenon
    2. **Causes**: Factors contributing to issue
    3. **Effects**: Consequences or implications
    4. **Solutions/Perspectives**: Various approaches

    ## Reading Strategies

    ### Identify the Research Question
    - What are researchers trying to understand?
    - What problem are they addressing?
    - What hypothesis are they testing?

    ### Understand Methodology
    - How was data collected?
    - What was the sample size?
    - What variables were measured?
    - What were the controls?

    ### Interpret Results Carefully
    - Distinguish between correlation and causation
    - Note qualifiers ("suggests," "may indicate," "appears to")
    - Look for limitations acknowledged
    - Consider alternative explanations

    ### Track Multiple Perspectives
    Social science passages often present:
    - Competing theories
    - Different schools of thought
    - Conflicting research findings
    - Various policy approaches

    ## Common Question Types

    ### Main Idea
    "The primary purpose of the passage is to..."

    ### Supporting Detail
    "According to the passage, the study found that..."

    ### Inference
    "The passage suggests that..."

    ### Methodology
    "The researchers controlled for X in order to..."

    ### Application
    "Which of the following scenarios best exemplifies the concept described?"

    ### Strengthening/Weakening
    "Which finding would most undermine the author's conclusion?"

    ## Key Considerations

    ### Causation vs. Correlation
    - Correlation: Two things occur together
    - Causation: One thing causes another
    - Social science research often finds correlation but cannot always prove causation

    ### Sample Size and Generalization
    - Larger samples → more generalizable
    - Representative samples → wider application
    - Specific populations → limited applicability

    ### Confounding Variables
    - Other factors that might explain results
    - Alternative explanations to consider
    - Controls used to isolate effects

    ### Operational Definitions
    - How abstract concepts are measured
    - Example: "Intelligence" measured by IQ test
    - Different measures → different results

    ## Tips for Success

    1. **No specialized knowledge required**: All information provided in passage
    2. **Focus on logic of argument**: How conclusions follow from evidence
    3. **Note limitations**: What researchers acknowledge they cannot claim
    4. **Consider scope**: Population studied, setting, time period
    5. **Watch for hedging language**: "may," "suggests," "appears to indicate"
  MD
  l.content_sections = [
    {
      anchor: 'research-structure',
      title: 'Research Passage Structure',
      content: 'Understanding empirical research format'
    },
    {
      anchor: 'methodology-interpretation',
      title: 'Interpreting Methodology and Results',
      content: 'How to read research findings critically'
    },
    {
      anchor: 'causation-correlation',
      title: 'Causation vs. Correlation',
      content: 'Distinguishing between correlation and causal relationships'
    }
  ]
end

puts "✓ Created lesson: #{lesson_4.title}"

# Passage 3: Behavioral Economics (Social Science)
passage_3_text = <<~PASSAGE
  Traditional economic theory assumes that individuals make rational decisions aimed at maximizing their utility, carefully weighing costs and benefits before acting. Behavioral economics, a field that emerged in the late twentieth century, challenges this assumption by incorporating insights from psychology to explain why people often make decisions that appear economically irrational. Rather than dismissing such behavior as random errors, behavioral economists argue that these "irrational" choices follow predictable patterns rooted in cognitive biases and heuristics—mental shortcuts that usually serve us well but can lead to systematic errors in judgment.

  One of the most influential concepts in behavioral economics is loss aversion, the tendency for people to feel the pain of losing something more acutely than the pleasure of gaining something of equal value. Experiments have consistently demonstrated that individuals demand roughly twice as much compensation to give up an object they own as they would be willing to pay to acquire it. This asymmetry has profound implications for economic behavior: people may irrationally hold onto losing investments rather than sell them, a phenomenon known as the "disposition effect," or they may reject beneficial trades simply to avoid the psychological pain of loss.

  Another cognitive bias extensively studied in behavioral economics is the framing effect, whereby the way information is presented influences decision-making even when the objective content remains identical. Research by psychologists Daniel Kahneman and Amos Tversky demonstrated that people respond differently to choices framed in terms of gains versus losses. In a famous experiment, participants chose between medical treatments described either by survival rates or mortality rates. Although the statistical information was equivalent, participants were more likely to choose treatments described in terms of survival rates, revealing that the mere framing of information can override rational analysis of objective data.

  The practical applications of behavioral economics extend across numerous domains. In public policy, "nudging"—designing choice environments to guide people toward beneficial decisions while preserving freedom of choice—has been used to increase retirement savings rates, organ donation registrations, and healthy food choices. In marketing, understanding cognitive biases helps companies design pricing strategies and product displays. However, critics caution that behavioral economics can be misused to manipulate rather than help consumers, and that policymakers must consider ethical implications when applying these insights. Moreover, some economists argue that while behavioral economics identifies interesting anomalies, traditional rational choice theory remains valid for predicting aggregate market behavior, as individual biases may cancel out at the population level.
PASSAGE

# Question 11: Main Idea
q11 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "Which of the following best describes the main purpose of the passage?",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "To prove that traditional economic theory is completely invalid", correct: false },
    { text: "To explain how behavioral economics identifies patterns in seemingly irrational behavior and discuss its applications", correct: true },
    { text: "To argue that all economic decisions are based on cognitive biases", correct: false },
    { text: "To describe the history of behavioral economics as a discipline", correct: false },
    { text: "To advocate for the elimination of rational choice theory", correct: false }
  ]
  q.difficulty = 0.1
  q.discrimination = 1.3
  q.guessing = 0.2
  q.explanation = "The passage introduces behavioral economics as a field that explains predictable patterns in 'irrational' decisions (paragraph 1), describes key concepts like loss aversion and framing effects (paragraphs 2-3), and discusses applications and critiques (paragraph 4). Option B captures this structure. Options A and E overstate the challenge to traditional theory, C is too absolute, and D is not the focus."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q11,
  course_lesson: lesson_4,
  relevance_weight: 95,
  section_anchor: 'research-structure'
)

# Question 12: Detail
q12 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "According to the passage, the 'disposition effect' refers to:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "The tendency to demand more compensation to give up an owned object than one would pay to acquire it", correct: false },
    { text: "The tendency to hold onto losing investments rather than sell them", correct: true },
    { text: "The tendency to respond differently to information framed as gains versus losses", correct: false },
    { text: "The tendency to make decisions based on mental shortcuts", correct: false },
    { text: "The tendency to reject all changes to the status quo", correct: false }
  ]
  q.difficulty = -0.4
  q.discrimination = 1.7
  q.guessing = 0.2
  q.explanation = "Paragraph 2 states that loss aversion means 'people may irrationally hold onto losing investments rather than sell them, a phenomenon known as the \"disposition effect.\"' This directly corresponds to option B. Option A describes loss aversion generally, C describes framing effect, D describes heuristics, and E is not mentioned."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q12,
  course_lesson: lesson_4,
  relevance_weight: 88,
  section_anchor: 'methodology-interpretation'
)

# Question 13: Inference
q13 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "Based on the passage, which of the following scenarios best illustrates the framing effect?",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "A person refuses to sell a concert ticket for $100 even though they paid only $50 for it", correct: false },
    { text: "More people choose to buy yogurt described as '90% fat-free' than yogurt described as '10% fat'", correct: true },
    { text: "An investor continues to hold a declining stock hoping it will recover", correct: false },
    { text: "A consumer pays more for a product when they see it first at a higher price", correct: false },
    { text: "A person makes a quick decision based on limited information", correct: false }
  ]
  q.difficulty = 0.7
  q.discrimination = 1.5
  q.guessing = 0.2
  q.explanation = "The framing effect occurs when 'the way information is presented influences decision-making even when the objective content remains identical.' Option B perfectly illustrates this: '90% fat-free' and '10% fat' convey the same information but are framed differently. Option A illustrates loss aversion, C shows disposition effect, D shows anchoring, and E shows use of heuristics."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q13,
  course_lesson: lesson_4,
  relevance_weight: 90,
  section_anchor: 'methodology-interpretation'
)

# Question 14: Evaluation/Critique
q14 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The passage suggests that critics of behavioral economics believe which of the following?",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Behavioral economics has no practical applications", correct: false },
    { text: "Cognitive biases do not affect economic decision-making", correct: false },
    { text: "The insights of behavioral economics could potentially be used to manipulate consumers", correct: true },
    { text: "Loss aversion and framing effects have been disproven by research", correct: false },
    { text: "Traditional economic theory should be completely abandoned", correct: false }
  ]
  q.difficulty = 0.4
  q.discrimination = 1.4
  q.guessing = 0.2
  q.explanation = "Paragraph 4 states that 'critics caution that behavioral economics can be misused to manipulate rather than help consumers.' This directly supports option C. The passage doesn't suggest critics deny applications (A), deny biases (B), claim disproof (D), or advocate abandoning traditional theory (E); in fact, some argue traditional theory 'remains valid' for aggregate behavior."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q14,
  course_lesson: lesson_4,
  relevance_weight: 87,
  section_anchor: 'causation-correlation'
)

# Question 15: Function
q15 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The author mentions the Kahneman and Tversky experiment primarily in order to:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Demonstrate the superiority of behavioral economics over traditional economic theory", correct: false },
    { text: "Provide empirical evidence for the framing effect", correct: true },
    { text: "Illustrate the concept of loss aversion", correct: false },
    { text: "Argue that medical decisions are inherently irrational", correct: false },
    { text: "Explain how heuristics function in decision-making", correct: false }
  ]
  q.difficulty = 0.3
  q.discrimination = 1.3
  q.guessing = 0.2
  q.explanation = "The experiment is introduced immediately after defining the framing effect, with 'Research by psychologists Daniel Kahneman and Amos Tversky demonstrated that people respond differently to choices framed in terms of gains versus losses.' The experiment serves as concrete evidence for the framing effect concept (option B). It doesn't address loss aversion (C), isn't used to prove superiority (A), doesn't claim irrationality (D), or explain heuristics (E)."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q15,
  course_lesson: lesson_4,
  relevance_weight: 91,
  section_anchor: 'methodology-interpretation'
)

puts "✓ Created 5 questions for Behavioral Economics passage"

# Additional questions for variety...

# Question 16: Vocabulary in Context (Science passage)
q16 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "In the context of the neuroplasticity passage, the word 'synaptic' (paragraph 2) most nearly means:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Related to the connections between nerve cells", correct: true },
    { text: "Pertaining to muscle movement", correct: false },
    { text: "Associated with electrical impulses", correct: false },
    { text: "Concerning brain structure", correct: false },
    { text: "Involving chemical reactions", correct: false }
  ]
  q.difficulty = 0.0
  q.discrimination = 1.2
  q.guessing = 0.2
  q.explanation = "The passage describes 'synaptic plasticity' as 'the strengthening or weakening of synapses,' and later explains that synapses are 'connections between [neurons].' This indicates synaptic refers to connections between nerve cells (option A). While synapses do involve chemical and electrical processes, the term itself refers to the connections."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q16,
  course_lesson: lesson_2,
  relevance_weight: 80,
  section_anchor: 'technical-vocabulary'
)

# Question 17: Multiple answer question (Humanities)
q17 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "According to the Impressionism passage, which TWO of the following were criticisms directed at Impressionist paintings? (Select two answer choices)",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "They appeared unfinished", correct: true },
    { text: "They contained too much detail", correct: false },
    { text: "They had visible brushstrokes", correct: true },
    { text: "They were too large in scale", correct: false },
    { text: "They used too many dark colors", correct: false },
    { text: "They focused on mythological subjects", correct: false }
  ]
  q.difficulty = 0.2
  q.discrimination = 1.4
  q.guessing = 0.15
  q.explanation = "Paragraph 3 states that 'Critics derided the paintings as unfinished sketches, mocking the visible brushstrokes and loose composition.' This directly supports options A and C. Options B and E contradict the passage (academic art had detail and dark studios, not Impressionism), D is not mentioned, and F describes academic art, not Impressionist criticism."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q17,
  course_lesson: lesson_3,
  relevance_weight: 86,
  section_anchor: 'reading-strategies'
)

# Question 18: Select-in-passage type question (Social Science)
q18 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "Which of the following statements from the behavioral economics passage, if true, would most weaken the claim that behavioral economics challenges traditional economic theory?",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Cognitive biases only affect a small minority of people", correct: true },
    { text: "Loss aversion has been observed across multiple cultures", correct: false },
    { text: "Framing effects are more pronounced in complex decisions", correct: false },
    { text: "Behavioral economics has numerous practical applications", correct: false },
    { text: "People use heuristics in everyday decision-making", correct: false }
  ]
  q.difficulty = 0.9
  q.discrimination = 1.6
  q.guessing = 0.2
  q.explanation = "Behavioral economics challenges traditional theory by showing that 'irrational' decisions follow 'predictable patterns' that are widespread. If cognitive biases only affected a small minority (option A), then traditional rational choice theory would still describe most people's behavior, weakening the challenge. Options B, C, and E would strengthen behavioral economics' claims, and D is irrelevant to whether it challenges traditional theory."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q18,
  course_lesson: lesson_4,
  relevance_weight: 93,
  section_anchor: 'causation-correlation'
)

# Question 19: Author's purpose (Science)
q19 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "The neuroplasticity passage is primarily concerned with:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Explaining the mechanisms of neuroplasticity and its therapeutic applications while acknowledging limitations", correct: true },
    { text: "Arguing that neuroplasticity can cure all neurological conditions", correct: false },
    { text: "Describing the history of neuroscience research", correct: false },
    { text: "Comparing different types of brain imaging techniques", correct: false },
    { text: "Advocating for increased funding for neuroscience research", correct: false }
  ]
  q.difficulty = 0.1
  q.discrimination = 1.3
  q.guessing = 0.2
  q.explanation = "The passage systematically explains what neuroplasticity is, how it works (mechanisms), where it's applied therapeutically (stroke recovery, cognitive therapy), and its limitations (maladaptive plasticity, age-related decline). Option A captures this balanced overview. The passage doesn't claim cures (B), focus on history (C), discuss imaging (D), or advocate funding (E)."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q19,
  course_lesson: lesson_2,
  relevance_weight: 94,
  section_anchor: 'science-structures'
)

# Question 20: Comparative question (Humanities)
q20 = QuizQuestion.find_or_create_by!(
  quiz: quiz,
  question_text: "Based on the passage, Impressionism differed from academic painting primarily in its:",
  question_type: 'mcq'
) do |q|
  q.options = [
    { text: "Use of oil paints rather than watercolors", correct: false },
    { text: "Focus on subjective visual perception rather than idealized representation", correct: true },
    { text: "Depiction of urban rather than rural scenes", correct: false },
    { text: "Preference for smaller rather than larger canvases", correct: false },
    { text: "Use of brighter rather than darker color palettes", correct: false }
  ]
  q.difficulty = 0.5
  q.discrimination = 1.5
  q.guessing = 0.2
  q.explanation = "Paragraph 1 states the key difference: academic art 'aspired to an idealized representation of reality' while Impressionists 'prioritized immediate visual perception.' Paragraph 2 reinforces this: the goal was 'representing subjective visual experience rather than objective reality.' Option B captures this fundamental distinction. The other options aren't mentioned as key differences in the passage."
end

QuizQuestionLessonMapping.create!(
  quiz_question: q20,
  course_lesson: lesson_3,
  relevance_weight: 89,
  section_anchor: 'common-structures'
)

puts "✓ Created 5 additional questions"
puts "✓ Total Reading Comprehension questions: 20"
puts "Reading Comprehension module completed successfully!"
