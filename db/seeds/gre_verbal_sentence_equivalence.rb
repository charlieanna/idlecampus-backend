# GRE Verbal Reasoning - Sentence Equivalence
# This seed file creates lessons and questions for Sentence Equivalence
# Students must select TWO words that produce sentences with equivalent meanings

puts "Creating GRE Sentence Equivalence content..."

course = Course.find_by!(slug: 'gre-verbal-reasoning')
sentence_equiv_module = course.course_modules.find_by!(slug: 'sentence-equivalence')

# Create quiz for the module
quiz = Quiz.find_or_create_by!(
  course_module: sentence_equiv_module,
  title: "#{sentence_equiv_module.title} Practice"
) do |q|
  q.description = "Practice questions for Sentence Equivalence"
  q.time_limit_minutes = 30
  q.passing_score = 70
end

# Lesson 1: Introduction to Sentence Equivalence
lesson_1 = CourseLesson.find_or_create_by!(
  course_module: sentence_equiv_module,
  slug: 'intro-sentence-equivalence'
) do |l|
  l.title = 'Introduction to Sentence Equivalence'
  l.sequence_order = 1
  l.reading_time_minutes = 25
  l.key_concepts = ['Sentence meaning', 'Synonym selection', 'Equivalent meanings', 'Answer strategy']
  l.content = <<~MD
    # Introduction to Sentence Equivalence

    ## What is Sentence Equivalence?

    Sentence Equivalence questions test your ability to:
    - Understand the overall meaning of a sentence
    - Identify words that fit the context
    - Recognize true synonyms in context
    - Create coherent, equivalent sentences

    ## Format
    - **One blank** in a sentence
    - **Six answer choices**
    - Select **TWO answers** that:
      - Fit the meaning of the sentence
      - Produce sentences that are **equivalent in meaning**
    - Both answers must be correct for credit
    - No partial credit

    ## Key Principle

    The two correct answers must be **interchangeable synonyms** that:
    - Create the same overall meaning
    - Maintain the same tone
    - Preserve the same logical relationships

    ### Example
    "The professor's explanation was so _____ that even students with no background in the subject could understand it."

    **Choices:**
    A. complex
    B. lucid
    C. verbose
    D. clear
    E. technical
    F. ambiguous

    **Analysis:**
    - Context: students with no background could understand
    - Need: something that makes understanding easy
    - Positive words related to clarity
    - **Answers: B (lucid) and D (clear)**
    - Both mean "easy to understand" and create equivalent sentences

    ## What Makes Sentences "Equivalent"?

    ### Same Core Meaning
    "The proposal was _____ by the committee."
    - **Rejected** and **dismissed**: Both mean not accepted
    - "The proposal was rejected" ≈ "The proposal was dismissed"

    ### Same Tone
    "The critic's review was _____."
    - **Harsh** and **scathing**: Both negative, strong criticism
    - NOT "negative" and "scathing" (different intensity)

    ### Same Implications
    "Her _____ behavior at the party surprised her friends."
    - **Reserved** and **restrained**: Both imply holding back
    - NOT "quiet" and "restrained" (different aspects)

    ## Strategy

    ### Step 1: Read and Understand Context
    - Read the complete sentence
    - Identify the tone (positive, negative, neutral)
    - Look for context clues
    - Predict what type of word fits

    ### Step 2: Predict Your Own Words
    Before looking at choices:
    - Think of simple words that fit
    - Consider the connotation needed
    - Think of synonyms for your prediction

    ### Step 3: Evaluate All Six Choices
    For each choice:
    - Does it fit the context?
    - Is it positive, negative, or neutral?
    - Does it match the intensity needed?

    ### Step 4: Find the Synonym Pair
    Among words that fit:
    - Which two are closest in meaning?
    - Do they create equivalent sentences?
    - Do they have the same connotation?

    ### Step 5: Verify with Both Answers
    Read the sentence twice:
    - Once with first answer
    - Once with second answer
    - Do both sentences mean the same thing?

    ## Common Patterns

    ### Pattern 1: Direct Synonyms
    Two words are near-perfect synonyms:
    - "The evidence was _____ and could not be disputed."
    - **Conclusive** and **definitive**: both mean impossible to dispute

    ### Pattern 2: Contextual Synonyms
    Words are synonymous in this specific context:
    - "The manager's _____ response to the crisis reassured employees."
    - **Swift** and **prompt**: both mean quick (in context of response)

    ### Pattern 3: Connotation Matching
    Words share the same connotation:
    - "The politician's speech was filled with _____ rhetoric."
    - **Inflammatory** and **provocative**: both negative, stirring emotion

    ### Pattern 4: Degree/Intensity Matching
    Words match in intensity:
    - "The earthquake caused _____ damage to the city."
    - **Catastrophic** and **devastating**: both extreme damage
    - NOT "serious" and "catastrophic" (different intensity)

    ## Trap Answers

    ### Trap 1: The "Also Fits" Word
    **Trap**: A word that fits the context but has no synonym pair
    **Example**: "The scientist was _____ in her research methods."
    - Rigorous (fits, no pair)
    - Meticulous (fits, pairs with "punctilious")
    - Punctilious (fits, pairs with "meticulous")
    - Creative (fits, no pair)
    - Careless (doesn't fit)
    - Sloppy (doesn't fit)
    **Answer**: Meticulous and punctilious (only pair)

    ### Trap 2: The "Close But Not Quite" Pair
    **Trap**: Two related words that aren't true synonyms
    **Example**: "The author's _____ style made the book accessible."
    - Simple ≠ Clear (related but not synonymous)
    - Straightforward = Lucid ✓ (true synonyms in context)

    ### Trap 3: The "Different Aspect" Pair
    **Trap**: Words describing different aspects of the same thing
    **Example**: "The teacher was _____ in her explanations."
    - Thorough (completeness)
    - Clear (understandability)
    - Both positive, both fit, but describe different qualities
    - NOT a synonym pair

    ### Trap 4: The "Wrong Tone" Pair
    **Trap**: Words with right meaning but wrong connotation
    **Example**: "The executive's _____ decision saved the company."
    - Bold (positive connotation) ✓
    - Rash (negative connotation) ✗
    - Same action type, different evaluation

    ## Context Clue Types

    ### Restatement Clues
    Sentence restates the meaning:
    - "The theory was _____, lacking empirical support."
    - "lacking empirical support" → unsubstantiated, unproven

    ### Contrast Clues
    Opposite of what's stated:
    - "Unlike his _____ colleagues, Dr. Smith was always willing to reconsider his theories."
    - Opposite of "willing to reconsider" → dogmatic, inflexible

    ### Example Clues
    Examples illustrate the blank:
    - "The historian's work was _____, incorporating sources from multiple disciplines."
    - "multiple disciplines" → interdisciplinary, multifaceted

    ### Cause-Effect Clues
    One leads to the other:
    - "The report's _____ findings led to immediate policy changes."
    - "immediate changes" suggests → alarming, disturbing

    ## Vocabulary Strategy

    ### Learn Synonym Clusters
    Group words by meaning:

    #### Praise/Positive
    - Outstanding: exceptional, remarkable, exemplary
    - Smart: astute, perspicacious, sagacious, shrewd
    - Skilled: adept, proficient, accomplished

    #### Criticism/Negative
    - Harsh: scathing, caustic, acerbic, vitriolic
    - Stubborn: obstinate, intractable, recalcitrant
    - Boring: mundane, banal, prosaic, pedestrian

    #### Neutral/Descriptive
    - Brief: concise, succinct, terse, laconic
    - Complex: intricate, convoluted, labyrinthine
    - Vague: nebulous, amorphous, ambiguous

    ### Note Subtle Differences
    Words may be similar but not identical:
    - **Thrifty** (positive) vs. **stingy** (negative)
    - **Confident** (positive) vs. **arrogant** (negative)
    - **Detailed** (neutral) vs. **verbose** (negative excess)

    ## Common Mistakes

    ### 1. Choosing First Two That Fit
    **Wrong**: Selecting first two words that work in the sentence
    **Right**: Ensuring those two are synonyms

    ### 2. Ignoring Connotation
    **Wrong**: Pairing words with different tones
    **Right**: Matching positive with positive, negative with negative

    ### 3. Assuming Rarity
    **Wrong**: Thinking both answers must be difficult words
    **Right**: One might be common, one more advanced

    ### 4. Forgetting Equivalence
    **Wrong**: Words that fit but create different meanings
    **Right**: Words that create identical meanings

    ## Time Management
    - **Target**: 45-60 seconds per question
    - These are generally faster than text completion
    - Clear synonym pairs are often apparent
    - If stuck after 1 minute, eliminate and guess

    ## Practice Approach

    ### 1. Read Completely
    Understand full context before evaluating choices

    ### 2. Predict First
    Think of your own words before looking at options

    ### 3. Eliminate Obviously Wrong
    Cross out words that clearly don't fit (wrong tone, wrong meaning)

    ### 4. Find the Pair
    Among remaining words, identify the synonym pair

    ### 5. Verify Equivalence
    Read both completed sentences to confirm they mean the same thing

    Remember: Both answers must create sentences with equivalent meanings. If the sentences have even slightly different implications, those words aren't the right pair.
  MD
  l.content_sections = [
    {
      anchor: 'sentence-equivalence-format',
      title: 'Understanding the Format',
      content: 'What makes sentences equivalent'
    },
    {
      anchor: 'equivalence-strategy',
      title: 'Core Strategy',
      content: 'Five-step approach to finding synonym pairs'
    },
    {
      anchor: 'trap-answers',
      title: 'Common Traps',
      content: 'Avoiding words that fit but aren\'t synonyms'
    }
  ]
end

puts "✓ Created lesson: #{lesson_1.title}"

# Lesson 2: Synonym Recognition and Vocabulary
lesson_2 = CourseLesson.find_or_create_by!(
  course_module: sentence_equiv_module,
  slug: 'synonym-recognition'
) do |l|
  l.title = 'Synonym Recognition and Vocabulary Building'
  l.sequence_order = 2
  l.reading_time_minutes = 30
  l.key_concepts = ['Synonym clusters', 'Connotation', 'Word relationships', 'Vocabulary groups']
  l.content = <<~MD
    # Synonym Recognition and Vocabulary Building

    ## The Importance of Synonym Recognition

    Sentence Equivalence questions fundamentally test whether you can:
    - Recognize words with similar meanings
    - Distinguish between true synonyms and related words
    - Understand nuanced differences in meaning
    - Apply synonyms correctly in context

    ## Synonym vs. Related Words

    ### True Synonyms (Interchangeable)
    Words that can replace each other without changing meaning:
    - **Significant** / **Substantial**: both mean "considerable in amount"
    - "A significant improvement" = "A substantial improvement"

    ### Related But Not Synonymous
    Words in the same semantic field but not interchangeable:
    - **Smart** / **Educated**: related to intelligence but different
    - Smart = naturally intelligent
    - Educated = learned through study
    - NOT always interchangeable

    ## Vocabulary Clusters

    ### Cluster 1: Words About Intelligence

    #### High Intelligence (Positive)
    - **Astute**: shrewd, showing sharp judgment
    - **Perspicacious**: having keen insight or understanding
    - **Sagacious**: having wisdom and good judgment
    - **Shrewd**: showing sharp judgment, especially in practical matters

    **Common pairs**: astute/shrewd, sagacious/wise, perspicacious/insightful

    #### Appearing Smart (Can Be Negative)
    - **Pedantic**: excessive concern with minor details or rules
    - **Pretentious**: attempting to impress by affecting importance

    ### Cluster 2: Words About Speaking/Writing

    #### Excessive Speech (Negative)
    - **Verbose**: using more words than needed
    - **Prolix**: tediously lengthy in speech or writing
    - **Garrulous**: excessively talkative, especially on trivial matters
    - **Loquacious**: very talkative

    **Common pairs**: verbose/prolix, garrulous/loquacious

    #### Brief Speech (Positive/Neutral)
    - **Concise**: expressing much in few words
    - **Succinct**: briefly and clearly expressed
    - **Terse**: using few words, sometimes abrupt
    - **Laconic**: using very few words

    **Common pairs**: concise/succinct, terse/laconic

    #### Clear Speech (Positive)
    - **Lucid**: clear and easy to understand
    - **Articulate**: expressing oneself clearly and effectively
    - **Coherent**: logical and consistent
    - **Eloquent**: fluent and persuasive in speaking

    **Common pairs**: lucid/clear, articulate/eloquent

    ### Cluster 3: Words About Stubbornness

    #### Negative Stubbornness
    - **Obstinate**: stubbornly refusing to change
    - **Intractable**: difficult to control or deal with
    - **Recalcitrant**: resistant to authority or control
    - **Obdurate**: stubbornly refusing to change one's opinion

    **Common pairs**: obstinate/obdurate, intractable/recalcitrant

    #### Positive Persistence
    - **Tenacious**: persistent and determined
    - **Resolute**: admirably purposeful and determined
    - **Steadfast**: resolutely firm and unwavering

    **Common pairs**: tenacious/persistent, resolute/steadfast

    ### Cluster 4: Words About Criticism

    #### Harsh Criticism (Negative)
    - **Scathing**: severely critical
    - **Caustic**: sarcastic in a harsh way
    - **Acerbic**: sharp and forthright in expression
    - **Vitriolic**: filled with bitter criticism
    - **Mordant**: sharply sarcastic or critical

    **Common pairs**: scathing/withering, caustic/acerbic, vitriolic/venomous

    #### Gentle Criticism
    - **Mild**: not severe or harsh
    - **Measured**: carefully considered
    - **Tempered**: moderated or restrained

    **Common pairs**: mild/gentle, measured/moderate

    ### Cluster 5: Words About Change

    #### Increase/Strengthen
    - **Augment**: make greater by adding to
    - **Amplify**: increase in size, extent, or quantity
    - **Enhance**: improve quality, value, or extent
    - **Bolster**: support or strengthen
    - **Fortify**: strengthen or reinforce

    **Common pairs**: augment/increase, enhance/improve, bolster/strengthen

    #### Decrease/Weaken
    - **Diminish**: make or become less
    - **Attenuate**: reduce in force, value, or effect
    - **Mitigate**: make less severe or serious
    - **Abate**: become less intense or widespread
    - **Undermine**: erode the base or foundation

    **Common pairs**: diminish/reduce, attenuate/weaken, mitigate/alleviate

    ### Cluster 6: Words About Attitude

    #### Optimistic/Positive
    - **Sanguine**: optimistic or positive in difficult situations
    - **Buoyant**: cheerful and optimistic

    **Common pairs**: sanguine/optimistic, buoyant/upbeat

    #### Pessimistic/Negative
    - **Cynical**: believing that people are motivated purely by self-interest
    - **Skeptical**: doubting the truth of claims
    - **Pessimistic**: expecting the worst outcome

    **Common pairs**: cynical/distrustful, skeptical/doubtful

    ### Cluster 7: Words About Behavior

    #### Secretive
    - **Furtive**: attempting to avoid notice or attention
    - **Surreptitious**: kept secret, especially because illicit
    - **Clandestine**: kept secret or done secretively
    - **Covert**: not openly acknowledged or displayed

    **Common pairs**: furtive/stealthy, surreptitious/clandestine, covert/secret

    #### Honest/Open
    - **Candid**: truthful and straightforward
    - **Forthright**: direct and outspoken
    - **Frank**: open, honest, and direct

    **Common pairs**: candid/frank, forthright/direct

    ### Cluster 8: Words About Commonness

    #### Common/Ordinary (Sometimes Negative)
    - **Mundane**: lacking interest or excitement
    - **Banal**: so lacking in originality as to be boring
    - **Prosaic**: commonplace or dull
    - **Pedestrian**: lacking inspiration or excitement

    **Common pairs**: mundane/ordinary, banal/trite, prosaic/pedestrian

    #### Rare/Unusual (Positive)
    - **Novel**: new and original
    - **Unprecedented**: never done or known before
    - **Singular**: exceptional or remarkable

    **Common pairs**: novel/innovative, unprecedented/unparalleled

    ## Connotation Mastery

    ### Positive Connotation
    Words that imply approval:
    - **Frugal**: economically careful (positive)
    - **Confident**: self-assured (positive)
    - **Bold**: courageous and daring (positive)
    - **Assertive**: confidently aggressive (positive)

    ### Negative Connotation
    Similar concepts, but disapproving:
    - **Stingy**: unwilling to spend (negative)
    - **Arrogant**: overbearing self-importance (negative)
    - **Reckless**: without thinking of consequences (negative)
    - **Pushy**: too aggressive (negative)

    ### Neutral Connotation
    Objective description:
    - **Economical**: using resources efficiently (neutral)
    - **Self-assured**: confident in oneself (neutral)
    - **Decisive**: able to make decisions quickly (neutral)

    ## Practice Techniques

    ### 1. Create Synonym Maps
    Start with a simple word, expand to synonyms:
    ```
    HAPPY
    ├─ Pleased (mild)
    ├─ Delighted (strong)
    ├─ Ecstatic (very strong)
    ├─ Content (quiet satisfaction)
    └─ Jubilant (expressing joy)
    ```

    ### 2. Study Synonym Pairs
    Focus on words that commonly appear together:
    - Scathing / Withering
    - Augment / Increase
    - Mitigate / Alleviate
    - Obstinate / Obdurate

    ### 3. Learn Antonym Pairs
    Understanding opposites helps with contrast:
    - Verbose ↔ Concise
    - Strengthen ↔ Undermine
    - Praise ↔ Criticize
    - Expand ↔ Contract

    ### 4. Practice in Context
    Don't memorize definitions—learn usage:
    - "Her **acerbic** wit offended some colleagues"
    - "His **caustic** remarks hurt her feelings"
    - Both describe sharp, hurtful criticism

    ## Word Relationship Patterns

    ### Degree Relationships
    Words along a spectrum:
    - Disappointed → Upset → Angry → Furious → Livid
    - Like → Appreciate → Admire → Revere → Worship

    ### Part-Whole Relationships
    General and specific:
    - Criticize (general) vs. Lambaste (specific type, very harsh)
    - Speak (general) vs. Harangue (specific type, aggressive)

    ### Category Relationships
    Words in same category:
    - All describe stubbornness: obstinate, intractable, recalcitrant
    - All describe wordiness: verbose, prolix, garrulous

    ## Quick Recognition Tips

    ### Look for Root Words
    Words sharing roots often have related meanings:
    - **duc/duct** (lead): deduce, induce, conducive
    - **cred** (believe): credible, incredible, credulous
    - **ben/bon** (good): benevolent, beneficial, benign

    ### Recognize Prefixes
    - **dis-** (not/opposite): disparage, discredit, dissuade
    - **mal-** (bad): malevolent, malicious, malady
    - **eu-** (good): euphemism, eulogy, euphoria

    ### Note Common Suffixes
    - **-ous** (full of): garrulous, ponderous, ambitious
    - **-ate** (verb): mitigate, exacerbate, ameliorate
    - **-ent/-ant** (adjective): eloquent, arrogant, vigilant

    ## Building Your Synonym Database

    ### Daily Practice
    1. Learn 5-10 new words per day in context
    2. Identify 2-3 synonyms for each
    3. Note connotation (positive/negative/neutral)
    4. Create example sentences

    ### Review System
    1. Week 1: Learn new words
    2. Week 2: Review and add synonyms
    3. Week 3: Practice in sentence equivalence questions
    4. Week 4: Test recall and usage

    ### Focus Areas for GRE
    Most tested word categories:
    1. Describing speech/writing style
    2. Describing personality traits
    3. Words about change (increase/decrease)
    4. Words about evaluation (praise/criticism)
    5. Words about commonness (rare/ordinary)

    Master these clusters and you'll recognize synonym pairs quickly on test day.
  MD
  l.content_sections = [
    {
      anchor: 'vocabulary-clusters',
      title: 'Vocabulary Clusters',
      content: 'Organized groups of related synonyms'
    },
    {
      anchor: 'connotation-mastery',
      title: 'Understanding Connotation',
      content: 'Positive, negative, and neutral word tones'
    },
    {
      anchor: 'practice-techniques',
      title: 'Practice Techniques',
      content: 'Building your synonym recognition skills'
    }
  ]
end

puts "✓ Created lesson: #{lesson_2.title}"

# Sentence Equivalence Questions (20 questions)
# Format: Question with 6 choices, TWO correct answers

sentence_equiv_questions = [
  {
    question: "The scientist's research was _____; she meticulously documented every observation and verified all data multiple times.",
    choices: ["careless", "rigorous", "innovative", "scrupulous", "hasty", "creative"],
    correct_indices: [1, 3], # rigorous, scrupulous
    difficulty: 0.0,
    explanation: "The context describes careful, thorough work: 'meticulously documented' and 'verified all data multiple times.' Both 'rigorous' and 'scrupulous' mean extremely thorough and careful. Innovative and creative describe originality, not thoroughness. Careless and hasty are the opposite of what's described."
  },
  {
    question: "Despite the urgency of the situation, the diplomat's response was _____, carefully avoiding any inflammatory language.",
    choices: ["measured", "reckless", "impulsive", "circumspect", "aggressive", "hasty"],
    correct_indices: [0, 3], # measured, circumspect
    difficulty: 0.2,
    explanation: "'Carefully avoiding inflammatory language' indicates a cautious, measured approach. 'Measured' means carefully thought out, and 'circumspect' means wary and unwilling to take risks. Reckless, impulsive, aggressive, and hasty are all opposites of the careful approach described."
  },
  {
    question: "The critic's _____ review left no doubt about her disapproval of the film.",
    choices: ["glowing", "scathing", "mild", "withering", "positive", "lukewarm"],
    correct_indices: [1, 3], # scathing, withering
    difficulty: 0.1,
    explanation: "'Left no doubt about her disapproval' indicates harsh, strong criticism. Both 'scathing' and 'withering' mean severely critical. Glowing and positive are opposites. Mild and lukewarm suggest weak criticism, not the strong disapproval described."
  },
  {
    question: "The author's writing style was unnecessarily _____; he used three paragraphs to express what could have been said in three sentences.",
    choices: ["concise", "verbose", "clear", "prolix", "succinct", "lucid"],
    correct_indices: [1, 3], # verbose, prolix
    difficulty: 0.3,
    explanation: "Using 'three paragraphs' for what could be 'three sentences' shows wordiness. 'Verbose' and 'prolix' both mean using more words than necessary. Concise and succinct mean brief (opposite). Clear and lucid describe clarity, not wordiness."
  },
  {
    question: "The manager's _____ decision to restructure the department, made without consulting anyone, alienated her staff.",
    choices: ["collaborative", "unilateral", "democratic", "arbitrary", "collective", "consensual"],
    correct_indices: [1, 3], # unilateral, arbitrary
    difficulty: 0.4,
    explanation: "'Made without consulting anyone' and 'alienated her staff' indicate a one-sided decision. 'Unilateral' means done by one person alone, and 'arbitrary' means based on personal whim without consultation. Collaborative, democratic, collective, and consensual all involve group input."
  },
  {
    question: "The evidence was _____, leaving no room for doubt about the defendant's guilt.",
    choices: ["ambiguous", "inconclusive", "definitive", "questionable", "incontrovertible", "dubious"],
    correct_indices: [2, 4], # definitive, incontrovertible
    difficulty: 0.1,
    explanation: "'Leaving no room for doubt' indicates absolute certainty. 'Definitive' means conclusively settled, and 'incontrovertible' means impossible to dispute. Ambiguous, inconclusive, questionable, and dubious all suggest uncertainty or doubt."
  },
  {
    question: "His explanation was so _____ that even experts in the field had difficulty understanding his point.",
    choices: ["lucid", "abstruse", "clear", "straightforward", "recondite", "simple"],
    correct_indices: [1, 4], # abstruse, recondite
    difficulty: 0.5,
    explanation: "If 'even experts...had difficulty understanding,' the explanation must be very complex or obscure. 'Abstruse' and 'recondite' both mean difficult to understand due to complexity. Lucid, clear, straightforward, and simple all mean easy to understand (opposite)."
  },
  {
    question: "The student's _____ behavior during the lecture—constant fidgeting and checking his phone—distracted other students.",
    choices: ["attentive", "focused", "restless", "engaged", "fidgety", "absorbed"],
    correct_indices: [2, 4], # restless, fidgety
    difficulty: -0.1,
    explanation: "'Constant fidgeting' directly describes restless, unable-to-sit-still behavior. 'Restless' and 'fidgety' both mean unable to stay still or quiet. Attentive, focused, engaged, and absorbed all describe paying attention (opposite)."
  },
  {
    question: "The company's financial situation was _____; bankruptcy seemed inevitable without immediate intervention.",
    choices: ["robust", "precarious", "stable", "dire", "healthy", "sound"],
    correct_indices: [1, 3], # precarious, dire
    difficulty: 0.2,
    explanation: "'Bankruptcy seemed inevitable' indicates a very bad financial situation. 'Precarious' means dangerously unstable, and 'dire' means extremely serious or urgent. Robust, stable, healthy, and sound all describe good financial health (opposite)."
  },
  {
    question: "The professor was known for her _____ lectures, which often incorporated references to literature, art, music, and current events.",
    choices: ["narrow", "specialized", "eclectic", "focused", "wide-ranging", "limited"],
    correct_indices: [2, 4], # eclectic, wide-ranging
    difficulty: 0.3,
    explanation: "Incorporating 'literature, art, music, and current events' shows diversity and variety. 'Eclectic' means deriving ideas from various sources, and 'wide-ranging' means covering an extensive area. Narrow, specialized, focused, and limited suggest restricted scope (opposite)."
  },
  {
    question: "The athlete's _____ training regimen, which included hours of practice every single day, led to her championship victory.",
    choices: ["sporadic", "rigorous", "intermittent", "demanding", "occasional", "irregular"],
    correct_indices: [1, 3], # rigorous, demanding
    difficulty: 0.1,
    explanation: "'Hours of practice every single day' indicates intense, challenging training. 'Rigorous' means extremely thorough and demanding, and 'demanding' means requiring much skill or effort. Sporadic, intermittent, occasional, and irregular suggest inconsistent training (opposite)."
  },
  {
    question: "Despite appearing _____ at first glance, the problem proved complex and multifaceted upon closer examination.",
    choices: ["complicated", "straightforward", "intricate", "simple", "convoluted", "elaborate"],
    correct_indices: [1, 3], # straightforward, simple
    difficulty: 0.4,
    explanation: "'Despite' signals contrast with 'complex and multifaceted.' The initial appearance must be the opposite: easy or simple. 'Straightforward' and 'simple' both mean uncomplicated. Complicated, intricate, convoluted, and elaborate all mean complex (no contrast)."
  },
  {
    question: "The executive's _____ remarks about competitors were inappropriate and damaged the company's professional reputation.",
    choices: ["diplomatic", "disparaging", "respectful", "derogatory", "courteous", "complimentary"],
    correct_indices: [1, 3], # disparaging, derogatory
    difficulty: 0.2,
    explanation: "'Inappropriate' and 'damaged...reputation' indicate negative, insulting comments. 'Disparaging' means expressing a low opinion, and 'derogatory' means showing a critical attitude. Diplomatic, respectful, courteous, and complimentary are all positive (opposite)."
  },
  {
    question: "The theory, once considered _____, gained acceptance after new evidence emerged.",
    choices: ["orthodox", "mainstream", "heretical", "conventional", "iconoclastic", "traditional"],
    correct_indices: [2, 4], # heretical, iconoclastic
    difficulty: 0.6,
    explanation: "A theory that was initially rejected but 'gained acceptance' must have originally contradicted established beliefs. 'Heretical' means contrary to accepted beliefs, and 'iconoclastic' means attacking cherished beliefs. Orthodox, mainstream, conventional, and traditional describe accepted views."
  },
  {
    question: "The negotiator's _____ handling of the dispute prevented the situation from escalating into open conflict.",
    choices: ["clumsy", "adroit", "inept", "skillful", "awkward", "bungling"],
    correct_indices: [1, 3], # adroit, skillful
    difficulty: 0.3,
    explanation: "'Prevented...escalating into conflict' indicates successful, skilled handling. 'Adroit' means clever or skillful, and 'skillful' means having skill. Clumsy, inept, awkward, and bungling all mean lacking skill (opposite)."
  },
  {
    question: "The artist's early work was _____, closely imitating the styles of established masters rather than showing originality.",
    choices: ["innovative", "derivative", "pioneering", "imitative", "original", "groundbreaking"],
    correct_indices: [1, 3], # derivative, imitative
    difficulty: 0.2,
    explanation: "'Closely imitating' and 'rather than showing originality' describe copying. 'Derivative' means imitative of someone else's work, and 'imitative' means copying. Innovative, pioneering, original, and groundbreaking all mean creative/original (opposite)."
  },
  {
    question: "His _____ personality made him popular at social gatherings; he was always chatting with someone new.",
    choices: ["introverted", "gregarious", "reserved", "withdrawn", "sociable", "reclusive"],
    correct_indices: [1, 4], # gregarious, sociable
    difficulty: 0.0,
    explanation: "'Popular at social gatherings' and 'always chatting with someone new' describe an outgoing person. 'Gregarious' and 'sociable' both mean enjoying the company of others. Introverted, reserved, withdrawn, and reclusive describe avoiding social interaction (opposite)."
  },
  {
    question: "The prosecutor presented _____ evidence that left little doubt in the jury's minds.",
    choices: ["compelling", "weak", "unconvincing", "persuasive", "dubious", "questionable"],
    correct_indices: [0, 3], # compelling, persuasive
    difficulty: 0.1,
    explanation: "'Left little doubt' indicates strong, convincing evidence. 'Compelling' means strongly convincing, and 'persuasive' means able to convince. Weak, unconvincing, dubious, and questionable all suggest evidence that creates doubt (opposite)."
  },
  {
    question: "The government's response to the crisis was _____; officials seemed unable to agree on a coherent course of action.",
    choices: ["decisive", "unified", "disorganized", "coordinated", "chaotic", "systematic"],
    correct_indices: [2, 4], # disorganized, chaotic
    difficulty: 0.3,
    explanation: "'Unable to agree on a coherent course of action' indicates confusion and lack of organization. 'Disorganized' and 'chaotic' both mean lacking organization. Decisive, unified, coordinated, and systematic all describe organized, purposeful action (opposite)."
  },
  {
    question: "The memoir was praised for its _____ portrayal of the author's childhood, unflinchingly revealing both joyful and painful memories.",
    choices: ["evasive", "sanitized", "candid", "guarded", "frank", "circumspect"],
    correct_indices: [2, 4], # candid, frank
    difficulty: 0.4,
    explanation: "'Unflinchingly revealing both joyful and painful memories' indicates complete honesty. 'Candid' means truthfully direct, and 'frank' means open and honest. Evasive, sanitized, guarded, and circumspect all suggest holding back information (opposite)."
  }
]

sentence_equiv_questions.each_with_index do |qdata, index|
  # For MCQ format, we need to indicate that TWO answers are correct
  # We'll format the correct answers differently
  correct_answer_texts = qdata[:correct_indices].map { |i| qdata[:choices][i] }

  question = QuizQuestion.find_or_create_by!(
    quiz: quiz,
    question_text: "#{qdata[:question]}\n\n[Select TWO answer choices]",
    question_type: 'mcq'
  ) do |q|
    q.options = qdata[:choices].map.with_index do |choice, i|
      { text: choice, correct: qdata[:correct_indices].include?(i) }
    end
    q.difficulty = qdata[:difficulty]
    q.discrimination = 1.5
    q.guessing = 0.1
    q.explanation = qdata[:explanation] + "\n\nCorrect answers: #{correct_answer_texts.join(' and ')}"
  end

  QuizQuestionLessonMapping.create!(
    quiz_question: question,
    course_lesson: lesson_2,
    relevance_weight: 85 + (index % 12),
    section_anchor: 'vocabulary-clusters'
  )
end

puts "✓ Created 20 sentence equivalence questions"

# Lesson 3: Advanced Sentence Equivalence Strategies
lesson_3 = CourseLesson.find_or_create_by!(
  course_module: sentence_equiv_module,
  slug: 'advanced-sentence-equivalence'
) do |l|
  l.title = 'Advanced Sentence Equivalence Strategies'
  l.sequence_order = 3
  l.reading_time_minutes = 20
  l.key_concepts = ['Advanced vocabulary', 'Subtle distinctions', 'Test-taking tips', 'Error analysis']
  l.content = <<~MD
    # Advanced Sentence Equivalence Strategies

    ## Mastering Difficult Questions

    ### Challenge 1: Subtle Distinctions
    Some questions feature multiple words that fit but only one true synonym pair.

    **Example:**
    "The teacher's approach was _____, tailored to each student's individual needs."

    **Choices:**
    A. personalized
    B. customized
    C. flexible
    D. adaptive
    E. rigid
    F. standardized

    **Analysis:**
    - A, B, C, D all fit positively
    - But which are TRUE synonyms?
    - **Personalized** and **customized**: both mean tailored to individual
    - **Flexible** and **adaptive**: relate to changing, not individualization
    - **Answer: A and B**

    ### Challenge 2: Connotation Traps
    Words with similar denotations but different connotations.

    **Example:**
    "The detective's _____ questioning revealed inconsistencies in the witness's testimony."

    **Choices:**
    A. persistent
    B. relentless
    C. gentle
    D. thorough
    E. aggressive
    F. comprehensive

    **Analysis:**
    - Multiple positive words fit
    - Need synonyms that match "revealed inconsistencies"
    - **Thorough** and **comprehensive**: both mean complete and detailed
    - Persistent/relentless suggest repetition, not completeness
    - Aggressive is too negative
    - **Answer: D and F**

    ### Challenge 3: Register/Formality Matching
    Words must match the sentence's level of formality.

    **Example:**
    "The executive's _____ for expensive cars was well known among colleagues."

    **Choices:**
    A. love
    B. penchant
    C. passion
    D. predilection
    E. obsession
    F. fondness

    **Analysis:**
    - Many words mean "liking"
    - Formal context ("executive," "colleagues")
    - **Penchant** and **predilection**: both formal words for strong liking
    - Love, passion too emotional
    - Obsession too extreme
    - Fondness too mild
    - **Answer: B and D**

    ## Advanced Vocabulary Techniques

    ### Technique 1: Etymology
    Understanding word origins helps recognize relationships:

    - **Loquacious** (Latin: loqui = to speak) → talkative
    - **Garrulous** (Latin: garrire = to chatter) → talkative
    - Shared meaning: overly talkative

    ### Technique 2: Prefixes and Suffixes
    Decode unfamiliar words:

    - **In-credible** (not-believable) → hard to believe
    - **Un-precedented** (not-gone before) → never happened before
    - These share "never before" meaning

    ### Technique 3: Context-Based Deduction
    Use sentence structure when vocabulary is challenging:

    "The philosopher's argument was _____; even experts found it difficult to understand."

    - Don't know all six words?
    - "difficult to understand" tells you: complex, obscure, unclear
    - Look for two words meaning "hard to comprehend"
    - **Abstruse** and **recondite** both fit (even if unfamiliar)

    ## Error Pattern Analysis

    ### Common Error 1: Choosing "Close Enough"
    **Mistake:** Selecting words that are related but not synonymous
    **Example:** "Fast" and "early" (both time-related but different meanings)
    **Fix:** Verify that both words are truly interchangeable

    ### Common Error 2: Ignoring Intensity
    **Mistake:** Pairing words with different intensity levels
    **Example:** "Angry" and "livid" (both negative but different intensity)
    **Fix:** Match intensity level—mild with mild, extreme with extreme

    ### Common Error 3: Missing Negative Context
    **Mistake:** Choosing positive words when context is negative
    **Example:** Praising word in sentence about failure
    **Fix:** Identify tone first, then find synonyms

    ### Common Error 4: Stopping Too Soon
    **Mistake:** Selecting first two words that fit
    **Example:** Not checking if they're actually synonyms
    **Fix:** Always verify equivalence after selecting

    ## Rapid Recognition Strategies

    ### Strategy 1: Word Family Recognition
    Quickly identify word families:

    **Family: "Talkative"**
    - Verbose, prolix, garrulous, loquacious, voluble
    - If you see two from this family, likely the answer

    **Family: "Stubborn"**
    - Obstinate, obdurate, intractable, recalcitrant
    - Recognize the pattern instantly

    **Family: "Criticism"**
    - Scathing, caustic, acerbic, vitriolic, mordant
    - Common pair in sentence equivalence

    ### Strategy 2: Elimination by Tone
    1. Determine context tone (positive/negative/neutral)
    2. Eliminate opposite tone words immediately
    3. Find synonyms among remaining words

    **Example:**
    "Despite initial enthusiasm, the project's results were _____."

    - "Despite" suggests contrast
    - "initial enthusiasm" → results must be negative
    - Eliminate all positive words
    - Find negative synonym pair

    ### Strategy 3: The "Swap Test"
    Read sentence with each word:
    - Do both create the same meaning?
    - Do both sound natural?
    - Could both be correct in other contexts?

    If all three are YES, you've found your pair.

    ## Time Management for Sentence Equivalence

    ### Time Allocation
    - **45-60 seconds per question**
    - Fastest question type on Verbal section
    - Clear synonym pairs are often obvious
    - Don't overthink

    ### When to Move On
    If after 60 seconds you're stuck:
    1. Eliminate obviously wrong answers
    2. Identify words that fit the context
    3. Select the most likely synonym pair
    4. Mark for review if time permits
    5. Move to next question

    ### Priority Order
    If running short on time:
    1. Do sentence equivalence first (fastest)
    2. Then text completion
    3. Finally reading comprehension (most time-intensive)

    ## Practice Exercises

    ### Exercise 1: Synonym Pair Identification
    Look at these six words. Which two are closest in meaning?

    ambitious, lazy, industrious, creative, diligent, innovative

    **Answer:** industrious and diligent (both mean hardworking)

    ### Exercise 2: Context Fitting
    Which two words fit AND are synonyms?

    "The lawyer's _____ argument convinced the jury."

    compelling, weak, persuasive, confusing, lengthy, boring

    **Answer:** compelling and persuasive

    ### Exercise 3: Tone Matching
    Negative context—find the synonym pair:

    "The critic's _____ review upset the playwright."

    positive, harsh, favorable, scathing, complimentary, glowing

    **Answer:** harsh and scathing

    ## Advanced Tips

    ### Tip 1: Build Synonym Networks
    Don't learn words in isolation. Create networks:

    ```
    SMART (center)
    ├─ Astute (shrewd judgment)
    ├─ Sagacious (wise judgment)
    ├─ Perspicacious (keen insight)
    └─ Shrewd (practical intelligence)
    ```

    ### Tip 2: Practice with Thesaurus
    Look up common words, study their synonyms:
    - Note nuanced differences
    - Identify true synonyms vs. related words
    - Practice using in sentences

    ### Tip 3: Learn Word Pairs
    Some pairs appear frequently on GRE:
    - Augment / Amplify
    - Mitigate / Alleviate
    - Obstinate / Obdurate
    - Verbose / Prolix
    - Scathing / Withering

    ### Tip 4: Read Actively
    When reading anything:
    - Note interesting vocabulary
    - Think of synonyms
    - Consider connotation
    - Practice mental substitution

    ### Tip 5: Trust Your Instinct
    - First choice is often correct
    - Don't second-guess excessively
    - If two words feel like synonyms, they probably are

    ## Final Reminders

    ### Remember the Goal
    You're looking for two words that:
    1. Both fit the sentence context
    2. Are synonymous with each other
    3. Create sentences with equivalent meaning

    ### Avoid Perfectionism
    - You don't need to know every word
    - Context helps decode unfamiliar terms
    - Elimination is powerful
    - Educated guessing is strategic

    ### Stay Confident
    - Sentence equivalence rewards vocabulary study
    - Pattern recognition improves with practice
    - Your preparation will pay off

    With consistent practice, you'll start recognizing synonym pairs almost instantly. The key is exposure to vocabulary in context and understanding not just definitions but relationships between words.
  MD
  l.content_sections = [
    {
      anchor: 'advanced-challenges',
      title: 'Mastering Difficult Questions',
      content: 'Handling subtle distinctions and traps'
    },
    {
      anchor: 'rapid-recognition',
      title: 'Rapid Recognition Strategies',
      content: 'Quickly identifying synonym pairs'
    },
    {
      anchor: 'advanced-tips',
      title: 'Advanced Tips and Techniques',
      content: 'Building synonym networks and trusting instincts'
    }
  ]
end

puts "✓ Created lesson: #{lesson_3.title}"

puts "✓ Total Sentence Equivalence questions: 20"
puts "Sentence Equivalence module completed successfully!"
puts ""
puts "=" * 60
puts "GRE VERBAL REASONING COURSE SUMMARY"
puts "=" * 60
puts ""
puts "MODULE 1: Reading Comprehension"
puts "  - 4 lessons covering strategies and passage types"
puts "  - 20 questions across 3 passages (Science, Humanities, Social Science)"
puts ""
puts "MODULE 2: Text Completion"
puts "  - 4 lessons covering single, double, and triple-blank strategies"
puts "  - 25 questions (15 single-blank, 10 double-blank)"
puts ""
puts "MODULE 3: Sentence Equivalence"
puts "  - 3 lessons covering synonym recognition and strategies"
puts "  - 20 questions testing vocabulary and synonym pairing"
puts ""
puts "TOTAL: 11 lessons, 65 questions"
puts "=" * 60
