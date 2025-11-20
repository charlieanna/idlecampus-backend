# GRE Verbal Reasoning - Text Completion
# This seed file creates lessons and questions for Text Completion
# Includes single-blank, double-blank, and triple-blank questions

puts "Creating GRE Text Completion content..."

course = Course.find_by!(slug: 'gre-verbal-reasoning')
text_completion_module = course.course_modules.find_by!(slug: 'text-completion')

# Create quiz for the module
quiz = Quiz.find_or_create_by!(
  course_module: text_completion_module,
  title: "#{text_completion_module.title} Practice"
) do |q|
  q.description = "Practice questions for Text Completion"
  q.time_limit_minutes = 45
  q.passing_score = 70
end

# Lesson 1: Introduction to Text Completion
lesson_1 = CourseLesson.find_or_create_by!(
  course_module: text_completion_module,
  slug: 'intro-text-completion'
) do |l|
  l.title = 'Introduction to Text Completion'
  l.sequence_order = 1
  l.reading_time_minutes = 25
  l.key_concepts = ['Context clues', 'Vocabulary in context', 'Sentence logic', 'Answer strategies']
  l.content = <<~MD
    # Introduction to Text Completion

    ## What is Text Completion?
    Text Completion questions present sentences or short passages with one to three blanks. You must select the best word or phrase for each blank from a list of options.

    ## Question Types

    ### Single-Blank Questions
    - **1 blank** in the sentence
    - **5 answer choices**
    - Select the ONE answer that best completes the sentence

    ### Double-Blank Questions
    - **2 blanks** in the sentence
    - **3 answer choices per blank**
    - Must get BOTH blanks correct for credit
    - No partial credit

    ### Triple-Blank Questions
    - **3 blanks** in the sentence/passage
    - **3 answer choices per blank**
    - Must get ALL THREE blanks correct for credit
    - No partial credit

    ## Core Strategy

    ### 1. Read for Context
    Before looking at answer choices:
    - Read the entire sentence/passage
    - Understand the overall meaning
    - Note transition words and phrases
    - Identify the logical flow

    ### 2. Predict the Answer
    - Think of your own word for each blank
    - Consider the tone (positive/negative)
    - Think about the logical relationship

    ### 3. Look for Context Clues

    #### Restatement Clues
    The sentence restates the blank's meaning:
    - "The scientist was known for her **\_\_\_\_**; she meticulously checked every detail."
    - (Answer: precision, thoroughness)

    #### Contrast Clues
    Words like "although," "but," "however," "despite" signal contrast:
    - "Although the movie was **\_\_\_\_**, the audience seemed bored."
    - (Answer: engaging, captivating)

    #### Cause-and-Effect Clues
    Words like "because," "therefore," "thus," "consequently":
    - "Because the data was **\_\_\_\_**, the researchers could not draw definitive conclusions."
    - (Answer: incomplete, ambiguous)

    #### Comparison Clues
    Words like "similarly," "likewise," "also":
    - "Like her mentor, the young scientist approached problems **\_\_\_\_**."
    - (Answer: systematically, methodically)

    ### 4. Evaluate Each Choice
    - Eliminate clearly wrong answers
    - Consider connotation (positive/negative/neutral)
    - Check for grammatical fit
    - Look for the BEST answer, not just a possible one

    ### 5. For Multiple Blanks
    - Try one blank at a time
    - Start with the easier blank
    - Use your answer for one blank to inform the others
    - Read the entire sentence with your chosen answers

    ## Common Pitfalls to Avoid

    ### 1. Ignoring Context
    **Wrong approach**: Picking a difficult vocabulary word because it sounds sophisticated
    **Right approach**: Choosing the word that fits the context, regardless of difficulty

    ### 2. Not Reading the Whole Sentence
    **Wrong approach**: Filling in blanks as you read
    **Right approach**: Read completely, understand the logic, then fill in blanks

    ### 3. Partial Matching (Multiple Blanks)
    **Wrong approach**: Focusing only on one blank
    **Right approach**: Ensuring ALL blanks work together logically

    ### 4. Assuming Difficulty
    **Wrong approach**: Thinking the answer must be an obscure word
    **Right approach**: Sometimes the answer is a common word used precisely

    ## Transition Words and Phrases

    ### Addition/Support
    - moreover, furthermore, in addition, also, additionally
    - Signal: More of the same

    ### Contrast
    - however, but, although, despite, nevertheless, yet, conversely
    - Signal: Opposite or different

    ### Cause/Effect
    - because, since, therefore, thus, consequently, as a result
    - Signal: One thing leads to another

    ### Emphasis
    - indeed, in fact, certainly, undoubtedly
    - Signal: Reinforcement of a point

    ### Comparison
    - similarly, likewise, in the same way, analogously
    - Signal: Similarity

    ## Practice Approach

    ### Step-by-Step Method
    1. **Read the sentence completely**
    2. **Identify context clues and transition words**
    3. **Predict words for each blank**
    4. **Evaluate choices against your prediction**
    5. **Read the completed sentence to verify logic**
    6. **For multiple blanks, try different combinations if needed**

    ### Time Management
    - Single-blank: ~1 minute
    - Double-blank: ~1.5-2 minutes
    - Triple-blank: ~2-2.5 minutes

    Don't spend too long on any one question. If stuck, make your best guess and move on.
  MD
  l.content_sections = [
    {
      anchor: 'question-types',
      title: 'Question Types',
      content: 'Single, double, and triple-blank questions'
    },
    {
      anchor: 'context-clues',
      title: 'Context Clues',
      content: 'Restatement, contrast, cause-effect, and comparison'
    },
    {
      anchor: 'strategy',
      title: 'Core Strategy',
      content: 'Five-step approach to text completion'
    }
  ]
end

puts "✓ Created lesson: #{lesson_1.title}"

# Lesson 2: Single-Blank Text Completion
lesson_2 = CourseLesson.find_or_create_by!(
  course_module: text_completion_module,
  slug: 'single-blank-completion'
) do |l|
  l.title = 'Single-Blank Text Completion'
  l.sequence_order = 2
  l.reading_time_minutes = 20
  l.key_concepts = ['Single-blank strategy', 'Vocabulary building', 'Context analysis', 'Process of elimination']
  l.content = <<~MD
    # Single-Blank Text Completion

    ## Format
    - **One blank** in the sentence
    - **Five answer choices**
    - Choose the **one best answer**
    - These are typically easier than multiple-blank questions

    ## Strategy

    ### 1. Read and Understand
    Read the entire sentence to grasp:
    - The topic
    - The tone
    - The logical structure
    - The purpose

    ### 2. Look for Strong Context Clues
    Single-blank questions usually provide clear context:
    - Descriptive phrases
    - Examples
    - Contrast indicators
    - Cause-effect relationships

    ### 3. Predict Before Looking
    Think of your own word(s) that would fit:
    - Don't worry if your word isn't sophisticated
    - Focus on the meaning, not the specific word
    - Consider synonyms of your prediction

    ### 4. Process of Elimination
    With 5 choices, elimination is powerful:
    - Cross out clearly wrong answers
    - Eliminate words with wrong connotation
    - Remove words that don't fit grammatically
    - Choose the best from remaining options

    ## Common Patterns

    ### Pattern 1: Definition/Restatement
    The sentence essentially defines the blank:

    **Example**: "The professor was known for her \_\_\_\_; she would spend hours ensuring every detail was perfect."

    Context clues:
    - "spend hours" → thoroughness
    - "every detail" → attention to detail
    - "perfect" → high standards

    **Answer**: meticulousness, diligence, fastidiousness

    ### Pattern 2: Contrast
    The blank contrasts with something else in the sentence:

    **Example**: "Although the experiment appeared \_\_\_\_ at first, further investigation revealed unexpected complexity."

    Context clues:
    - "Although" → contrast signal
    - "unexpected complexity" → opposite of simple

    **Answer**: straightforward, simple, uncomplicated

    ### Pattern 3: Cause and Effect
    One part of the sentence causes or results from the blank:

    **Example**: "The politician's \_\_\_\_ remarks alienated many of her former supporters."

    Context clues:
    - "alienated" → negative effect
    - "former supporters" → they turned away
    - Need: negative characteristic

    **Answer**: inflammatory, divisive, offensive

    ### Pattern 4: Example/Illustration
    The sentence provides examples that illustrate the blank:

    **Example**: "The artist's \_\_\_\_ was evident in her work, which ranged from sculpture to painting to digital media."

    Context clues:
    - "ranged from... to... to..." → variety
    - Multiple art forms → versatility

    **Answer**: versatility, eclecticism, diversity

    ## Vocabulary Categories

    ### Positive Traits
    - **Careful**: meticulous, scrupulous, fastidious, punctilious
    - **Skilled**: adept, proficient, accomplished, dexterous
    - **Smart**: astute, perspicacious, sagacious, shrewd
    - **Hardworking**: diligent, assiduous, sedulous, industrious

    ### Negative Traits
    - **Stubborn**: obstinate, intractable, recalcitrant, obdurate
    - **Sneaky**: furtive, surreptitious, clandestine, covert
    - **Mean**: acerbic, caustic, mordant, vitriolic
    - **Boring**: mundane, banal, prosaic, pedestrian

    ### Change Words
    - **Increase**: augment, amplify, enhance, bolster
    - **Decrease**: diminish, attenuate, mitigate, abate
    - **Weaken**: undermine, erode, sap, enervate
    - **Strengthen**: fortify, buttress, reinforce, consolidate

    ### Speech/Writing
    - **Wordy**: verbose, prolix, garrulous, loquacious
    - **Brief**: concise, succinct, terse, laconic
    - **Vague**: nebulous, amorphous, inchoate, ambiguous
    - **Clear**: lucid, pellucid, articulate, coherent

    ## Practice Tips

    ### Build Vocabulary Groups
    Learn words in synonym clusters:
    - Easier to remember
    - Helps with process of elimination
    - Understand nuanced differences

    ### Note Connotation
    Many words have similar meanings but different tones:
    - **Frugal** (positive) vs. **stingy** (negative)
    - **Confident** (positive) vs. **arrogant** (negative)
    - **Relaxed** (neutral) vs. **indolent** (negative)

    ### Practice Prediction
    Before looking at choices:
    1. Read the sentence
    2. Think of simple word that fits
    3. Then look for synonyms in the choices

    ### Read with Your Answer
    After selecting, read the complete sentence:
    - Does it make sense?
    - Does it sound natural?
    - Does it match the tone?

    ## Common Mistakes

    ### 1. Choosing the Hardest Word
    - The answer isn't always the most difficult word
    - Focus on meaning, not difficulty level

    ### 2. Ignoring Tone
    - Pay attention to positive/negative context
    - Match the word's connotation to the sentence

    ### 3. Not Reading Completely
    - Important clues may come at the end
    - Read the full sentence before deciding

    ### 4. Overthinking
    - Your first instinct is often correct
    - Don't talk yourself out of the right answer

    ## Time Management
    - **Target time**: 1 minute per question
    - If stuck after 1.5 minutes, guess and move on
    - Mark for review if time permits
    - Don't leave blanks (no penalty for wrong answers)
  MD
  l.content_sections = [
    {
      anchor: 'single-blank-patterns',
      title: 'Common Patterns',
      content: 'Definition, contrast, cause-effect, and example patterns'
    },
    {
      anchor: 'vocabulary-categories',
      title: 'Vocabulary Categories',
      content: 'Organized word groups for efficient learning'
    },
    {
      anchor: 'single-blank-tips',
      title: 'Practice Tips',
      content: 'Building vocabulary and prediction skills'
    }
  ]
end

puts "✓ Created lesson: #{lesson_2.title}"

# Single-Blank Questions (15 questions)

questions_data = [
  {
    question: "The scientist's reputation for _____ was well-deserved; she had never published a result that could not be independently verified.",
    choices: ["innovation", "integrity", "creativity", "dedication", "enthusiasm"],
    correct: "integrity",
    difficulty: -0.2,
    explanation: "The context indicates that her results could always be 'independently verified,' which relates to honesty and trustworthiness in research. 'Integrity' best captures this quality. While other traits like dedication might be implied, the specific emphasis on verification points to integrity."
  },
  {
    question: "Despite the team's _____ efforts to meet the deadline, they fell short due to unforeseen technical complications.",
    choices: ["halfhearted", "sporadic", "herculean", "negligent", "cursory"],
    correct: "herculean",
    difficulty: 0.1,
    explanation: "'Despite' signals contrast—even though they tried hard, they failed. 'Herculean' means requiring enormous effort, which contrasts with falling short. Halfhearted, sporadic, negligent, and cursory all suggest insufficient effort, which wouldn't create the contrast signaled by 'despite.'"
  },
  {
    question: "The author's use of _____ language made the complex scientific concepts accessible to a general audience.",
    choices: ["technical", "abstruse", "lucid", "ambiguous", "pedantic"],
    correct: "lucid",
    difficulty: 0.0,
    explanation: "Making complex concepts 'accessible' requires clear explanation. 'Lucid' means clear and easy to understand. Technical, abstruse (obscure), ambiguous, and pedantic would all make concepts less accessible, not more."
  },
  {
    question: "The politician's _____ speech, filled with vague promises and evasions, did little to reassure worried constituents.",
    choices: ["forthright", "candid", "equivocal", "articulate", "impassioned"],
    correct: "equivocal",
    difficulty: 0.3,
    explanation: "'Vague promises and evasions' characterize deliberately ambiguous language. 'Equivocal' means open to multiple interpretations or deliberately unclear. Forthright and candid mean direct and honest (opposite), while articulate and impassioned don't capture the deceptiveness implied."
  },
  {
    question: "The economist's predictions proved _____, as the market moved in the exact opposite direction.",
    choices: ["prescient", "erroneous", "astute", "prophetic", "sagacious"],
    correct: "erroneous",
    difficulty: -0.1,
    explanation: "Predictions that go 'in the exact opposite direction' were clearly wrong. 'Erroneous' means mistaken or incorrect. Prescient, astute, prophetic, and sagacious all mean insightful or accurate—the opposite of what's described."
  },
  {
    question: "The ancient manuscript's _____ condition made it extremely difficult for scholars to decipher the text.",
    choices: ["pristine", "deteriorated", "impressive", "ornate", "authentic"],
    correct: "deteriorated",
    difficulty: -0.3,
    explanation: "Something that's 'extremely difficult to decipher' due to its condition must be damaged or in poor shape. 'Deteriorated' means degraded or decayed. 'Pristine' (perfect condition) would make it easier to read. Impressive, ornate, and authentic don't relate to readability."
  },
  {
    question: "Though initially _____ about the project's feasibility, the engineer became more confident after reviewing the technical specifications.",
    choices: ["enthusiastic", "skeptical", "certain", "knowledgeable", "convinced"],
    correct: "skeptical",
    difficulty: 0.2,
    explanation: "'Though' signals contrast between initial and later states. Since the engineer 'became more confident after,' the initial state must have been doubt. 'Skeptical' means doubtful. Enthusiastic, certain, and convinced would not contrast with becoming confident. Knowledgeable doesn't relate to confidence level."
  },
  {
    question: "The company's _____ approach to innovation—investing in dozens of experimental projects simultaneously—often led to breakthroughs.",
    choices: ["conservative", "cautious", "profligate", "restrained", "methodical"],
    correct: "profligate",
    difficulty: 0.6,
    explanation: "Investing in 'dozens of experimental projects simultaneously' suggests lavish or wasteful spending. 'Profligate' means recklessly extravagant. Conservative, cautious, and restrained are opposites. Methodical describes organized approach, not the abundance implied."
  },
  {
    question: "The professor's lectures were known for their _____, often incorporating references to literature, music, and current events.",
    choices: ["brevity", "specialization", "eclecticism", "monotony", "predictability"],
    correct: "eclecticism",
    difficulty: 0.4,
    explanation: "Incorporating diverse elements (literature, music, current events) demonstrates variety and range. 'Eclecticism' means drawing from diverse sources. Brevity, specialization, monotony, and predictability don't capture the variety described."
  },
  {
    question: "The diplomat's _____ response to the provocative question prevented the tense situation from escalating.",
    choices: ["inflammatory", "bellicose", "tactful", "evasive", "aggressive"],
    correct: "tactful",
    difficulty: 0.1,
    explanation: "Preventing escalation requires careful, diplomatic language. 'Tactful' means showing sensitivity and skill in dealing with difficult situations. Inflammatory, bellicose, and aggressive would cause escalation. Evasive doesn't necessarily prevent escalation."
  },
  {
    question: "The archaeologist's theory, once dismissed as _____, gained credibility after new evidence emerged.",
    choices: ["orthodox", "conventional", "fanciful", "established", "traditional"],
    correct: "fanciful",
    difficulty: 0.3,
    explanation: "A theory that was 'dismissed' but later 'gained credibility' must have initially seemed unrealistic or far-fetched. 'Fanciful' means imaginative but unrealistic. Orthodox, conventional, established, and traditional describe accepted ideas that wouldn't be dismissed."
  },
  {
    question: "The artist's early work was _____, derivative of her teachers' styles, but her later pieces showed genuine originality.",
    choices: ["innovative", "pioneering", "imitative", "creative", "groundbreaking"],
    correct: "imitative",
    difficulty: 0.0,
    explanation: "'Derivative of her teachers' styles' means copying or imitating. The contrast with 'genuine originality' in later work confirms the early work lacked originality. 'Imitative' means copying. Innovative, pioneering, creative, and groundbreaking are the opposite."
  },
  {
    question: "The reviewer's _____ critique, while harsh, provided valuable insights that helped the author improve the manuscript.",
    choices: ["effusive", "laudatory", "trenchant", "superficial", "cursory"],
    correct: "trenchant",
    difficulty: 0.7,
    explanation: "A critique that's both 'harsh' and provides 'valuable insights' must be sharply perceptive. 'Trenchant' means sharply incisive and effective. Effusive and laudatory are positive/praising. Superficial and cursory lack the depth needed for valuable insights."
  },
  {
    question: "The executive's _____ management style, characterized by sudden policy reversals, created uncertainty among employees.",
    choices: ["consistent", "steadfast", "capricious", "methodical", "systematic"],
    correct: "capricious",
    difficulty: 0.4,
    explanation: "'Sudden policy reversals' and 'created uncertainty' indicate unpredictable, erratic behavior. 'Capricious' means impulsive and unpredictable. Consistent, steadfast, methodical, and systematic all describe stable, predictable approaches."
  },
  {
    question: "The medicine's _____ effects were limited to mild drowsiness, making it preferable to alternatives with more serious complications.",
    choices: ["therapeutic", "adverse", "curative", "beneficial", "primary"],
    correct: "adverse",
    difficulty: 0.2,
    explanation: "'Mild drowsiness' is a negative side effect. The contrast with 'more serious complications' confirms these are unwanted effects. 'Adverse' means harmful or unfavorable. Therapeutic, curative, and beneficial are positive. Primary doesn't indicate whether effects are good or bad."
  }
]

questions_data.each_with_index do |qdata, index|
  question = QuizQuestion.find_or_create_by!(
    quiz: quiz,
    question_text: qdata[:question],
    question_type: 'mcq'
  ) do |q|
    q.options = qdata[:choices].map do |choice|
      { text: choice, correct: (choice == qdata[:correct]) }
    end
    q.difficulty = qdata[:difficulty]
    q.discrimination = 1.4
    q.guessing = 0.2
    q.explanation = qdata[:explanation]
  end

  QuizQuestionLessonMapping.create!(
    quiz_question: question,
    course_lesson: lesson_2,
    relevance_weight: 85 + (index % 10),
    section_anchor: 'single-blank-patterns'
  )
end

puts "✓ Created 15 single-blank questions"

# Lesson 3: Double-Blank Text Completion
lesson_3 = CourseLesson.find_or_create_by!(
  course_module: text_completion_module,
  slug: 'double-blank-completion'
) do |l|
  l.title = 'Double-Blank Text Completion'
  l.sequence_order = 3
  l.reading_time_minutes = 25
  l.key_concepts = ['Multiple blanks', 'Interdependent answers', 'Combination testing', 'Logical relationships']
  l.content = <<~MD
    # Double-Blank Text Completion

    ## Format
    - **Two blanks** in the sentence
    - **3 choices for EACH blank**
    - Total of 9 possible combinations (3 × 3)
    - Must get **BOTH blanks correct** for credit
    - **No partial credit**

    ## Key Challenge
    The blanks are usually interdependent:
    - The meaning of one blank affects the other
    - Both must work together logically
    - You can't treat them independently

    ## Strategy

    ### 1. Read Completely First
    - Don't fill in blanks as you read
    - Understand the entire sentence's logic
    - Identify the relationship between the blanks

    ### 2. Start with the Easier Blank
    Usually one blank has stronger context clues:
    - More explicit description
    - Clearer contrast or comparison
    - More direct restatement

    ### 3. Use Your First Answer to Guide the Second
    After selecting for one blank:
    - Consider how it affects the other blank
    - Eliminate incompatible choices
    - Test logical consistency

    ### 4. Test Key Combinations
    You don't need to test all 9:
    - Eliminate obviously wrong choices first
    - Test 2-3 most promising combinations
    - Read the full sentence with both answers

    ## Common Patterns

    ### Pattern 1: Parallel Structure
    Both blanks have similar meaning (reinforcement):

    **Example**: "The researcher's approach was both (i) _____ and (ii) _____; she carefully considered every detail and left nothing to chance."

    Blank (i): meticulous / careless / innovative
    Blank (ii): thorough / haphazard / creative

    **Analysis**:
    - "carefully considered every detail" → meticulous
    - "left nothing to chance" → thorough
    - Both blanks reinforce the same idea
    - **Answer**: meticulous + thorough

    ### Pattern 2: Contrast Structure
    Blanks have opposite meanings:

    **Example**: "Although the critic praised the novel's (i) _____ plot, she found the characters to be disappointingly (ii) _____."

    Blank (i): intricate / simple / flawed
    Blank (ii): complex / shallow / detailed

    **Analysis**:
    - "Although" signals contrast
    - "praised" for blank (i) → positive
    - "disappointingly" for blank (ii) → negative
    - **Answer**: intricate + shallow

    ### Pattern 3: Cause and Effect
    One blank causes or results from the other:

    **Example**: "The politician's (i) _____ statements during the campaign led to accusations of (ii) _____."

    Blank (i): honest / contradictory / consistent
    Blank (ii): integrity / hypocrisy / leadership

    **Analysis**:
    - Negative "accusations" suggests blank (i) is negative
    - Contradictory statements → accusations of hypocrisy
    - Cause and effect relationship
    - **Answer**: contradictory + hypocrisy

    ### Pattern 4: Sequential Logic
    The blanks follow a logical sequence:

    **Example**: "The theory was initially (i) _____ by most scientists but eventually became (ii) _____ after supporting evidence accumulated."

    Blank (i): accepted / rejected / ignored
    Blank (ii): mainstream / controversial / forgotten

    **Analysis**:
    - "initially" vs. "eventually" indicates change
    - "but" signals contrast
    - Rejected → mainstream shows evolution
    - **Answer**: rejected + mainstream

    ## Relationship Types

    ### Same Direction (Reinforcement)
    Signal words: "and," "moreover," "furthermore," "also"

    Both blanks support the same idea:
    - positive + positive
    - negative + negative

    ### Opposite Direction (Contrast)
    Signal words: "although," "but," "despite," "however," "yet"

    Blanks oppose each other:
    - positive + negative
    - negative + positive

    ### Cause-Effect
    Signal words: "because," "since," "therefore," "thus," "consequently"

    One blank leads to the other:
    - action → result
    - characteristic → consequence

    ### Temporal Sequence
    Signal words: "initially," "eventually," "first," "finally," "previously," "subsequently"

    Change over time:
    - before → after
    - past → present

    ## Step-by-Step Approach

    ### Step 1: Identify Relationship
    Read the sentence and determine:
    - Are the blanks parallel or contrasting?
    - Is there a cause-effect relationship?
    - Is there a temporal sequence?

    ### Step 2: Choose Starting Blank
    Pick the blank with stronger context:
    - More descriptive phrases nearby
    - Clearer transition words
    - More explicit examples

    ### Step 3: Eliminate for First Blank
    Cross out clearly wrong choices:
    - Wrong tone (positive vs. negative)
    - Wrong intensity
    - Doesn't fit grammar

    ### Step 4: Use First Answer to Filter Second
    For each remaining choice in first blank:
    - What does this imply for the second blank?
    - Eliminate incompatible second-blank choices

    ### Step 5: Test and Verify
    Read complete sentence with both answers:
    - Logical flow?
    - Consistent tone?
    - Natural language?

    ## Common Mistakes

    ### 1. Treating Blanks Independently
    **Wrong**: Choosing the best word for each blank separately
    **Right**: Ensuring both words work together logically

    ### 2. Not Using Process of Elimination
    **Wrong**: Testing all 9 combinations
    **Right**: Eliminating impossible combinations early

    ### 3. Ignoring Transition Words
    **Wrong**: Missing "although," "despite," "however"
    **Right**: Using transitions to understand relationships

    ### 4. Stopping at "Good Enough"
    **Wrong**: Selecting first combination that seems reasonable
    **Right**: Testing all viable combinations to find the best

    ## Practice Tips

    ### Build Vocabulary Pairs
    Learn words that commonly pair:
    - **Positive pairs**: meticulous/thorough, innovative/creative, lucid/articulate
    - **Negative pairs**: obstinate/inflexible, verbose/redundant, superficial/cursory
    - **Opposite pairs**: straightforward/complex, enhance/undermine, accept/reject

    ### Master Transition Words
    Recognize relationships instantly:
    - **And, also, moreover** → same direction
    - **But, however, although** → contrast
    - **Because, since, therefore** → cause-effect
    - **Initially, eventually, first, finally** → sequence

    ### Practice Prediction for Both
    Before looking at choices:
    1. Read the sentence
    2. Predict simple words for both blanks
    3. Determine the relationship
    4. Then evaluate choices

    ## Time Management
    - **Target**: 1.5-2 minutes per question
    - Spend extra 30 seconds over single-blank questions
    - The complexity justifies more time
    - If stuck after 2 minutes, make best guess and move on
  MD
  l.content_sections = [
    {
      anchor: 'double-blank-patterns',
      title: 'Common Patterns',
      content: 'Parallel, contrast, cause-effect, and sequential patterns'
    },
    {
      anchor: 'relationship-types',
      title: 'Relationship Types',
      content: 'Understanding how blanks relate to each other'
    },
    {
      anchor: 'double-blank-strategy',
      title: 'Step-by-Step Approach',
      content: 'Five-step method for double-blank questions'
    }
  ]
end

puts "✓ Created lesson: #{lesson_3.title}"

# Double-Blank Questions (10 questions)
# Note: For MCQ format, we'll structure as a single question with the correct combination

double_blank_questions = [
  {
    question: "The architect's design was both (i) _____ and (ii) _____; it incorporated cutting-edge technology while respecting the historical context of the neighborhood.\n\nBlank (i): innovative / traditional / outdated\nBlank (ii): contextual / jarring / anachronistic",
    choices: [
      "innovative ... contextual",
      "innovative ... jarring",
      "traditional ... contextual",
      "traditional ... anachronistic",
      "outdated ... jarring"
    ],
    correct: "innovative ... contextual",
    difficulty: 0.3,
    explanation: "The semicolon indicates that the second clause explains the first. 'Cutting-edge technology' suggests innovative (blank i), while 'respecting the historical context' suggests contextual/fitting (blank ii). Both blanks are positive and work together. Traditional and outdated contradict 'cutting-edge,' while jarring and anachronistic contradict 'respecting.'"
  },
  {
    question: "Although the scientist's theory was initially (i) _____ by her peers, subsequent experiments provided evidence that (ii) _____ her hypothesis.\n\nBlank (i): embraced / dismissed / understood\nBlank (ii): vindicated / undermined / questioned",
    choices: [
      "embraced ... vindicated",
      "dismissed ... vindicated",
      "dismissed ... undermined",
      "understood ... questioned",
      "embraced ... undermined"
    ],
    correct: "dismissed ... vindicated",
    difficulty: 0.4,
    explanation: "'Although' signals contrast between initial reception and later outcome. If peers initially dismissed it (i), subsequent evidence would vindicate/support it (ii). Embraced...vindicated shows no contrast. Dismissed...undermined shows no contrast (both negative). The answer requires initial rejection + eventual support."
  },
  {
    question: "The senator's (i) _____ remarks about the proposed legislation revealed a (ii) _____ understanding of its potential economic impact.\n\nBlank (i): insightful / superficial / detailed\nBlank (ii): profound / rudimentary / comprehensive",
    choices: [
      "insightful ... profound",
      "superficial ... rudimentary",
      "superficial ... comprehensive",
      "detailed ... profound",
      "detailed ... rudimentary"
    ],
    correct: "superficial ... rudimentary",
    difficulty: 0.5,
    explanation: "The blanks reinforce each other (no contrast word). Superficial remarks would reveal rudimentary/basic understanding (both negative match). Insightful...profound and detailed...profound work together but we need context to determine tone. The critical tone of 'revealed' suggests weakness being exposed, making the negative pair more likely."
  },
  {
    question: "The company's (i) _____ investment strategy, characterized by careful analysis and risk assessment, stood in sharp contrast to its competitor's more (ii) _____ approach.\n\nBlank (i): prudent / reckless / aggressive\nBlank (ii): impulsive / calculated / methodical",
    choices: [
      "prudent ... impulsive",
      "prudent ... calculated",
      "reckless ... impulsive",
      "aggressive ... methodical",
      "reckless ... calculated"
    ],
    correct: "prudent ... impulsive",
    difficulty: 0.3,
    explanation: "'Careful analysis and risk assessment' indicates prudent for blank (i). 'Stood in sharp contrast' requires an opposite for blank (ii), so impulsive fits. Prudent...calculated shows no contrast (both careful). Reckless contradicts 'careful analysis.' The answer must show careful vs. careless."
  },
  {
    question: "Despite the author's reputation for (i) _____ prose, this latest work was surprisingly (ii) _____, filled with unnecessary details and digressions.\n\nBlank (i): concise / ornate / verbose\nBlank (ii): economical / prolix / straightforward",
    choices: [
      "concise ... prolix",
      "concise ... economical",
      "verbose ... prolix",
      "ornate ... straightforward",
      "verbose ... economical"
    ],
    correct: "concise ... prolix",
    difficulty: 0.6,
    explanation: "'Despite' and 'surprisingly' signal strong contrast. The latest work has 'unnecessary details and digressions' = prolix/wordy (blank ii). Therefore, the reputation must be for the opposite: concise/brief (blank i). Concise...economical shows no contrast (both brief). Verbose...prolix shows no contrast (both wordy)."
  },
  {
    question: "The historian's interpretation of events was frequently (i) _____ by critics who offered (ii) _____ explanations based on different evidence.\n\nBlank (i): corroborated / contested / ignored\nBlank (ii): supporting / alternative / identical",
    choices: [
      "corroborated ... supporting",
      "contested ... alternative",
      "contested ... identical",
      "ignored ... alternative",
      "corroborated ... alternative"
    ],
    correct: "contested ... alternative",
    difficulty: 0.4,
    explanation: "Critics offering 'different evidence' suggests they disagree. Contested means challenged/disputed (blank i), and alternative means different (blank ii). Corroborated...supporting shows agreement, not criticism. Contested...identical is contradictory. The answer must show disagreement with different explanations."
  },
  {
    question: "The student's performance was (i) _____ throughout the semester, showing neither significant improvement nor (ii) _____ as the coursework became more challenging.\n\nBlank (i): erratic / consistent / exceptional\nBlank (ii): decline / consistency / progress",
    choices: [
      "consistent ... decline",
      "consistent ... progress",
      "erratic ... decline",
      "exceptional ... progress",
      "erratic ... consistency"
    ],
    correct: "consistent ... decline",
    difficulty: 0.5,
    explanation: "'Neither...nor' structure with 'no improvement' implies also no decline. 'Throughout' suggests consistency. Consistent (blank i) with neither improvement nor decline (blank ii) makes sense. Erratic contradicts stable performance. Exceptional doesn't fit the neutral description."
  },
  {
    question: "The pharmaceutical company's decision to (i) _____ the drug trial after early safety concerns proved (ii) _____ when subsequent investigation revealed no actual health risks.\n\nBlank (i): continue / suspend / accelerate\nBlank (ii): prescient / premature / justified",
    choices: [
      "suspend ... premature",
      "suspend ... justified",
      "continue ... prescient",
      "accelerate ... premature",
      "continue ... premature"
    ],
    correct: "suspend ... premature",
    difficulty: 0.6,
    explanation: "'Safety concerns' would prompt suspension. 'No actual health risks' revealed later means the suspension was premature/too hasty. Suspend...justified contradicts the implication that stopping was wrong. Continue doesn't fit responding to safety concerns."
  },
  {
    question: "The novel's (i) _____ opening chapters, dense with character development and atmospheric description, gave way to a more (ii) _____ narrative as the plot accelerated.\n\nBlank (i): languid / frenetic / sparse\nBlank (ii): deliberate / brisk / ponderous",
    choices: [
      "languid ... brisk",
      "languid ... ponderous",
      "frenetic ... deliberate",
      "sparse ... brisk",
      "frenetic ... brisk"
    ],
    correct: "languid ... brisk",
    difficulty: 0.7,
    explanation: "'Dense with...description' suggests slow, leisurely pace = languid. 'Gave way to' signals change. 'Plot accelerated' indicates faster pace = brisk. Languid...ponderous shows no change (both slow). Frenetic...brisk shows no change (both fast). Must show slow to fast transition."
  },
  {
    question: "The lawyer's (i) _____ cross-examination, marked by aggressive questioning and skillful rhetorical traps, left the witness visibly (ii) _____.\n\nBlank (i): perfunctory / relentless / gentle\nBlank (ii): composed / flustered / confident",
    choices: [
      "relentless ... flustered",
      "perfunctory ... composed",
      "gentle ... flustered",
      "relentless ... confident",
      "perfunctory ... flustered"
    ],
    correct: "relentless ... flustered",
    difficulty: 0.4,
    explanation: "'Aggressive questioning and skillful rhetorical traps' describes relentless/intense examination. This would leave witness flustered/rattled, not composed or confident. Perfunctory (superficial) contradicts 'aggressive.' Gentle contradicts the description. Must show intense questioning → disturbed witness."
  }
]

double_blank_questions.each_with_index do |qdata, index|
  question = QuizQuestion.find_or_create_by!(
    quiz: quiz,
    question_text: qdata[:question],
    question_type: 'mcq'
  ) do |q|
    q.options = qdata[:choices].map do |choice|
      { text: choice, correct: (choice == qdata[:correct]) }
    end
    q.difficulty = qdata[:difficulty]
    q.discrimination = 1.5
    q.guessing = 0.15
    q.explanation = qdata[:explanation]
  end

  QuizQuestionLessonMapping.create!(
    quiz_question: question,
    course_lesson: lesson_3,
    relevance_weight: 88 + (index % 8),
    section_anchor: 'double-blank-patterns'
  )
end

puts "✓ Created 10 double-blank questions"

# Lesson 4: Advanced Text Completion Strategies
lesson_4 = CourseLesson.find_or_create_by!(
  course_module: text_completion_module,
  slug: 'advanced-text-completion'
) do |l|
  l.title = 'Advanced Text Completion Strategies'
  l.sequence_order = 4
  l.reading_time_minutes = 20
  l.key_concepts = ['Triple-blank questions', 'Advanced vocabulary', 'Complex sentences', 'Time optimization']
  l.content = <<~MD
    # Advanced Text Completion Strategies

    ## Triple-Blank Questions

    ### Format
    - **Three blanks** in a sentence or short passage
    - **3 choices for EACH blank**
    - Total of 27 possible combinations (3 × 3 × 3)
    - Must get **ALL THREE blanks correct** for credit
    - **No partial credit**

    ### Why They're Challenging
    - More moving parts to track
    - Longer passages = more context to process
    - Interdependencies among all three blanks
    - Time pressure with 27 possible combinations

    ### Strategy for Triple-Blank

    #### 1. Read the Entire Passage
    - Don't try to fill blanks while reading
    - Get the complete picture first
    - Identify main idea and tone

    #### 2. Identify the Easiest Blank
    Look for the blank with:
    - Strongest context clues
    - Most direct restatement
    - Clearest contrast or comparison
    - Explicit examples

    #### 3. Use Cascade Elimination
    Once you solve one blank:
    - Use it to eliminate choices for second blank
    - Use first two to narrow third blank
    - Reduces 27 combinations to 2-3 viable ones

    #### 4. Check Internal Logic
    All three words must work together:
    - Consistent tone
    - Logical relationships
    - Natural flow

    #### 5. Read Complete Passage with Answers
    Final verification:
    - Does the whole passage make sense?
    - Is the logic coherent?
    - Does it sound natural?

    ## Advanced Vocabulary Strategies

    ### Word Roots
    Many GRE words share common roots:

    #### Latin/Greek Roots
    - **bene-** (good): benevolent, beneficial, benediction
    - **mal-** (bad): malevolent, malicious, malady
    - **-logy** (study): biology, geology, etymology
    - **-phile** (love): bibliophile, Francophile
    - **-phobe** (fear): xenophobe, agoraphobe

    ### Prefixes
    - **a-/an-** (without): amoral, anarchy, apathy
    - **anti-** (against): antithesis, antipathy, antagonist
    - **de-** (remove): debunk, defame, denigrate
    - **dis-** (not): disparage, dissonance, discrepancy
    - **eu-** (good): euphemism, eulogy, euphoria

    ### Suffixes
    - **-ous/-ious** (full of): garrulous, contentious, assiduous
    - **-ate** (verb ending): mitigate, exacerbate, ameliorate
    - **-ity** (noun ending): tenacity, verbosity, duplicity
    - **-ent/-ant** (adjective): ebullient, redundant, dormant

    ## Context Clue Mastery

    ### Level 1: Direct Definition
    The sentence defines the blank:
    - "The judge was known for her _____, always treating all parties with respect."
    - Answer clearly related to "respect" and "treating all parties"

    ### Level 2: Example Clues
    Examples illustrate the blank:
    - "The professor's _____ was evident in his work spanning poetry, essays, and fiction."
    - Examples show versatility

    ### Level 3: Contrast Clues
    Opposition indicates meaning:
    - "Unlike his _____ predecessor, the new manager was flexible and open to change."
    - Opposite of "flexible and open" = rigid, inflexible

    ### Level 4: Inference
    Must be deduced from overall context:
    - "The CEO's decision, though financially sound, was _____ to company morale."
    - Financial success + implied negative effect on morale = detrimental

    ## Time Optimization

    ### Question Triage
    **Easy (1 minute):**
    - Single-blank with clear context
    - Familiar vocabulary
    - Obvious elimination choices

    **Medium (1.5-2 minutes):**
    - Double-blank questions
    - Less familiar vocabulary
    - Requires careful elimination

    **Hard (2-2.5 minutes):**
    - Triple-blank questions
    - Complex sentences
    - Subtle distinctions between choices

    ### When to Guess and Move On
    If after appropriate time you're still uncertain:
    - Eliminate clearly wrong answers
    - Make educated guess
    - Mark for review
    - Move to next question
    - Return if time permits

    ### No Penalty Strategy
    - Never leave blanks
    - Eliminate what you can
    - Guess from remaining
    - No wrong answer penalty on GRE

    ## Common Trap Answers

    ### 1. The "Sounds Smart" Trap
    **Trap**: Choosing the most difficult-sounding word
    **Reality**: The correct answer fits the context, regardless of difficulty
    **Example**: "Simple" might be correct over "perspicacious"

    ### 2. The "Close But Not Quite" Trap
    **Trap**: Choosing a word that's related but not quite right
    **Reality**: GRE tests precision; similar ≠ correct
    **Example**: "Enthusiastic" vs. "zealous" (different intensity)

    ### 3. The "Positive/Negative Mix-Up" Trap
    **Trap**: Confusing words with opposite connotations
    **Reality**: Tone matters; positive context needs positive word
    **Example**: "Assertive" (positive) vs. "aggressive" (negative)

    ### 4. The "Partial Fit" Trap (Multiple Blanks)
    **Trap**: Choosing based on one blank without checking others
    **Reality**: All blanks must work together
    **Example**: One perfect word doesn't matter if others don't fit

    ## Building Your Vocabulary

    ### Quality Over Quantity
    - Better to know 500 words well than 2000 superficially
    - Focus on understanding nuance and usage
    - Learn words in context, not lists

    ### Systematic Learning
    1. **Group by theme**: Positive traits, negative traits, change words
    2. **Learn synonyms together**: Similar words with subtle differences
    3. **Note antonyms**: Opposites help with contrast questions
    4. **Create sentences**: Use new words in context

    ### High-Value Word Categories
    - **Describing people**: traits, behaviors, communication styles
    - **Describing ideas**: complexity, validity, originality
    - **Change words**: increase, decrease, transform, preserve
    - **Speech/writing**: clarity, style, quantity of words
    - **Evaluation**: praise, criticism, neutrality

    ## Final Tips

    ### Practice Under Timed Conditions
    - Simulates test pressure
    - Improves pacing
    - Builds confidence

    ### Review Wrong Answers Carefully
    - Understand why wrong answer was tempting
    - Identify patterns in mistakes
    - Learn from errors

    ### Read Widely
    - Expands vocabulary naturally
    - Improves understanding of context
    - Builds reading speed

    ### Trust Your Preparation
    - Your first instinct is often correct
    - Don't second-guess excessively
    - Confidence comes from practice
  MD
  l.content_sections = [
    {
      anchor: 'triple-blank-strategy',
      title: 'Triple-Blank Questions',
      content: 'Approach for three-blank text completion'
    },
    {
      anchor: 'advanced-vocabulary',
      title: 'Advanced Vocabulary',
      content: 'Word roots, prefixes, and suffixes'
    },
    {
      anchor: 'time-optimization',
      title: 'Time Management',
      content: 'Question triage and pacing strategies'
    }
  ]
end

puts "✓ Created lesson: #{lesson_4.title}"

puts "✓ Total Text Completion questions: 25"
puts "Text Completion module completed successfully!"
