# Options Trading Course - Complete Edition
# Comprehensive options trading education with 4 modules and 16 lessons
# Covers: Basics, Strategies, Greeks, and Risk Management
# Each lesson: Teaching Content + Worked Examples + Practice Exercises

puts "=" * 80
puts "Options Trading - Complete Course"
puts "16 Lessons | 80 Practice Questions | 4 Modules"
puts "=" * 80

# Create Course
course = Course.find_or_create_by!(slug: 'options-trading') do |c|
  c.title = 'Options Trading Mastery'
  c.description = 'Complete options trading education from fundamentals to advanced risk management. Master 12+ strategies, understand all Greeks (Delta, Gamma, Theta, Vega), implement professional position sizing, portfolio hedging, volatility trading, and dynamic adjustments. 16 comprehensive lessons with 80 practice questions and real-world examples.'
  c.difficulty_level = 'intermediate'
  c.certification_track = 'none'
  c.published = true
  c.estimated_hours = 50
end

puts "✓ Course: #{course.title}"

# =============================================================================
# MODULE 1: OPTIONS BASICS (20 questions across 4 lessons)
# =============================================================================
module_basics = course.course_modules.find_or_create_by!(slug: 'options-basics') do |m|
  m.title = 'Options Basics'
  m.description = 'Introduction to options, terminology, call and put options, and basic mechanics'
  m.sequence_order = 1
  m.estimated_minutes = 600
  m.published = true
end

puts "✓ Module 1: Options Basics"

# Helper method to create lesson-quiz pairs
def create_lesson_quiz_pair(module_obj, lesson_data, quiz_data, questions, lesson_num)
  # Create Lesson
  lesson = CourseLesson.find_or_create_by!(slug: lesson_data[:slug]) do |l|
    l.title = lesson_data[:title]
    l.content = lesson_data[:content]
    l.reading_time_minutes = lesson_data[:reading_time] || 15
    l.key_concepts = lesson_data[:key_concepts] || []
  end

  ModuleItem.find_or_create_by!(course_module: module_obj, item: lesson) do |mi|
    mi.item_type = 'CourseLesson'
    mi.sequence_order = (lesson_num * 2) - 1
  end

  # Create Quiz
  quiz = Quiz.find_or_create_by!(title: quiz_data[:title]) do |q|
    q.description = quiz_data[:description]
    q.time_limit_minutes = quiz_data[:time_limit] || 15
    q.passing_score = quiz_data[:passing_score] || 60
    q.quiz_type = 'standard'
  end

  ModuleItem.find_or_create_by!(course_module: module_obj, item: quiz) do |mi|
    mi.item_type = 'Quiz'
    mi.sequence_order = lesson_num * 2
  end

  # Create Questions
  questions.each_with_index do |q, idx|
    QuizQuestion.find_or_create_by!(quiz: quiz, question_text: q[:text]) do |qq|
      qq.question_type = 'mcq'
      qq.options = q[:options]
      qq.multiple_correct = q[:multiple_correct] || false
      qq.explanation = q[:explanation]
      qq.points = q[:level] == 'easy' ? 2 : (q[:level] == 'medium' ? 3 : 4)
      qq.difficulty = q[:difficulty]
      qq.discrimination = 1.2 + (idx * 0.02)
      qq.guessing = qq.multiple_correct ? 0.1 : 0.2
      qq.difficulty_level = q[:level]
      qq.topic = q[:topic]
      qq.skill_dimension = 'finance'
      qq.sequence_order = idx + 1
    end

    question_record = QuizQuestion.find_by(quiz: quiz, question_text: q[:text])
    if question_record
      QuizQuestionLessonMapping.find_or_create_by!(
        quiz_question: question_record,
        course_lesson: lesson
      ) do |mapping|
        mapping.relevance_weight = 90
        mapping.section_anchor = q[:section_anchor] || 'main-content'
      end
    end
  end

  puts "  ✓ #{lesson_data[:title]} (#{questions.length} questions)"
end

# -----------------------------------------------------------------------------
# Lesson 1.1: Introduction to Options
# -----------------------------------------------------------------------------
lesson_intro = {
  slug: 'options-introduction',
  title: 'Introduction to Options',
  reading_time: 15,
  key_concepts: ['options', 'derivatives', 'contracts', 'underlying-assets'],
  content: <<~MARKDOWN
    # Introduction to Options

    ## What is an Option?

    An **option** is a financial derivative that gives the buyer the **right, but not the obligation**, to buy or sell an underlying asset at a specified price (strike price) on or before a specified date (expiration date).

    ### Key Characteristics:
    - **Derivative:** Value derived from an underlying asset (stocks, ETFs, indices)
    - **Contract:** Legal agreement between buyer and seller
    - **Rights vs Obligations:** Buyer has rights, seller has obligations
    - **Premium:** Price paid to purchase the option

    ## Types of Options

    ### Call Options
    - Gives the buyer the **right to buy** the underlying asset
    - Buyer profits when asset price increases
    - Used when bullish on the underlying asset

    ### Put Options
    - Gives the buyer the **right to sell** the underlying asset
    - Buyer profits when asset price decreases
    - Used when bearish on the underlying asset

    ## Option Terminology

    ### Strike Price (Exercise Price)
    The predetermined price at which the underlying asset can be bought (call) or sold (put).

    **Example:** XYZ $100 call means the right to buy XYZ stock at $100 per share.

    ### Expiration Date
    The date when the option contract expires and becomes worthless if not exercised.

    **Example:** Options typically expire on the third Friday of the expiration month.

    ### Premium
    The price paid by the option buyer to the option seller.

    **Example:** If you buy a call option for $5, the premium is $5 per share, or $500 per contract (100 shares).

    ## Why Trade Options?

    1. **Leverage:** Control large positions with small capital
    2. **Flexibility:** Profit in any market direction
    3. **Risk Management:** Hedge existing positions
    4. **Income Generation:** Sell options for premium income

    ## Options Standardization

    - **Contract Size:** 1 option contract = 100 shares
    - **Premium Quote:** Quoted per share (multiply by 100 for total cost)
    - **Strike Prices:** Standardized intervals ($1, $2.50, $5, $10)
    - **Expiration Dates:** Third Friday of expiration month (typically)

    ## Example

    **Buying a Call Option:**
    - Stock: XYZ trading at $50
    - Buy 1 XYZ $55 Call expiring in 30 days for $2 premium
    - Total Cost: $2 × 100 = $200
    - Breakeven: $57 ($55 strike + $2 premium)
    - Max Loss: $200 (premium paid)
    - Max Gain: Unlimited (as stock price rises)

    ## Trading Tips

    1. Options are wasting assets - time decay accelerates as expiration approaches
    2. Always consider the premium cost in your profit calculations
    3. Understand your maximum risk before entering any trade
    4. Start with liquid options (high volume and open interest)
  MARKDOWN
}

quiz_intro = {
  title: 'Introduction to Options Practice',
  description: 'Test your understanding of basic options concepts',
  time_limit: 15
}

questions_intro = [
  {
    text: 'What right does a call option give to the buyer?',
    options: [
      { text: 'The right to sell the underlying asset', correct: false },
      { text: 'The right to buy the underlying asset', correct: true },
      { text: 'The obligation to buy the underlying asset', correct: false },
      { text: 'The obligation to sell the underlying asset', correct: false },
      { text: 'No rights, only obligations', correct: false }
    ],
    explanation: 'A call option gives the buyer the right (not obligation) to buy the underlying asset at the strike price.',
    difficulty: -1.0,
    topic: 'options-basics',
    level: 'easy',
    section_anchor: 'types-of-options'
  },
  {
    text: 'How many shares does one standard options contract represent?',
    options: [
      { text: '1 share', correct: false },
      { text: '10 shares', correct: false },
      { text: '50 shares', correct: false },
      { text: '100 shares', correct: true },
      { text: '1,000 shares', correct: false }
    ],
    explanation: 'One standard options contract represents 100 shares of the underlying asset.',
    difficulty: -0.8,
    topic: 'contract-specifications',
    level: 'easy',
    section_anchor: 'options-standardization'
  },
  {
    text: 'What is the premium in options trading?',
    options: [
      { text: 'The strike price of the option', correct: false },
      { text: 'The price of the underlying stock', correct: false },
      { text: 'The price paid to purchase the option', correct: true },
      { text: 'The profit from the option trade', correct: false },
      { text: 'The expiration date', correct: false }
    ],
    explanation: 'The premium is the price paid by the option buyer to the option seller for the rights conferred by the option contract.',
    difficulty: -0.9,
    topic: 'options-basics',
    level: 'easy',
    section_anchor: 'option-terminology'
  },
  {
    text: 'If you buy 1 XYZ call option with a strike price of $50 for a premium of $3, what is your total investment?',
    options: [
      { text: '$3', correct: false },
      { text: '$50', correct: false },
      { text: '$53', correct: false },
      { text: '$300', correct: true },
      { text: '$5,000', correct: false }
    ],
    explanation: 'Premium is $3 per share, and one contract = 100 shares. Total investment = $3 × 100 = $300.',
    difficulty: -0.5,
    topic: 'contract-specifications',
    level: 'medium',
    section_anchor: 'example'
  },
  {
    text: 'Which type of option would you buy if you believe a stock price will decrease?',
    options: [
      { text: 'Call option', correct: false },
      { text: 'Put option', correct: true },
      { text: 'Both call and put', correct: false },
      { text: 'Neither', correct: false },
      { text: 'Forward contract', correct: false }
    ],
    explanation: 'A put option gives you the right to sell at the strike price, which becomes profitable when the stock price decreases below the strike price minus premium.',
    difficulty: -0.6,
    topic: 'options-basics',
    level: 'easy',
    section_anchor: 'types-of-options'
  }
]

create_lesson_quiz_pair(module_basics, lesson_intro, quiz_intro, questions_intro, 1)

# -----------------------------------------------------------------------------
# Lesson 1.2: Call Options
# -----------------------------------------------------------------------------
lesson_calls = {
  slug: 'call-options',
  title: 'Understanding Call Options',
  reading_time: 15,
  key_concepts: ['call-options', 'long-call', 'short-call', 'profit-loss'],
  content: <<~MARKDOWN
    # Understanding Call Options

    ## What is a Call Option?

    A **call option** gives the buyer the right to **buy** the underlying asset at the strike price before expiration.

    ### Call Option Positions

    1. **Long Call (Buying a Call):** Bullish position
    2. **Short Call (Selling/Writing a Call):** Bearish or neutral position

    ## Long Call (Buying Calls)

    ### When to Use:
    - Expect the underlying stock price to rise
    - Want leveraged exposure with limited risk
    - Speculating on upward price movement

    ### Profit/Loss Profile:

    **Maximum Profit:** Unlimited
    - Profit increases as stock price rises above strike price
    - Profit = (Stock Price - Strike Price - Premium) × 100

    **Maximum Loss:** Premium Paid (Limited)
    - Occurs if stock price is at or below strike at expiration
    - Loss = Premium × 100

    **Breakeven Point:** Strike Price + Premium

    ### Example: Long Call

    **Setup:**
    - Stock XYZ trading at $50
    - Buy 1 XYZ $55 Call for $2 premium
    - Expiration: 30 days

    **Investment:** $2 × 100 = $200

    **Scenarios at Expiration:**

    1. **Stock at $60 (above strike):**
       - Intrinsic Value: $60 - $55 = $5
       - Profit: ($5 - $2) × 100 = $300
       - Return: 150%

    2. **Stock at $57 (breakeven):**
       - Intrinsic Value: $57 - $55 = $2
       - Profit: ($2 - $2) × 100 = $0
       - Return: 0%

    3. **Stock at $50 (below strike):**
       - Option expires worthless
       - Loss: $200 (100% of premium)

    ## Short Call (Selling Calls)

    ### When to Use:
    - Expect the stock price to remain flat or decline
    - Want to generate income from premium
    - Willing to sell stock if price rises (covered call)

    ### Profit/Loss Profile:

    **Maximum Profit:** Premium Received (Limited)
    - Occurs if stock price is at or below strike at expiration

    **Maximum Loss:** Unlimited
    - Loss increases as stock price rises above strike
    - Loss = (Stock Price - Strike Price - Premium) × 100

    **Breakeven Point:** Strike Price + Premium

    ### Example: Short Call (Naked)

    **Setup:**
    - Stock XYZ trading at $50
    - Sell 1 XYZ $55 Call for $2 premium
    - Expiration: 30 days

    **Credit Received:** $2 × 100 = $200

    **Scenarios at Expiration:**

    1. **Stock at $50 (below strike):**
       - Option expires worthless
       - Profit: $200 (keep entire premium)

    2. **Stock at $57 (breakeven):**
       - Loss on stock offset by premium
       - Profit: $0

    3. **Stock at $65 (above strike):**
       - Must sell stock at $55
       - Loss: [($65 - $55) - $2] × 100 = $800

    ## In-the-Money (ITM) vs At-the-Money (ATM) vs Out-of-the-Money (OTM)

    ### For Call Options:

    - **ITM:** Stock Price > Strike Price (Has intrinsic value)
    - **ATM:** Stock Price = Strike Price
    - **OTM:** Stock Price < Strike Price (Only time value)

    **Example:** Stock at $50
    - $45 Call: ITM (intrinsic value = $5)
    - $50 Call: ATM
    - $55 Call: OTM (no intrinsic value)

    ## Key Concepts

    ### Intrinsic Value (Call)
    ```
    Intrinsic Value = Max(0, Stock Price - Strike Price)
    ```

    ### Time Value
    ```
    Time Value = Premium - Intrinsic Value
    ```

    **Example:** Stock at $52, $50 Call trading at $4
    - Intrinsic Value: $52 - $50 = $2
    - Time Value: $4 - $2 = $2

    ## Trading Tips

    1. **Long Calls:** Buy with enough time (60+ days) to be right
    2. **Strike Selection:** Balance probability and potential return
    3. **Risk Management:** Never risk more than you can afford to lose
    4. **Exit Strategy:** Set profit targets and stop losses before entering
  MARKDOWN
}

quiz_calls = {
  title: 'Call Options Practice',
  description: 'Test your understanding of call options',
  time_limit: 15
}

questions_calls = [
  {
    text: 'You buy a call option with a strike price of $50 for a premium of $3. At expiration, the stock is at $58. What is your profit?',
    options: [
      { text: '$300', correct: false },
      { text: '$500', correct: true },
      { text: '$800', correct: false },
      { text: '$200', correct: false },
      { text: '-$300', correct: false }
    ],
    explanation: 'Profit = (Stock Price - Strike - Premium) × 100 = ($58 - $50 - $3) × 100 = $5 × 100 = $500',
    difficulty: -0.4,
    topic: 'call-profit-loss',
    level: 'medium',
    section_anchor: 'long-call'
  },
  {
    text: 'What is the maximum loss when buying a call option?',
    options: [
      { text: 'Unlimited', correct: false },
      { text: 'The premium paid', correct: true },
      { text: 'The strike price', correct: false },
      { text: 'The stock price', correct: false },
      { text: 'Zero', correct: false }
    ],
    explanation: 'The maximum loss when buying (long) a call option is limited to the premium paid. The option simply expires worthless in the worst case.',
    difficulty: -0.8,
    topic: 'call-risk',
    level: 'easy',
    section_anchor: 'long-call'
  },
  {
    text: 'A stock is trading at $55. What is the intrinsic value of a $50 call option?',
    options: [
      { text: '$0', correct: false },
      { text: '$3', correct: false },
      { text: '$5', correct: true },
      { text: '$50', correct: false },
      { text: '$55', correct: false }
    ],
    explanation: 'Intrinsic value of a call = Stock Price - Strike Price = $55 - $50 = $5',
    difficulty: -0.5,
    topic: 'intrinsic-value',
    level: 'easy',
    section_anchor: 'key-concepts'
  },
  {
    text: 'You bought a $60 call for $4 when the stock was at $58. The stock is now at $65. What is your breakeven price?',
    options: [
      { text: '$58', correct: false },
      { text: '$60', correct: false },
      { text: '$62', correct: false },
      { text: '$64', correct: true },
      { text: '$65', correct: false }
    ],
    explanation: 'Breakeven for a long call = Strike Price + Premium = $60 + $4 = $64',
    difficulty: -0.3,
    topic: 'breakeven',
    level: 'medium',
    section_anchor: 'long-call'
  },
  {
    text: 'What is the maximum profit potential when selling a naked call option?',
    options: [
      { text: 'Unlimited', correct: false },
      { text: 'The premium received', correct: true },
      { text: 'The strike price', correct: false },
      { text: 'The stock price', correct: false },
      { text: 'The strike price minus premium', correct: false }
    ],
    explanation: 'When selling a call, the maximum profit is limited to the premium received. This occurs when the option expires worthless (stock below strike).',
    difficulty: -0.6,
    topic: 'short-call',
    level: 'easy',
    section_anchor: 'short-call'
  }
]

create_lesson_quiz_pair(module_basics, lesson_calls, quiz_calls, questions_calls, 2)

# -----------------------------------------------------------------------------
# Lesson 1.3: Put Options
# -----------------------------------------------------------------------------
lesson_puts = {
  slug: 'put-options',
  title: 'Understanding Put Options',
  reading_time: 15,
  key_concepts: ['put-options', 'long-put', 'short-put', 'protective-put'],
  content: <<~MARKDOWN
    # Understanding Put Options

    ## What is a Put Option?

    A **put option** gives the buyer the right to **sell** the underlying asset at the strike price before expiration.

    ### Put Option Positions

    1. **Long Put (Buying a Put):** Bearish position
    2. **Short Put (Selling/Writing a Put):** Bullish or neutral position

    ## Long Put (Buying Puts)

    ### When to Use:
    - Expect the underlying stock price to fall
    - Want to hedge a long stock position (protective put)
    - Speculating on downward price movement with limited risk

    ### Profit/Loss Profile:

    **Maximum Profit:** Strike Price - Premium (Large but limited)
    - Profit increases as stock price falls
    - Maximum when stock goes to $0
    - Profit = (Strike Price - Stock Price - Premium) × 100

    **Maximum Loss:** Premium Paid (Limited)
    - Occurs if stock price is at or above strike at expiration
    - Loss = Premium × 100

    **Breakeven Point:** Strike Price - Premium

    ### Example: Long Put

    **Setup:**
    - Stock XYZ trading at $50
    - Buy 1 XYZ $50 Put for $3 premium
    - Expiration: 30 days

    **Investment:** $3 × 100 = $300

    **Scenarios at Expiration:**

    1. **Stock at $40 (below strike):**
       - Intrinsic Value: $50 - $40 = $10
       - Profit: ($10 - $3) × 100 = $700
       - Return: 233%

    2. **Stock at $47 (breakeven):**
       - Intrinsic Value: $50 - $47 = $3
       - Profit: ($3 - $3) × 100 = $0
       - Return: 0%

    3. **Stock at $55 (above strike):**
       - Option expires worthless
       - Loss: $300 (100% of premium)

    ## Short Put (Selling Puts)

    ### When to Use:
    - Expect the stock price to remain flat or rise
    - Want to generate income from premium
    - Willing to buy stock if price falls (cash-secured put)

    ### Profit/Loss Profile:

    **Maximum Profit:** Premium Received (Limited)
    - Occurs if stock price is at or above strike at expiration

    **Maximum Loss:** Strike Price - Premium (Large but limited)
    - Maximum if stock goes to $0
    - Loss = (Strike Price - Stock Price - Premium) × 100

    **Breakeven Point:** Strike Price - Premium

    ### Example: Short Put (Cash-Secured)

    **Setup:**
    - Stock XYZ trading at $50
    - Sell 1 XYZ $45 Put for $2 premium
    - Expiration: 30 days
    - Cash secured: $4,500 in account

    **Credit Received:** $2 × 100 = $200

    **Scenarios at Expiration:**

    1. **Stock at $50 (above strike):**
       - Option expires worthless
       - Profit: $200 (keep entire premium)

    2. **Stock at $43 (breakeven):**
       - Assigned to buy stock at $45
       - Effective purchase price: $43 ($45 - $2 premium)
       - Profit: $0

    3. **Stock at $35 (below strike):**
       - Assigned to buy stock at $45
       - Loss: [($45 - $35) - $2] × 100 = $800

    ## Protective Put (Portfolio Insurance)

    A protective put is bought to hedge a long stock position.

    ### Example: Protective Put

    **Setup:**
    - Own 100 shares of XYZ at $50 (cost: $5,000)
    - Buy 1 XYZ $48 Put for $2 premium
    - Protection cost: $200

    **Results:**

    1. **Stock falls to $40:**
       - Stock loss: $1,000
       - Put profit: ($48 - $40 - $2) × 100 = $600
       - Net loss: $400 (protected from larger loss)

    2. **Stock rises to $60:**
       - Stock gain: $1,000
       - Put expires worthless: -$200
       - Net gain: $800 (gain minus insurance cost)

    ## In-the-Money (ITM) vs At-the-Money (ATM) vs Out-of-the-Money (OTM)

    ### For Put Options:

    - **ITM:** Stock Price < Strike Price (Has intrinsic value)
    - **ATM:** Stock Price = Strike Price
    - **OTM:** Stock Price > Strike Price (Only time value)

    **Example:** Stock at $50
    - $55 Put: ITM (intrinsic value = $5)
    - $50 Put: ATM
    - $45 Put: OTM (no intrinsic value)

    ## Key Concepts

    ### Intrinsic Value (Put)
    ```
    Intrinsic Value = Max(0, Strike Price - Stock Price)
    ```

    ### Time Value
    ```
    Time Value = Premium - Intrinsic Value
    ```

    **Example:** Stock at $48, $50 Put trading at $4
    - Intrinsic Value: $50 - $48 = $2
    - Time Value: $4 - $2 = $2

    ## Trading Tips

    1. **Long Puts:** More cost-effective than short selling with limited risk
    2. **Protective Puts:** Insurance cost depends on how much protection you want
    3. **Short Puts:** Way to buy stock at a discount if assigned
    4. **Strike Selection:** Higher strikes = more protection but higher cost
  MARKDOWN
}

quiz_puts = {
  title: 'Put Options Practice',
  description: 'Test your understanding of put options',
  time_limit: 15
}

questions_puts = [
  {
    text: 'You buy a put option with a strike price of $50 for a premium of $3. At expiration, the stock is at $42. What is your profit?',
    options: [
      { text: '$300', correct: false },
      { text: '$500', correct: true },
      { text: '$800', correct: false },
      { text: '$200', correct: false },
      { text: '-$300', correct: false }
    ],
    explanation: 'Profit = (Strike - Stock Price - Premium) × 100 = ($50 - $42 - $3) × 100 = $5 × 100 = $500',
    difficulty: -0.4,
    topic: 'put-profit-loss',
    level: 'medium',
    section_anchor: 'long-put'
  },
  {
    text: 'What is the breakeven point for a long put with a strike price of $60 and a premium of $4?',
    options: [
      { text: '$56', correct: true },
      { text: '$60', correct: false },
      { text: '$64', correct: false },
      { text: '$52', correct: false },
      { text: '$68', correct: false }
    ],
    explanation: 'Breakeven for a long put = Strike Price - Premium = $60 - $4 = $56',
    difficulty: -0.5,
    topic: 'breakeven',
    level: 'easy',
    section_anchor: 'long-put'
  },
  {
    text: 'A stock is trading at $45. What is the intrinsic value of a $50 put option?',
    options: [
      { text: '$0', correct: false },
      { text: '$3', correct: false },
      { text: '$5', correct: true },
      { text: '$45', correct: false },
      { text: '$50', correct: false }
    ],
    explanation: 'Intrinsic value of a put = Strike Price - Stock Price = $50 - $45 = $5',
    difficulty: -0.6,
    topic: 'intrinsic-value',
    level: 'easy',
    section_anchor: 'key-concepts'
  },
  {
    text: 'What is the main purpose of buying a protective put?',
    options: [
      { text: 'To speculate on price increases', correct: false },
      { text: 'To hedge against downside risk in a long stock position', correct: true },
      { text: 'To generate income', correct: false },
      { text: 'To profit from volatility', correct: false },
      { text: 'To eliminate all risk', correct: false }
    ],
    explanation: 'A protective put is used as insurance to hedge against downside risk in a long stock position, limiting potential losses.',
    difficulty: -0.7,
    topic: 'protective-put',
    level: 'easy',
    section_anchor: 'protective-put'
  },
  {
    text: 'You sell a put option with a strike price of $45 for a premium of $2. At expiration, the stock is at $50. What is your profit?',
    options: [
      { text: '$500', correct: false },
      { text: '$300', correct: false },
      { text: '$200', correct: true },
      { text: '$0', correct: false },
      { text: '-$200', correct: false }
    ],
    explanation: 'When selling a put and the stock is above the strike at expiration, the option expires worthless and you keep the entire premium: $2 × 100 = $200',
    difficulty: -0.3,
    topic: 'short-put',
    level: 'medium',
    section_anchor: 'short-put'
  }
]

create_lesson_quiz_pair(module_basics, lesson_puts, quiz_puts, questions_puts, 3)

# -----------------------------------------------------------------------------
# Lesson 1.4: Options Pricing Basics
# -----------------------------------------------------------------------------
lesson_pricing = {
  slug: 'options-pricing-basics',
  title: 'Options Pricing Basics',
  reading_time: 15,
  key_concepts: ['intrinsic-value', 'time-value', 'moneyness', 'time-decay'],
  content: <<~MARKDOWN
    # Options Pricing Basics

    ## Components of Option Premium

    **Option Premium = Intrinsic Value + Time Value**

    ### 1. Intrinsic Value

    The **intrinsic value** is the amount by which an option is in-the-money.

    **For Call Options:**
    ```
    Intrinsic Value = Max(0, Stock Price - Strike Price)
    ```

    **For Put Options:**
    ```
    Intrinsic Value = Max(0, Strike Price - Stock Price)
    ```

    **Example:**
    - Stock at $55
    - $50 Call: Intrinsic Value = $55 - $50 = $5
    - $60 Call: Intrinsic Value = $0 (out of the money)
    - $50 Put: Intrinsic Value = $0 (out of the money)
    - $60 Put: Intrinsic Value = $60 - $55 = $5

    ### 2. Time Value (Extrinsic Value)

    The **time value** represents the additional premium beyond intrinsic value, reflecting the possibility of the option gaining more value before expiration.

    ```
    Time Value = Option Premium - Intrinsic Value
    ```

    **Example:**
    - Stock at $55
    - $50 Call trading at $7
    - Intrinsic Value: $5
    - Time Value: $7 - $5 = $2

    ## Factors Affecting Option Prices

    ### 1. Stock Price
    - **Calls:** Value increases as stock price rises
    - **Puts:** Value increases as stock price falls

    ### 2. Strike Price
    - **Calls:** Lower strikes more expensive (more ITM)
    - **Puts:** Higher strikes more expensive (more ITM)

    ### 3. Time to Expiration
    - More time = More value (more opportunity for favorable price movement)
    - **Time decay accelerates** as expiration approaches

    ### 4. Volatility
    - Higher volatility = Higher option premiums
    - More uncertainty = Greater potential for large moves

    ### 5. Interest Rates
    - Generally minor impact
    - Higher rates slightly increase call premiums, decrease put premiums

    ### 6. Dividends
    - Expected dividends decrease call premiums
    - Expected dividends increase put premiums

    ## Moneyness

    ### In-the-Money (ITM)
    - Has intrinsic value
    - **Calls:** Stock price > Strike price
    - **Puts:** Stock price < Strike price

    ### At-the-Money (ATM)
    - Stock price ≈ Strike price
    - Highest time value (all premium is time value)

    ### Out-of-the-Money (OTM)
    - No intrinsic value (all premium is time value)
    - **Calls:** Stock price < Strike price
    - **Puts:** Stock price > Strike price

    ## Time Decay (Theta)

    Time decay is the erosion of option value as time passes.

    ### Key Characteristics:
    - **Non-linear:** Accelerates as expiration approaches
    - **ATM options** decay fastest in absolute terms
    - **OTM options** lose value entirely if they stay OTM
    - **Works against option buyers, for option sellers**

    ### Example of Time Decay:

    **60 Days to Expiration:**
    - Stock at $50, $50 Call premium: $4.00
    - All time value (ATM)

    **30 Days to Expiration:**
    - Stock still at $50, $50 Call premium: $2.50
    - Lost $1.50 in value due to time decay

    **5 Days to Expiration:**
    - Stock still at $50, $50 Call premium: $0.50
    - Lost another $2.00 - decay accelerated

    **Expiration:**
    - Stock at $50, $50 Call: $0.00
    - Expires worthless (ATM at expiration = $0)

    ## Premium Example Analysis

    **Stock XYZ at $100**

    | Strike | Call Premium | Intrinsic | Time Value | Moneyness |
    |--------|-------------|-----------|------------|-----------|
    | $90    | $12.50      | $10.00    | $2.50      | ITM       |
    | $95    | $8.00       | $5.00     | $3.00      | ITM       |
    | $100   | $4.00       | $0.00     | $4.00      | ATM       |
    | $105   | $1.50       | $0.00     | $1.50      | OTM       |
    | $110   | $0.50       | $0.00     | $0.50      | OTM       |

    **Observations:**
    - ATM options have the highest time value
    - As options go deeper ITM, premium increases due to intrinsic value
    - As options go farther OTM, premium decreases (lower probability)

    ## Trading Implications

    ### For Option Buyers:
    1. **Time decay is your enemy** - value erodes every day
    2. **Give yourself time** - don't buy options too close to expiration
    3. **ATM/slight OTM** often offer best leverage
    4. **Need significant moves** to overcome time decay

    ### For Option Sellers:
    1. **Time decay is your friend** - collect premium as time passes
    2. **Sell with 30-45 days** to expiration for optimal decay
    3. **Manage risk** - time decay doesn't help if move goes against you
    4. **Higher probability strategies** - sell OTM options

    ## Key Takeaways

    1. All options lose value over time (time decay)
    2. Premium = Intrinsic Value + Time Value
    3. ATM options have the most time value
    4. ITM options have both intrinsic and time value
    5. OTM options are pure time value (higher risk, lower cost)
    6. Time decay accelerates as expiration approaches
  MARKDOWN
}

quiz_pricing = {
  title: 'Options Pricing Practice',
  description: 'Test your understanding of options pricing',
  time_limit: 15
}

questions_pricing = [
  {
    text: 'A stock is at $55. A $50 call is trading at $7. What is the time value of this call?',
    options: [
      { text: '$2', correct: true },
      { text: '$5', correct: false },
      { text: '$7', correct: false },
      { text: '$12', correct: false },
      { text: '$0', correct: false }
    ],
    explanation: 'Intrinsic value = $55 - $50 = $5. Time value = Premium - Intrinsic = $7 - $5 = $2',
    difficulty: -0.3,
    topic: 'time-value',
    level: 'medium',
    section_anchor: 'time-value'
  },
  {
    text: 'What happens to the time value of an option as expiration approaches?',
    options: [
      { text: 'It increases', correct: false },
      { text: 'It decreases', correct: true },
      { text: 'It stays the same', correct: false },
      { text: 'It doubles', correct: false },
      { text: 'It becomes negative', correct: false }
    ],
    explanation: 'Time value decreases as expiration approaches, a phenomenon called time decay or theta. The decay accelerates as expiration gets closer.',
    difficulty: -0.8,
    topic: 'time-decay',
    level: 'easy',
    section_anchor: 'time-decay'
  },
  {
    text: 'Which type of option typically has the highest time value relative to its premium?',
    options: [
      { text: 'Deep in-the-money', correct: false },
      { text: 'At-the-money', correct: true },
      { text: 'Far out-of-the-money', correct: false },
      { text: 'Expired options', correct: false },
      { text: 'All have equal time value', correct: false }
    ],
    explanation: 'At-the-money (ATM) options have the highest time value relative to their premium because they have maximum uncertainty about ending up ITM or OTM.',
    difficulty: 0.0,
    topic: 'moneyness',
    level: 'medium',
    section_anchor: 'moneyness'
  },
  {
    text: 'If a $60 put option is trading at $8 when the stock is at $55, what is its intrinsic value?',
    options: [
      { text: '$3', correct: false },
      { text: '$5', correct: true },
      { text: '$8', correct: false },
      { text: '$13', correct: false },
      { text: '$0', correct: false }
    ],
    explanation: 'For a put option, intrinsic value = Strike - Stock Price = $60 - $55 = $5',
    difficulty: -0.4,
    topic: 'intrinsic-value',
    level: 'medium',
    section_anchor: 'intrinsic-value'
  },
  {
    text: 'Time decay works in favor of which options market participants?',
    options: [
      { text: 'Option buyers', correct: false },
      { text: 'Option sellers', correct: true },
      { text: 'Both equally', correct: false },
      { text: 'Neither', correct: false },
      { text: 'Only market makers', correct: false }
    ],
    explanation: 'Time decay (theta) works in favor of option sellers. As time passes, options lose value, benefiting those who sold them and collected the premium.',
    difficulty: -0.6,
    topic: 'time-decay',
    level: 'easy',
    section_anchor: 'trading-implications'
  }
]

create_lesson_quiz_pair(module_basics, lesson_pricing, quiz_pricing, questions_pricing, 4)

puts ""
puts "✅ Module 1: Options Basics Complete (4 lessons, 20 questions)"
puts ""

# =============================================================================
# MODULE 2: OPTIONS STRATEGIES (20 questions across 4 lessons)
# =============================================================================
module_strategies = course.course_modules.find_or_create_by!(slug: 'options-strategies') do |m|
  m.title = 'Options Strategies'
  m.description = 'Covered calls, cash-secured puts, spreads, and multi-leg strategies'
  m.sequence_order = 2
  m.estimated_minutes = 600
  m.published = true
end

puts "✓ Module 2: Options Strategies"

# -----------------------------------------------------------------------------
# Lesson 2.1: Covered Calls & Cash-Secured Puts
# -----------------------------------------------------------------------------
lesson_covered = {
  slug: 'covered-calls-cash-secured-puts',
  title: 'Covered Calls & Cash-Secured Puts',
  reading_time: 15,
  key_concepts: ['covered-call', 'cash-secured-put', 'income-generation', 'assignment'],
  content: <<~MARKDOWN
    # Covered Calls & Cash-Secured Puts

    ## Covered Call Strategy

    A **covered call** involves owning 100 shares of stock and selling 1 call option against it.

    ### Purpose:
    - Generate income from stock holdings
    - Reduce cost basis of stock
    - Accept capping upside potential for premium income

    ### Setup Example:

    **Position:**
    - Own 100 shares of XYZ at $50 (cost: $5,000)
    - Sell 1 XYZ $55 Call for $2 premium
    - Expiration: 30 days

    **Credit Received:** $2 × 100 = $200

    ### Profit/Loss Scenarios:

    **1. Stock stays below $55 (not assigned):**
    - Keep stock + $200 premium
    - Can sell another call next month
    - Effective cost basis: $50 - $2 = $48

    **2. Stock at $55 (at strike):**
    - Keep stock + $200 premium
    - Maximum profit achieved: ($55 - $50) + $2 = $7 per share = $700

    **3. Stock rises to $60 (assigned):**
    - Forced to sell at $55
    - Total profit: ($55 - $50) + $2 = $7 per share = $700
    - Miss out on additional $5 gain

    **4. Stock falls to $40:**
    - Keep stock + $200 premium (partial cushion)
    - Loss on stock: $1,000
    - Net loss: $1,000 - $200 = $800
    - Premium reduces but doesn't eliminate downside

    ### Key Points:

    **Maximum Profit:** (Strike - Stock Purchase Price + Premium) × 100
    **Maximum Loss:** (Stock Purchase Price - Premium) × 100 (down to $0)
    **Breakeven:** Stock Purchase Price - Premium

    ## Cash-Secured Put Strategy

    A **cash-secured put** involves selling a put option while holding enough cash to buy the stock if assigned.

    ### Purpose:
    - Generate income while waiting to buy stock
    - Buy stock at a discount if assigned
    - Earn premium if stock stays above strike

    ### Setup Example:

    **Position:**
    - Stock XYZ trading at $50
    - Sell 1 XYZ $45 Put for $2 premium
    - Cash secured: $4,500 in account (strike × 100)
    - Expiration: 30 days

    **Credit Received:** $2 × 100 = $200

    ### Profit/Loss Scenarios:

    **1. Stock stays above $45 (not assigned):**
    - Keep $200 premium
    - Can sell another put next month
    - Profit: $200

    **2. Stock at $45 (at strike):**
    - May or may not be assigned
    - Keep $200 premium regardless
    - Profit: $200

    **3. Stock falls to $40 (assigned):**
    - Forced to buy at $45
    - Effective purchase price: $45 - $2 = $43
    - Current value: $40 per share
    - Paper loss: $3 per share = $300
    - But wanted to buy anyway at $43

    **4. Stock rises to $60:**
    - Keep $200 premium
    - Miss opportunity to buy stock cheaper
    - Profit: $200

    ### Key Points:

    **Maximum Profit:** Premium × 100
    **Maximum Loss:** (Strike - Premium) × 100 (if stock goes to $0)
    **Breakeven:** Strike - Premium

    ## Comparison of Strategies

    | Aspect | Covered Call | Cash-Secured Put |
    |--------|-------------|------------------|
    | Position | Long stock + Short call | Short put + Cash |
    | Bullish/Bearish | Neutral to slightly bullish | Neutral to slightly bullish |
    | Max Profit | Limited (strike - cost + premium) | Limited (premium) |
    | Max Loss | Large (down to $0 minus premium) | Large (strike - premium to $0) |
    | Assignment | Must sell stock | Must buy stock |
    | Income | Yes | Yes |

    ## When to Use Each Strategy

    ### Covered Calls:
    - Own stock and want to generate income
    - Neutral to slightly bullish outlook
    - Willing to sell at strike price
    - Stock trading range-bound

    ### Cash-Secured Puts:
    - Want to buy stock at lower price
    - Bullish long-term but patient
    - Generate income while waiting
    - Comfortable buying at strike price

    ## Management Tips

    ### Covered Calls:
    1. Sell 30-45 days to expiration
    2. Choose strikes where you're happy to sell
    3. If stock drops significantly, consider rolling down
    4. If approaching assignment, decide: take profit or roll

    ### Cash-Secured Puts:
    1. Only sell puts on stocks you want to own
    2. Use strikes at your desired purchase price
    3. Have cash ready for assignment
    4. If assigned, can sell covered call immediately (the wheel strategy)

    ## The Wheel Strategy

    Combining covered calls and cash-secured puts:

    **Step 1:** Sell cash-secured put → Collect premium
    **Step 2:** If assigned → Now own stock
    **Step 3:** Sell covered call → Collect premium
    **Step 4:** If assigned → Stock sold, back to Step 1
    **Step 5:** Repeat indefinitely, collecting premiums

    This creates a continuous income-generating cycle.
  MARKDOWN
}

quiz_covered = {
  title: 'Covered Calls & Cash-Secured Puts Practice',
  description: 'Test your understanding of covered calls and cash-secured puts',
  time_limit: 15
}

questions_covered = [
  {
    text: 'You own 100 shares of stock at $50 and sell a $55 call for $2. What is your maximum profit?',
    options: [
      { text: '$200', correct: false },
      { text: '$500', correct: false },
      { text: '$700', correct: true },
      { text: '$5,000', correct: false },
      { text: 'Unlimited', correct: false }
    ],
    explanation: 'Max profit = (Strike - Purchase Price + Premium) × 100 = ($55 - $50 + $2) × 100 = $700',
    difficulty: -0.3,
    topic: 'covered-call',
    level: 'medium',
    section_anchor: 'covered-call-strategy'
  },
  {
    text: 'What is the main risk of a covered call strategy?',
    options: [
      { text: 'Unlimited loss potential', correct: false },
      { text: 'Missing out on upside gains above the strike price', correct: true },
      { text: 'Having to buy more shares', correct: false },
      { text: 'Premium received is taxable', correct: false },
      { text: 'No downside protection', correct: false }
    ],
    explanation: 'The main risk is capping your upside. If the stock rises above the strike, you miss additional gains because you must sell at the strike price.',
    difficulty: -0.5,
    topic: 'covered-call',
    level: 'easy',
    section_anchor: 'covered-call-strategy'
  },
  {
    text: 'You sell a cash-secured put with a $45 strike for $2 premium. At what stock price do you break even if assigned?',
    options: [
      { text: '$40', correct: false },
      { text: '$43', correct: true },
      { text: '$45', correct: false },
      { text: '$47', correct: false },
      { text: '$50', correct: false }
    ],
    explanation: 'Breakeven = Strike - Premium = $45 - $2 = $43. If assigned at $45 and paid $2 premium, effective cost is $43.',
    difficulty: -0.4,
    topic: 'cash-secured-put',
    level: 'medium',
    section_anchor: 'cash-secured-put-strategy'
  },
  {
    text: 'What is the maximum profit from selling a cash-secured put for a $3 premium?',
    options: [
      { text: '$3', correct: false },
      { text: '$30', correct: false },
      { text: '$300', correct: true },
      { text: 'The strike price', correct: false },
      { text: 'Unlimited', correct: false }
    ],
    explanation: 'Maximum profit when selling a put is the premium received: $3 × 100 = $300',
    difficulty: -0.6,
    topic: 'cash-secured-put',
    level: 'easy',
    section_anchor: 'cash-secured-put-strategy'
  },
  {
    text: 'What strategy involves selling puts, getting assigned, then selling calls on the assigned stock?',
    options: [
      { text: 'Straddle', correct: false },
      { text: 'Iron Condor', correct: false },
      { text: 'The Wheel', correct: true },
      { text: 'Butterfly Spread', correct: false },
      { text: 'Collar', correct: false }
    ],
    explanation: 'The Wheel strategy cycles between selling cash-secured puts (until assignment) and then selling covered calls on the assigned stock.',
    difficulty: 0.0,
    topic: 'wheel-strategy',
    level: 'medium',
    section_anchor: 'the-wheel-strategy'
  }
]

create_lesson_quiz_pair(module_strategies, lesson_covered, quiz_covered, questions_covered, 1)

# -----------------------------------------------------------------------------
# Lesson 2.2: Vertical Spreads
# -----------------------------------------------------------------------------
lesson_verticals = {
  slug: 'vertical-spreads',
  title: 'Vertical Spreads',
  reading_time: 15,
  key_concepts: ['vertical-spread', 'bull-call-spread', 'bear-put-spread', 'credit-spread'],
  content: <<~MARKDOWN
    # Vertical Spreads

    ## What is a Vertical Spread?

    A **vertical spread** involves simultaneously buying and selling options of the same type (both calls or both puts) with the same expiration but different strike prices.

    ### Types:
    1. **Bull Call Spread** (Debit Spread)
    2. **Bear Call Spread** (Credit Spread)
    3. **Bull Put Spread** (Credit Spread)
    4. **Bear Put Spread** (Debit Spread)

    ## Bull Call Spread

    Buy a lower strike call and sell a higher strike call.

    ### When to Use:
    - Moderately bullish on stock
    - Want to reduce cost of long call
    - Accept limited profit for reduced risk

    ### Example:

    **Setup:**
    - Stock XYZ at $50
    - Buy $50 Call for $5 (debit)
    - Sell $55 Call for $2 (credit)
    - Net Cost: $5 - $2 = $3 per share = $300

    **Profit/Loss at Expiration:**

    **Stock below $50:**
    - Both options expire worthless
    - Loss: $300 (max loss)

    **Stock at $53 (breakeven):**
    - Long call worth $3, short call worthless
    - Profit: $300 - $300 = $0

    **Stock at $55:**
    - Long call: $5, Short call: $0
    - Profit: $500 - $300 = $200 (max profit)

    **Stock above $55:**
    - Long call: $10, Short call: -$5
    - Net: $5 spread - $3 cost = $200 (max profit)

    **Key Metrics:**
    - **Max Loss:** Net Debit = $300
    - **Max Profit:** (Spread Width - Net Debit) × 100 = ($5 - $3) × 100 = $200
    - **Breakeven:** Lower Strike + Net Debit = $50 + $3 = $53

    ## Bear Put Spread

    Buy a higher strike put and sell a lower strike put.

    ### When to Use:
    - Moderately bearish on stock
    - Want to reduce cost of long put
    - Accept limited profit for reduced risk

    ### Example:

    **Setup:**
    - Stock XYZ at $50
    - Buy $50 Put for $4 (debit)
    - Sell $45 Put for $1.50 (credit)
    - Net Cost: $4 - $1.50 = $2.50 per share = $250

    **Profit/Loss at Expiration:**

    **Stock above $50:**
    - Both options expire worthless
    - Loss: $250 (max loss)

    **Stock at $47.50 (breakeven):**
    - Long put worth $2.50, short put worthless
    - Profit: $250 - $250 = $0

    **Stock at $45:**
    - Long put: $5, Short put: $0
    - Profit: $500 - $250 = $250 (max profit)

    **Stock below $45:**
    - Long put: $10, Short put: -$5
    - Net: $5 spread - $2.50 cost = $250 (max profit)

    **Key Metrics:**
    - **Max Loss:** Net Debit = $250
    - **Max Profit:** (Spread Width - Net Debit) × 100 = ($5 - $2.50) × 100 = $250
    - **Breakeven:** Higher Strike - Net Debit = $50 - $2.50 = $47.50

    ## Bull Put Spread (Credit Spread)

    Sell a higher strike put and buy a lower strike put.

    ### When to Use:
    - Moderately bullish on stock
    - Want to collect premium with defined risk
    - Expect stock to stay above higher strike

    ### Example:

    **Setup:**
    - Stock XYZ at $52
    - Sell $50 Put for $3 (credit)
    - Buy $45 Put for $1 (debit)
    - Net Credit: $3 - $1 = $2 per share = $200

    **Profit/Loss at Expiration:**

    **Stock above $50:**
    - Both options expire worthless
    - Profit: $200 (max profit - keep credit)

    **Stock at $48 (breakeven):**
    - Short put: -$2, Long put: $0
    - Loss: $200 - $200 = $0

    **Stock at $45:**
    - Short put: -$5, Long put: $0
    - Loss: $500 - $200 = $300 (max loss)

    **Stock below $45:**
    - Short put: -$10, Long put: $5
    - Net: -$5 spread + $2 credit = -$300 (max loss)

    **Key Metrics:**
    - **Max Profit:** Net Credit = $200
    - **Max Loss:** (Spread Width - Net Credit) × 100 = ($5 - $2) × 100 = $300
    - **Breakeven:** Higher Strike - Net Credit = $50 - $2 = $48

    ## Bear Call Spread (Credit Spread)

    Sell a lower strike call and buy a higher strike call.

    ### When to Use:
    - Moderately bearish on stock
    - Want to collect premium with defined risk
    - Expect stock to stay below lower strike

    ### Example:

    **Setup:**
    - Stock XYZ at $48
    - Sell $50 Call for $2.50 (credit)
    - Buy $55 Call for $1 (debit)
    - Net Credit: $2.50 - $1 = $1.50 per share = $150

    **Profit/Loss at Expiration:**

    **Stock below $50:**
    - Both options expire worthless
    - Profit: $150 (max profit)

    **Stock at $51.50 (breakeven):**
    - Short call: -$1.50, Long call: $0
    - Loss: $150 - $150 = $0

    **Stock at $55:**
    - Short call: -$5, Long call: $0
    - Loss: $500 - $150 = $350 (max loss)

    **Stock above $55:**
    - Short call: -$10, Long call: $5
    - Net: -$5 spread + $1.50 credit = -$350 (max loss)

    **Key Metrics:**
    - **Max Profit:** Net Credit = $150
    - **Max Loss:** (Spread Width - Net Credit) × 100 = ($5 - $1.50) × 100 = $350
    - **Breakeven:** Lower Strike + Net Credit = $50 + $1.50 = $51.50

    ## Comparing Spread Types

    | Spread Type | Direction | Debit/Credit | Max Risk | Max Reward |
    |------------|-----------|--------------|----------|------------|
    | Bull Call | Bullish | Debit | Debit paid | Spread - Debit |
    | Bear Put | Bearish | Debit | Debit paid | Spread - Debit |
    | Bull Put | Bullish | Credit | Spread - Credit | Credit received |
    | Bear Call | Bearish | Credit | Spread - Credit | Credit received |

    ## Advantages of Spreads

    1. **Defined Risk:** Know maximum loss upfront
    2. **Lower Cost:** Selling option reduces cost
    3. **Higher Probability:** Don't need large moves
    4. **Less Time Decay:** Offsetting positions reduce theta impact

    ## Trading Tips

    1. **Spread Width:** Wider = more profit potential but more risk
    2. **Strike Selection:**
       - Debit spreads: Buy ATM, sell OTM
       - Credit spreads: Sell OTM, buy further OTM
    3. **Risk/Reward:** Look for at least 1:2 risk/reward ratio on credit spreads
    4. **Liquidity:** Trade spreads on liquid underlyings only
    5. **Close Early:** Take profits at 50% of max profit on credit spreads
  MARKDOWN
}

quiz_verticals = {
  title: 'Vertical Spreads Practice',
  description: 'Test your understanding of vertical spreads',
  time_limit: 15
}

questions_verticals = [
  {
    text: 'You enter a bull call spread: Buy $50 call for $5, sell $55 call for $2. What is your maximum loss?',
    options: [
      { text: '$200', correct: false },
      { text: '$300', correct: true },
      { text: '$500', correct: false },
      { text: '$700', correct: false },
      { text: 'Unlimited', correct: false }
    ],
    explanation: 'Max loss on a debit spread is the net debit paid: ($5 - $2) × 100 = $300',
    difficulty: -0.4,
    topic: 'bull-call-spread',
    level: 'medium',
    section_anchor: 'bull-call-spread'
  },
  {
    text: 'What is the maximum profit for a bull call spread with strikes at $50 and $55, net debit of $3?',
    options: [
      { text: '$200', correct: true },
      { text: '$300', correct: false },
      { text: '$500', correct: false },
      { text: '$800', correct: false },
      { text: 'Unlimited', correct: false }
    ],
    explanation: 'Max profit = (Spread Width - Net Debit) × 100 = ($5 - $3) × 100 = $200',
    difficulty: -0.3,
    topic: 'bull-call-spread',
    level: 'medium',
    section_anchor: 'bull-call-spread'
  },
  {
    text: 'Which spread would you use if you expect a stock to decline moderately and want to collect premium?',
    options: [
      { text: 'Bull call spread', correct: false },
      { text: 'Bull put spread', correct: false },
      { text: 'Bear call spread', correct: true },
      { text: 'Bear put spread', correct: false },
      { text: 'Long straddle', correct: false }
    ],
    explanation: 'A bear call spread is a credit spread used when bearish. You sell a lower strike call and buy a higher strike call, collecting net premium.',
    difficulty: -0.2,
    topic: 'bear-call-spread',
    level: 'medium',
    section_anchor: 'bear-call-spread'
  },
  {
    text: 'You sell a $50 put for $3 and buy a $45 put for $1. What is your maximum profit?',
    options: [
      { text: '$100', correct: false },
      { text: '$200', correct: true },
      { text: '$300', correct: false },
      { text: '$400', correct: false },
      { text: '$500', correct: false }
    ],
    explanation: 'This is a bull put spread (credit spread). Max profit = Net Credit = ($3 - $1) × 100 = $200',
    difficulty: -0.5,
    topic: 'bull-put-spread',
    level: 'easy',
    section_anchor: 'bull-put-spread'
  },
  {
    text: 'What is the main advantage of vertical spreads compared to single options?',
    options: [
      { text: 'Unlimited profit potential', correct: false },
      { text: 'No time decay', correct: false },
      { text: 'Defined risk and lower cost', correct: true },
      { text: 'Guaranteed profits', correct: false },
      { text: 'Higher premiums collected', correct: false }
    ],
    explanation: 'Vertical spreads offer defined maximum risk and lower cost (or credit received) compared to single long options, though profit is also limited.',
    difficulty: -0.6,
    topic: 'spreads-basics',
    level: 'easy',
    section_anchor: 'advantages-of-spreads'
  }
]

create_lesson_quiz_pair(module_strategies, lesson_verticals, quiz_verticals, questions_verticals, 2)

# -----------------------------------------------------------------------------
# Lesson 2.3: Iron Condors & Butterflies
# -----------------------------------------------------------------------------
lesson_condors = {
  slug: 'iron-condors-butterflies',
  title: 'Iron Condors & Butterflies',
  reading_time: 15,
  key_concepts: ['iron-condor', 'butterfly-spread', 'neutral-strategies', 'range-bound'],
  content: <<~MARKDOWN
    # Iron Condors & Butterflies

    ## Iron Condor

    An **iron condor** combines a bear call spread and a bull put spread on the same underlying with the same expiration.

    ### Structure:
    1. Sell OTM call (lower strike)
    2. Buy OTM call (higher strike) - Bear call spread
    3. Sell OTM put (higher strike)
    4. Buy OTM put (lower strike) - Bull put spread

    ### When to Use:
    - Neutral outlook on stock
    - Expect low volatility
    - Want to profit from range-bound trading
    - Generate income with defined risk

    ### Example:

    **Setup (Stock at $50):**
    - Buy $40 Put for $0.50 (protection)
    - Sell $45 Put for $1.50 (credit)
    - Sell $55 Call for $1.50 (credit)
    - Buy $60 Call for $0.50 (protection)
    - Net Credit: ($1.50 + $1.50 - $0.50 - $0.50) = $2 per share = $200

    **Profit/Loss at Expiration:**

    **Stock between $45 and $55 (profit zone):**
    - All options expire worthless
    - Profit: $200 (max profit - keep entire credit)

    **Stock at $43 (put side breakeven):**
    - Put spread loss: $200
    - Net: $200 credit - $200 loss = $0

    **Stock at $57 (call side breakeven):**
    - Call spread loss: $200
    - Net: $200 credit - $200 loss = $0

    **Stock at $40 or below:**
    - Put spread max loss: ($5 - $2) × 100 = $300
    - This is also the max loss for the entire position

    **Stock at $60 or above:**
    - Call spread max loss: ($5 - $2) × 100 = $300
    - This is also the max loss for the entire position

    **Key Metrics:**
    - **Max Profit:** Net Credit = $200
    - **Max Loss:** (Spread Width - Net Credit) × 100 = ($5 - $2) × 100 = $300
    - **Breakeven Points:**
      - Lower: $45 - $2 = $43
      - Upper: $55 + $2 = $57
    - **Profit Zone:** Between breakeven points ($43 to $57)

    ## Butterfly Spread

    A **butterfly spread** involves buying two options at outer strikes and selling two options at the middle strike.

    ### Types:
    - **Long Call Butterfly:** Using calls
    - **Long Put Butterfly:** Using puts
    - **Iron Butterfly:** Combination of call and put spreads

    ## Long Call Butterfly

    ### Structure:
    - Buy 1 lower strike call
    - Sell 2 middle strike calls (ATM typically)
    - Buy 1 higher strike call

    ### When to Use:
    - Expect minimal price movement
    - Target specific price level
    - Low cost, high reward potential if correct

    ### Example:

    **Setup (Stock at $50):**
    - Buy 1 $45 Call for $7 (debit)
    - Sell 2 $50 Calls for $4 each (credit $8)
    - Buy 1 $55 Call for $2 (debit)
    - Net Cost: $7 + $2 - $8 = $1 per share = $100

    **Profit/Loss at Expiration:**

    **Stock at $45 or below:**
    - All options expire worthless
    - Loss: $100 (max loss)

    **Stock at $50 (target):**
    - $45 Call: $5 value
    - $50 Calls: $0 value
    - $55 Call: $0 value
    - Profit: $500 - $100 = $400 (max profit)

    **Stock at $55 or above:**
    - $45 Call: $10 value
    - $50 Calls: -$10 value (2 × $5)
    - $55 Call: $0+ value
    - Net: $10 - $10 + $0 - $1 = -$100 (max loss)

    **Key Metrics:**
    - **Max Profit:** (Middle Strike - Lower Strike - Net Debit) × 100 = ($50 - $45 - $1) × 100 = $400
    - **Max Loss:** Net Debit = $100
    - **Breakeven Points:**
      - Lower: $45 + $1 = $46
      - Upper: $55 - $1 = $54

    ## Iron Butterfly

    Combines a call credit spread and a put credit spread, both centered at the same strike.

    ### Structure:
    - Buy lower strike put (protection)
    - Sell ATM put (credit)
    - Sell ATM call (credit)
    - Buy higher strike call (protection)

    ### Example:

    **Setup (Stock at $50):**
    - Buy $45 Put for $1
    - Sell $50 Put for $3.50
    - Sell $50 Call for $3.50
    - Buy $55 Call for $1
    - Net Credit: $3.50 + $3.50 - $1 - $1 = $5 per share = $500

    **Profit/Loss at Expiration:**

    **Stock at $50 (target):**
    - All options expire worthless
    - Profit: $500 (max profit)

    **Stock at $45 or $55:**
    - One spread worth $5
    - Loss: $500 - $500 = $0 (breakeven)

    **Stock below $45 or above $55:**
    - Max Loss: ($5 - $5) × 100 = $0? No!
    - Max Loss: (Spread Width - Net Credit) × 100 = ($5 - $5) × 100 = $0
    - Actually: Max Loss = ($5 spread - $5 credit) × 100 = $0

    Wait, let me recalculate:
    - Spread Width: $5
    - Net Credit: $5
    - Max Loss = (Spread - Credit) × 100 = ($5 - $5) × 100 = $0

    This seems wrong. Let me reconsider:

    Actually, with $5 spread and $5 credit, max loss would indeed be $0, meaning this is a riskless trade which doesn't happen. The credit should be less than the spread width.

    Let me fix the example with more realistic pricing:

    **Setup (Stock at $50):**
    - Buy $45 Put for $1
    - Sell $50 Put for $3
    - Sell $50 Call for $3
    - Buy $55 Call for $1
    - Net Credit: $3 + $3 - $1 - $1 = $4 per share = $400

    **Stock at $50:** Max profit = $400
    **Stock at $45 or below / $55 or above:** Max loss = ($5 - $4) × 100 = $100

    ## Comparing Neutral Strategies

    | Strategy | Max Profit | Max Loss | Profit Zone | Complexity |
    |----------|-----------|----------|-------------|------------|
    | Iron Condor | Moderate | Moderate | Wide range | 4 legs |
    | Call Butterfly | High | Low | Narrow | 3 strikes |
    | Iron Butterfly | High | Moderate | Narrow | 4 legs |

    ## When to Use Each

    ### Iron Condor:
    - Moderate volatility expected
    - Wider profit range
    - More forgiving if wrong
    - Good for earnings trades (sell after earnings)

    ### Butterfly:
    - Very low volatility expected
    - Strong conviction on price level
    - Maximum profit if prediction correct
    - Lower cost than iron butterfly

    ### Iron Butterfly:
    - Very low volatility expected
    - Larger credit than butterfly
    - More risk than butterfly
    - Stock expected at specific price

    ## Management Tips

    1. **Iron Condor:**
       - Close at 50% of max profit
       - Roll tested side if threatened
       - Enter 30-45 days to expiration
       - Target 1:2 or 1:3 risk/reward

    2. **Butterfly:**
       - Best 0-7 days to expiration
       - Close if stock moves away from body
       - Works well in low IV environments
       - Very low cost, defined risk

    3. **Iron Butterfly:**
       - Close at 50-75% profit
       - More aggressive than iron condor
       - Higher return, narrower profit zone
       - Monitor closely near expiration

    ## Risk Considerations

    - All strategies have defined risk
    - Early assignment possible on short options ITM
    - Bid-ask spreads can be wide (use limit orders)
    - Commission costs matter with multi-leg trades
    - Greeks are more complex with multiple legs
  MARKDOWN
}

quiz_condors = {
  title: 'Iron Condors & Butterflies Practice',
  description: 'Test your understanding of iron condors and butterflies',
  time_limit: 15
}

questions_condors = [
  {
    text: 'An iron condor is profitable when the stock price at expiration is:',
    options: [
      { text: 'At the highest strike', correct: false },
      { text: 'At the lowest strike', correct: false },
      { text: 'Between the short strikes', correct: true },
      { text: 'Outside both spreads', correct: false },
      { text: 'Exactly at the long strikes', correct: false }
    ],
    explanation: 'An iron condor is most profitable when the stock stays between the two short strikes (the put and call you sold), allowing all options to expire worthless.',
    difficulty: -0.3,
    topic: 'iron-condor',
    level: 'medium',
    section_anchor: 'iron-condor'
  },
  {
    text: 'You set up an iron condor and collect $300 credit with $5 wide spreads. What is your maximum loss?',
    options: [
      { text: '$200', correct: true },
      { text: '$300', correct: false },
      { text: '$500', correct: false },
      { text: '$800', correct: false },
      { text: 'Unlimited', correct: false }
    ],
    explanation: 'Max loss = (Spread Width - Net Credit) × 100 = ($5 - $3) × 100 = $200',
    difficulty: -0.4,
    topic: 'iron-condor',
    level: 'medium',
    section_anchor: 'iron-condor'
  },
  {
    text: 'What is the ideal market condition for an iron condor?',
    options: [
      { text: 'High volatility with large price swings', correct: false },
      { text: 'Low volatility with range-bound trading', correct: true },
      { text: 'Strong uptrend', correct: false },
      { text: 'Strong downtrend', correct: false },
      { text: 'Market crash', correct: false }
    ],
    explanation: 'Iron condors profit from low volatility and range-bound trading where the stock stays between the short strikes.',
    difficulty: -0.6,
    topic: 'iron-condor',
    level: 'easy',
    section_anchor: 'iron-condor'
  },
  {
    text: 'In a long call butterfly with strikes at $45/$50/$55, where is maximum profit achieved?',
    options: [
      { text: '$45', correct: false },
      { text: '$50', correct: true },
      { text: '$55', correct: false },
      { text: 'Below $45', correct: false },
      { text: 'Above $55', correct: false }
    ],
    explanation: 'Maximum profit for a butterfly spread is achieved when the stock is exactly at the middle strike ($50) at expiration.',
    difficulty: -0.5,
    topic: 'butterfly',
    level: 'easy',
    section_anchor: 'long-call-butterfly'
  },
  {
    text: 'How many total option contracts are involved in a standard iron condor?',
    options: [
      { text: '2', correct: false },
      { text: '3', correct: false },
      { text: '4', correct: true },
      { text: '5', correct: false },
      { text: '6', correct: false }
    ],
    explanation: 'An iron condor has 4 legs: buy put, sell put, sell call, buy call. Each is one contract for 100 shares.',
    difficulty: -0.7,
    topic: 'iron-condor',
    level: 'easy',
    section_anchor: 'iron-condor'
  }
]

create_lesson_quiz_pair(module_strategies, lesson_condors, quiz_condors, questions_condors, 3)

# -----------------------------------------------------------------------------
# Lesson 2.4: Straddles, Strangles & Calendar Spreads
# -----------------------------------------------------------------------------
lesson_advanced_strategies = {
  slug: 'straddles-strangles-calendars',
  title: 'Straddles, Strangles & Calendar Spreads',
  reading_time: 15,
  key_concepts: ['straddle', 'strangle', 'calendar-spread', 'volatility-trading'],
  content: <<~MARKDOWN
    # Straddles, Strangles & Calendar Spreads

    ## Long Straddle

    Buy both a call and put at the same strike (typically ATM).

    ### When to Use:
    - Expect large price move in either direction
    - High volatility expected (earnings, FDA approval, etc.)
    - Unsure of direction but certain of movement
    - IV is low relative to expected movement

    ### Example:

    **Setup (Stock at $50):**
    - Buy 1 $50 Call for $4
    - Buy 1 $50 Put for $4
    - Total Cost: $8 per share = $800

    **Profit/Loss at Expiration:**

    **Stock at $42:**
    - Call: $0, Put: $8
    - Profit: $800 - $800 = $0 (lower breakeven)

    **Stock at $50:**
    - Call: $0, Put: $0
    - Loss: $800 (max loss)

    **Stock at $58:**
    - Call: $8, Put: $0
    - Profit: $800 - $800 = $0 (upper breakeven)

    **Stock at $35:**
    - Call: $0, Put: $15
    - Profit: $1,500 - $800 = $700

    **Stock at $65:**
    - Call: $15, Put: $0
    - Profit: $1,500 - $800 = $700

    **Key Metrics:**
    - **Max Loss:** Total Premium Paid = $800
    - **Max Profit:** Unlimited (theoretical)
    - **Breakeven Points:**
      - Lower: Strike - Total Premium = $42
      - Upper: Strike + Total Premium = $58
    - **Needs:** 16% move to breakeven ($8 on $50 stock)

    ## Short Straddle

    Sell both a call and put at the same strike.

    ### When to Use:
    - Expect minimal price movement
    - Volatility expected to decrease
    - Want to collect premium from both sides
    - **HIGH RISK - Unlimited loss potential**

    ### Example:

    **Setup (Stock at $50):**
    - Sell 1 $50 Call for $4
    - Sell 1 $50 Put for $4
    - Total Credit: $8 per share = $800

    **Key Metrics:**
    - **Max Profit:** Total Premium = $800 (if stock stays at $50)
    - **Max Loss:** Unlimited
    - **Breakeven Points:** $42 and $58
    - **Risk:** Very high - avoid unless hedged

    ## Long Strangle

    Buy OTM call and OTM put (wider than straddle).

    ### When to Use:
    - Expect large move but less certain than straddle
    - Lower cost than straddle
    - Need bigger move to profit
    - Earnings trades where IV is very high

    ### Example:

    **Setup (Stock at $50):**
    - Buy 1 $45 Put for $2
    - Buy 1 $55 Call for $2
    - Total Cost: $4 per share = $400

    **Profit/Loss at Expiration:**

    **Stock between $45-$55:**
    - Both expire worthless
    - Loss: $400 (max loss)

    **Stock at $41 or $59:**
    - One option worth $4
    - Breakeven: $400 - $400 = $0

    **Stock at $35:**
    - Put worth $10
    - Profit: $1,000 - $400 = $600

    **Stock at $65:**
    - Call worth $10
    - Profit: $1,000 - $400 = $600

    **Key Metrics:**
    - **Max Loss:** Total Premium = $400
    - **Max Profit:** Unlimited (theoretical)
    - **Breakeven Points:**
      - Lower: $45 - $4 = $41
      - Upper: $55 + $4 = $59
    - **Needs:** 18% move to breakeven

    ## Straddle vs Strangle Comparison

    | Aspect | Long Straddle | Long Strangle |
    |--------|--------------|---------------|
    | Cost | Higher ($800) | Lower ($400) |
    | Breakeven | Closer (16%) | Wider (18%) |
    | Max Loss | Higher | Lower |
    | Strikes | ATM/ATM | OTM/OTM |
    | Best Use | Certain big move | Possible big move |

    ## Calendar Spread (Time Spread)

    Buy longer-term option and sell shorter-term option at the same strike.

    ### When to Use:
    - Neutral to slightly bullish/bearish
    - Expect increased volatility after near-term expiration
    - Profit from time decay differential
    - Lower risk than directional trades

    ### Example - Call Calendar:

    **Setup (Stock at $50):**
    - Sell 1 $50 Call expiring in 30 days for $3
    - Buy 1 $50 Call expiring in 60 days for $4.50
    - Net Cost: $1.50 per share = $150

    **Strategy:**
    - Near-term call decays faster
    - If stock stays near $50, profit from decay difference
    - After 30 days, can sell another call against long call

    **Ideal Scenario at 30-Day Expiration:**
    - Stock at $50
    - Short call expires worthless: Keep $300
    - Long call still worth ~$3: $300 value
    - Net: $300 + $300 - $150 cost = $450 profit

    **Key Metrics:**
    - **Max Loss:** Net Debit = $150 (if stock moves far from strike)
    - **Max Profit:** Variable (depends on IV and stock price)
    - **Best Result:** Stock near strike at near-term expiration
    - **Risk:** Lower than directional trades

    ### Put Calendar Spread:

    Same concept using puts instead of calls.

    **Setup (Stock at $50):**
    - Sell $50 Put expiring in 30 days for $3
    - Buy $50 Put expiring in 60 days for $4.50
    - Net Cost: $1.50 per share = $150

    ## Diagonal Spread

    Like calendar but different strikes (e.g., sell lower strike short-term, buy higher strike long-term).

    **Example:**
    - Sell $50 Call expiring in 30 days
    - Buy $55 Call expiring in 60 days

    More directional bias than calendar spread.

    ## Volatility Considerations

    ### High IV Environment:
    - Straddles/Strangles expensive
    - Consider selling premium (iron condors, credit spreads)
    - Be cautious of IV crush after events

    ### Low IV Environment:
    - Straddles/Strangles cheaper
    - Good time to buy if expecting volatility increase
    - Calendar spreads attractive

    ### IV Crush:
    - Happens after earnings/events
    - Rapidly decreases option prices
    - Can hurt long straddles/strangles even if move occurs
    - Reason to consider selling premium before events

    ## Trading Guidelines

    ### Long Straddle/Strangle:
    1. Use before known events (earnings, FDA, etc.)
    2. Need large move to overcome premium
    3. Watch IV - don't overpay
    4. Consider closing before expiration
    5. Have exit plan for both directions

    ### Calendar Spreads:
    1. Use when expecting quiet period then movement
    2. Best with 30-60 day short leg
    3. Monitor at short-term expiration
    4. Can roll short leg multiple times
    5. Lower risk, lower reward

    ### Risk Management:
    - Never risk more than 2-5% of account on one trade
    - Size position assuming total loss
    - Set profit targets (e.g., 50% gain)
    - Set stop loss (e.g., 50% of premium)
    - Close winning trades before expiration

    ## Common Mistakes

    1. **Buying straddles with too high IV** - overpaying
    2. **Not considering IV crush** - earnings trades
    3. **Holding to expiration** - time decay accelerates
    4. **Wrong size** - too large for account
    5. **No exit plan** - hope is not a strategy
  MARKDOWN
}

quiz_advanced_strategies = {
  title: 'Straddles, Strangles & Calendars Practice',
  description: 'Test your understanding of volatility and time-based strategies',
  time_limit: 15
}

questions_advanced_strategies = [
  {
    text: 'You buy a straddle (both $50 call and put) for a total cost of $8. What are your breakeven points?',
    options: [
      { text: '$42 and $50', correct: false },
      { text: '$42 and $58', correct: true },
      { text: '$46 and $54', correct: false },
      { text: '$50 only', correct: false },
      { text: '$48 and $52', correct: false }
    ],
    explanation: 'Breakeven points = Strike ± Total Premium = $50 - $8 = $42 and $50 + $8 = $58',
    difficulty: -0.3,
    topic: 'straddle',
    level: 'medium',
    section_anchor: 'long-straddle'
  },
  {
    text: 'What is the maximum loss when buying a long strangle?',
    options: [
      { text: 'Unlimited', correct: false },
      { text: 'The total premium paid', correct: true },
      { text: 'The strike price difference', correct: false },
      { text: 'Half the premium paid', correct: false },
      { text: 'Zero', correct: false }
    ],
    explanation: 'Maximum loss when buying options (straddle or strangle) is limited to the total premium paid for both options.',
    difficulty: -0.7,
    topic: 'strangle',
    level: 'easy',
    section_anchor: 'long-strangle'
  },
  {
    text: 'Which strategy profits from time decay while maintaining a neutral outlook?',
    options: [
      { text: 'Long straddle', correct: false },
      { text: 'Long strangle', correct: false },
      { text: 'Calendar spread', correct: true },
      { text: 'Long call', correct: false },
      { text: 'Protective put', correct: false }
    ],
    explanation: 'A calendar spread profits from the faster time decay of the short-term option while holding a longer-term option, with a neutral bias.',
    difficulty: -0.2,
    topic: 'calendar-spread',
    level: 'medium',
    section_anchor: 'calendar-spread'
  },
  {
    text: 'A stock is at $50. You buy a $45 put for $2 and a $55 call for $2. What percentage move do you need to break even?',
    options: [
      { text: '8%', correct: false },
      { text: '12%', correct: false },
      { text: '16%', correct: false },
      { text: '18%', correct: true },
      { text: '20%', correct: false }
    ],
    explanation: 'Total cost = $4. Need stock at $41 (down 18%) or $59 (up 18%) to break even. $9 move on $50 stock = 18%',
    difficulty: 0.1,
    topic: 'strangle',
    level: 'medium',
    section_anchor: 'long-strangle'
  },
  {
    text: 'When is a long straddle most profitable?',
    options: [
      { text: 'When the stock stays at the strike price', correct: false },
      { text: 'When there is a large move in either direction', correct: true },
      { text: 'When volatility decreases', correct: false },
      { text: 'When time passes with no price change', correct: false },
      { text: 'At expiration regardless of price', correct: false }
    ],
    explanation: 'A long straddle is most profitable when there is a large price move in either direction, exceeding the total premium paid plus the strike price.',
    difficulty: -0.6,
    topic: 'straddle',
    level: 'easy',
    section_anchor: 'long-straddle'
  }
]

create_lesson_quiz_pair(module_strategies, lesson_advanced_strategies, quiz_advanced_strategies, questions_advanced_strategies, 4)

puts ""
puts "✅ Module 2: Options Strategies Complete (4 lessons, 20 questions)"
puts ""

# =============================================================================
# MODULE 3: THE GREEKS (20 questions across 4 lessons)
# =============================================================================
module_greeks = course.course_modules.find_or_create_by!(slug: 'options-greeks') do |m|
  m.title = 'The Greeks'
  m.description = 'Master all four major Greeks: Delta (directional exposure), Gamma (curvature), Theta (time decay), and Vega (volatility sensitivity). Learn to measure, manage, and profit from options sensitivities.'
  m.sequence_order = 3
  m.estimated_minutes = 600
  m.published = true
end

puts "✓ Module 3: The Greeks"

# -----------------------------------------------------------------------------
# Lesson 3.1: Delta & Position Delta
# -----------------------------------------------------------------------------
lesson_delta = {
  slug: 'delta-position-delta',
  title: 'Delta & Position Delta',
  reading_time: 15,
  key_concepts: ['delta', 'position-delta', 'hedge-ratio', 'directional-risk'],
  content: <<~MARKDOWN
    # Delta & Position Delta

    ## What is Delta?

    **Delta** measures the rate of change in an option's price relative to a $1 change in the underlying stock price.

    ### Delta Values:

    **Calls:**
    - Range: 0 to +1.00
    - ATM Call: ~0.50
    - ITM Call: approaching +1.00
    - OTM Call: approaching 0

    **Puts:**
    - Range: 0 to -1.00
    - ATM Put: ~-0.50
    - ITM Put: approaching -1.00
    - OTM Put: approaching 0

    ### Interpreting Delta:

    **Example 1 - Call Delta:**
    - Stock at $50
    - $50 Call has Delta of 0.50
    - If stock moves to $51, call gains ~$0.50
    - If stock moves to $49, call loses ~$0.50

    **Example 2 - Put Delta:**
    - Stock at $50
    - $50 Put has Delta of -0.50
    - If stock moves to $51, put loses ~$0.50
    - If stock moves to $49, put gains ~$0.50

    ## Delta as Probability

    Delta approximates the probability of expiring ITM:

    - Delta 0.70 call: ~70% chance of expiring ITM
    - Delta 0.30 call: ~30% chance of expiring ITM
    - Delta -0.25 put: ~25% chance of expiring ITM

    ## Position Delta

    **Position Delta** is the total delta of all positions combined.

    ### Calculating Position Delta:

    **Formula:** Position Delta = (Number of Contracts × 100 × Delta)

    ### Example 1: Long Call
    - Buy 2 contracts of $50 Call (Delta 0.60)
    - Position Delta = 2 × 100 × 0.60 = +120
    - Acts like 120 shares of long stock

    ### Example 2: Long Put
    - Buy 3 contracts of $50 Put (Delta -0.45)
    - Position Delta = 3 × 100 × (-0.45) = -135
    - Acts like 135 shares of short stock

    ### Example 3: Covered Call
    - Own 100 shares (Delta +1.00 each) = +100
    - Sell 1 ATM Call (Delta 0.50) = -50
    - Net Position Delta = +100 - 50 = +50
    - Acts like 50 shares of long stock

    ## Delta-Neutral Strategies

    **Delta-neutral** = Position Delta near zero, no directional bias.

    ### Example: Delta-Neutral Position
    - Stock at $100
    - Own 100 shares: Delta = +100
    - Buy 2 ATM Puts (Delta -0.50 each): Delta = -100
    - Net Position Delta = +100 + (-100) = 0
    - Position value stable with small stock moves

    ## Delta Changes

    ### Factors Affecting Delta:

    1. **Stock Price Movement:**
       - Calls: Delta increases as stock rises (becomes more ITM)
       - Puts: Delta becomes more negative as stock falls

    2. **Time Decay:**
       - ATM options: Delta stays near 0.50/-0.50
       - OTM options: Delta decreases toward 0
       - ITM options: Delta moves toward 1.00/-1.00

    3. **Volatility:**
       - Higher IV: Deltas compress toward 0.50/-0.50
       - Lower IV: Deltas spread out

    ## Practical Applications

    ### 1. Hedging
    Use delta to determine hedge ratio:
    - Own 500 shares
    - Need to hedge with ATM puts (Delta -0.50)
    - Puts needed: 500 ÷ 50 = 10 contracts

    ### 2. Position Sizing
    Match delta exposure to conviction:
    - Moderately bullish: +30 to +50 delta
    - Very bullish: +75 to +100 delta
    - Neutral: -10 to +10 delta

    ### 3. Risk Management
    Monitor portfolio delta:
    - Portfolio Delta +500 = Like owning 500 shares
    - If market drops $1, expect ~$500 loss
    - Adjust positions to manage delta exposure

    ## Trading Implications

    ### For Directional Trades:
    - **Bullish:** Positive delta (calls, spreads)
    - **Bearish:** Negative delta (puts, spreads)
    - **Neutral:** Near-zero delta (iron condors, butterflies)

    ### For Income Strategies:
    - Selling options creates negative delta (calls) or positive delta (puts)
    - Manage overall portfolio delta
    - Adjust when delta becomes too large

    ## Key Takeaways

    1. Delta measures option price sensitivity to stock moves
    2. Delta ≈ probability of expiring ITM
    3. Position delta shows directional exposure
    4. Delta changes with stock price, time, and volatility
    5. Use delta for hedging and position management
    6. Monitor and adjust delta as positions evolve
  MARKDOWN
}

quiz_delta = {
  title: 'Delta Practice',
  description: 'Test your understanding of delta and position delta',
  time_limit: 15
}

questions_delta = [
  {
    text: 'A call option has a delta of 0.60. If the stock price increases by $1, approximately how much will the call premium increase?',
    options: [
      { text: '$0.40', correct: false },
      { text: '$0.50', correct: false },
      { text: '$0.60', correct: true },
      { text: '$1.00', correct: false },
      { text: '$1.60', correct: false }
    ],
    explanation: 'Delta measures the change in option price for a $1 change in stock price. A delta of 0.60 means the option gains approximately $0.60.',
    difficulty: -0.5,
    topic: 'delta',
    level: 'easy',
    section_anchor: 'what-is-delta'
  },
  {
    text: 'What is the position delta if you own 100 shares and sell 2 ATM calls with delta 0.50 each?',
    options: [
      { text: '0', correct: true },
      { text: '+50', correct: false },
      { text: '+100', correct: false },
      { text: '-100', correct: false },
      { text: '+200', correct: false }
    ],
    explanation: 'Stock: +100, Calls: 2 × 100 × (-0.50) = -100. Net: +100 - 100 = 0 (delta neutral)',
    difficulty: 0.0,
    topic: 'position-delta',
    level: 'medium',
    section_anchor: 'position-delta'
  },
  {
    text: 'What does a delta of 0.70 on a call option approximate?',
    options: [
      { text: '70% of stock price', correct: false },
      { text: '70% probability of expiring in-the-money', correct: true },
      { text: '$0.70 premium', correct: false },
      { text: '70 days to expiration', correct: false },
      { text: '70% volatility', correct: false }
    ],
    explanation: 'Delta approximates the probability of the option expiring in-the-money. A 0.70 delta suggests about 70% chance of expiring ITM.',
    difficulty: -0.4,
    topic: 'delta',
    level: 'medium',
    section_anchor: 'delta-as-probability'
  },
  {
    text: 'You buy 5 put contracts with delta -0.40. What is your position delta?',
    options: [
      { text: '-40', correct: false },
      { text: '-200', correct: true },
      { text: '+200', correct: false },
      { text: '-500', correct: false },
      { text: '-2,000', correct: false }
    ],
    explanation: 'Position Delta = 5 × 100 × (-0.40) = -200. Acts like a short position of 200 shares.',
    difficulty: -0.3,
    topic: 'position-delta',
    level: 'medium',
    section_anchor: 'position-delta'
  },
  {
    text: 'Which option typically has a delta closest to -1.00?',
    options: [
      { text: 'Deep out-of-the-money put', correct: false },
      { text: 'At-the-money put', correct: false },
      { text: 'Deep in-the-money put', correct: true },
      { text: 'Deep out-of-the-money call', correct: false },
      { text: 'At-the-money call', correct: false }
    ],
    explanation: 'Deep in-the-money puts have deltas approaching -1.00, moving almost dollar-for-dollar with the stock (inversely).',
    difficulty: -0.6,
    topic: 'delta',
    level: 'easy',
    section_anchor: 'what-is-delta'
  }
]

create_lesson_quiz_pair(module_greeks, lesson_delta, quiz_delta, questions_delta, 1)

# -----------------------------------------------------------------------------
# Lesson 3.2: Gamma & Curvature
# -----------------------------------------------------------------------------
lesson_gamma = {
  slug: 'gamma-curvature',
  title: 'Gamma & Curvature',
  reading_time: 15,
  key_concepts: ['gamma', 'curvature', 'delta-change', 'gamma-risk'],
  content: <<~MARKDOWN
    # Gamma & Curvature

    ## What is Gamma?

    **Gamma** measures the rate of change in Delta for a $1 change in the underlying stock price. It tells you how fast Delta is changing.

    ### Key Points:
    - **Gamma is the "acceleration" of options pricing**
    - Higher Gamma = Delta changes more rapidly
    - Gamma is highest for ATM options near expiration
    - Gamma is lowest for deep ITM or OTM options

    ### Gamma Values:
    - Always positive for long options (calls and puts)
    - Always negative for short options (calls and puts)
    - Range: typically 0 to 0.10, but can be higher near expiration

    ## Understanding Gamma with Examples

    ### Example 1: High Gamma Option
    - Stock at $50
    - ATM $50 Call, 7 days to expiration
    - Delta: 0.50, Gamma: 0.08
    - Stock moves to $51: New Delta = 0.50 + 0.08 = 0.58
    - Stock moves to $49: New Delta = 0.50 - 0.08 = 0.42

    ### Example 2: Low Gamma Option
    - Stock at $50
    - ATM $50 Call, 90 days to expiration
    - Delta: 0.50, Gamma: 0.02
    - Stock moves to $51: New Delta = 0.50 + 0.02 = 0.52
    - Stock moves to $49: New Delta = 0.50 - 0.02 = 0.48

    ## Gamma and Curvature

    **Curvature** refers to the non-linear relationship between option prices and stock prices, measured by Gamma.

    ### Linear vs. Curved Payoff:

    **Stock (Linear):**
    - Buy 100 shares at $50
    - Stock to $51 = +$100
    - Stock to $52 = +$100 more
    - Equal profit for each $1 move

    **Long Call (Curved):**
    - Buy $50 Call, Delta 0.50, Gamma 0.05
    - Stock to $51 = +$50 (Delta = 0.55)
    - Stock to $52 = +$55 (Delta = 0.60)
    - Accelerating profit as stock moves up

    ## Gamma Risk

    ### Long Gamma (Long Options):
    - **Benefits:** Delta increases as stock moves favorably
    - **Risk:** Time decay (Theta) working against you
    - **Best when:** Expecting large moves, volatility increase

    ### Short Gamma (Short Options):
    - **Benefits:** Collect premium, time decay working for you
    - **Risk:** Delta increases unfavorably with big moves
    - **Best when:** Expecting range-bound trading, low volatility

    ## Position Gamma

    **Position Gamma** = Sum of all individual position gammas

    ### Example: Covered Call
    - Long 100 shares: Gamma = 0 (stock has no gamma)
    - Short 1 ATM Call (Gamma -0.05 per contract)
    - Position Gamma = -5 (negative gamma position)

    ### Example: Long Straddle
    - Long 1 ATM Call (Gamma +0.06)
    - Long 1 ATM Put (Gamma +0.06)
    - Position Gamma = +12 (positive gamma position)

    ## Gamma Scalping

    **Gamma scalping** is a strategy that exploits high Gamma positions by hedging Delta and profiting from stock volatility.

    ### Basic Process:
    1. Establish positive Gamma position (buy ATM options)
    2. Delta-hedge with stock
    3. As stock moves, Delta changes due to Gamma
    4. Rebalance hedge by trading stock
    5. Profit from stock movement back and forth

    ### Example:
    - Buy 10 ATM Calls (Delta 0.50, Gamma 0.05 each)
    - Position Delta = +500, Position Gamma = +50
    - Hedge: Short 500 shares (Delta -500), Net Delta = 0
    - Stock up $1: Option Delta now 0.55 each = +550
    - Now delta-positive by +50
    - Sell 50 shares to rebalance
    - Profit from selling shares higher after stock moved up

    ## Gamma Throughout Option Life

    **ATM options:**
    - Low Gamma far from expiration
    - Rising Gamma as expiration approaches
    - Maximum Gamma in last week before expiration

    **ITM/OTM options:**
    - Lower Gamma than ATM
    - Gamma decreases as options go deeper ITM/OTM
    - Minimal Gamma for deep ITM/OTM options

    ## Key Takeaways

    1. **Gamma measures Delta sensitivity** - How fast Delta changes
    2. **Long options = positive Gamma** - Delta works in your favor
    3. **Short options = negative Gamma** - Delta works against you
    4. **Highest near expiration** - ATM options most sensitive
    5. **Creates curvature** - Non-linear P&L characteristics
    6. **Important for hedging** - Must monitor and adjust positions

    ---

    ### Practice Questions
    Test your understanding with 5 questions on Gamma and curvature concepts.
  MARKDOWN
}

quiz_gamma = {
  title: 'Gamma & Curvature Quiz',
  description: 'Test your understanding of Gamma, curvature, and how Delta changes with stock price movements.',
  time_limit: 12,
  passing_score: 60
}

questions_gamma = [
  {
    text: 'A trader owns an ATM call option with Delta 0.55 and Gamma 0.07. If the underlying stock increases by $1, what will the new Delta be approximately?',
    options: {
      'A' => '0.48',
      'B' => '0.55',
      'C' => '0.62',
      'D' => '0.69'
    },
    explanation: 'New Delta = Current Delta + Gamma = 0.55 + 0.07 = 0.62. Gamma measures the change in Delta for a $1 move in the underlying.',
    difficulty: 1.2,
    level: 'medium',
    topic: 'gamma-calculation',
    section_anchor: 'gamma-examples'
  },
  {
    text: 'Which statement about Gamma is TRUE?',
    options: {
      'A' => 'Gamma is always negative for call options',
      'B' => 'Gamma is highest for deep out-of-the-money options',
      'C' => 'Gamma is highest for at-the-money options near expiration',
      'D' => 'Gamma is zero for all option positions'
    },
    explanation: 'Gamma is highest for at-the-money (ATM) options that are close to expiration. This is when Delta is most sensitive to price changes.',
    difficulty: 0.8,
    level: 'easy',
    topic: 'gamma-characteristics',
    section_anchor: 'gamma-values'
  },
  {
    text: 'A trader is SHORT 5 contracts of an ATM call with Gamma of 0.06 per contract. What is the position Gamma?',
    options: {
      'A' => '+30',
      'B' => '-30',
      'C' => '+0.06',
      'D' => '-0.06'
    },
    explanation: 'Position Gamma = (5 contracts × 100 shares × 0.06) × (-1 for short) = -30. Short options have negative Gamma.',
    difficulty: 1.4,
    level: 'medium',
    topic: 'position-gamma',
    section_anchor: 'position-gamma'
  },
  {
    text: 'What is the primary risk of having a large NEGATIVE Gamma position?',
    options: {
      'A' => 'Time decay working against you',
      'B' => 'Delta moves unfavorably with large stock price movements',
      'C' => 'Options lose value as volatility decreases',
      'D' => 'Position becomes more profitable as stock moves'
    },
    explanation: 'Negative Gamma means Delta changes work against you. As stock moves unfavorably, your Delta exposure increases in the wrong direction, accelerating losses.',
    difficulty: 1.6,
    level: 'hard',
    topic: 'gamma-risk',
    section_anchor: 'gamma-risk'
  },
  {
    text: 'In Gamma scalping, a trader with positive Gamma and neutral Delta profits from:',
    options: {
      'A' => 'Stock moving in one direction consistently',
      'B' => 'Stock price volatility moving back and forth',
      'C' => 'Time decay of the options',
      'D' => 'Decrease in implied volatility'
    },
    explanation: 'Gamma scalping profits from stock volatility. As stock moves, positive Gamma changes Delta favorably. The trader rebalances by trading stock at advantageous prices, profiting from the movement.',
    difficulty: 1.8,
    level: 'hard',
    topic: 'gamma-scalping',
    section_anchor: 'gamma-scalping'
  }
]

create_lesson_quiz_pair(module_greeks, lesson_gamma, quiz_gamma, questions_gamma, 2)

# -----------------------------------------------------------------------------
# Lesson 3.3: Theta & Time Decay Management
# -----------------------------------------------------------------------------
lesson_theta = {
  slug: 'theta-time-decay',
  title: 'Theta & Time Decay Management',
  reading_time: 15,
  key_concepts: ['theta', 'time-decay', 'extrinsic-value', 'theta-decay'],
  content: <<~MARKDOWN
    # Theta & Time Decay Management

    ## What is Theta?

    **Theta** measures the rate of change in an option's price as time passes, holding all else constant. It represents time decay—the erosion of extrinsic value.

    ### Key Points:
    - **Theta is the "time decay" of options**
    - Expressed as dollars lost per day
    - Always negative for long options (options lose value over time)
    - Always positive for short options (time decay works in your favor)

    ### Theta Values:
    - Typically shown as negative (e.g., -0.05 means option loses $5/day per contract)
    - Highest for ATM options
    - Lower for ITM and OTM options
    - Accelerates as expiration approaches

    ## Understanding Theta with Examples

    ### Example 1: Long Call Time Decay
    - Stock at $50
    - $50 Call, 30 days to expiration
    - Option price: $3.00
    - Theta: -0.08
    - Tomorrow (all else equal): Option worth ~$2.92
    - Daily loss: $8 per contract ($0.08 × 100)

    ### Example 2: Short Put Premium Collection
    - Stock at $50
    - Sell $48 Put, 45 days to expiration
    - Collect $2.00 premium ($200)
    - Theta: +0.06
    - Tomorrow: Option worth ~$1.94
    - Daily gain from decay: $6 per contract

    ## Time Decay Curve

    Time decay is NOT linear—it accelerates as expiration approaches.

    ### 90 Days to Expiration:
    - Slow decay
    - Theta relatively small
    - Plenty of time value remaining

    ### 45 Days to Expiration:
    - Moderate decay
    - Theta increasing
    - Time value eroding faster

    ### 30 Days to Expiration:
    - Rapid decay
    - Theta largest for ATM options
    - Time value disappearing quickly

    ### Last Week (0-7 DTE):
    - Extreme decay
    - Theta can be very large
    - ATM options losing significant value daily

    ## ATM vs ITM vs OTM Theta

    ### At-The-Money (ATM):
    - **Highest absolute Theta**
    - Maximum time value to decay
    - Most sensitive to time passage

    ### In-The-Money (ITM):
    - Lower Theta than ATM
    - Less extrinsic value to lose
    - More intrinsic value (stable)

    ### Out-Of-The-Money (OTM):
    - Lower Theta than ATM
    - Less extrinsic value
    - Can approach zero quickly

    ## Position Theta

    **Position Theta** = Sum of all individual option Thetas

    ### Example 1: Long Straddle (Negative Theta)
    - Long 1 ATM Call (Theta -0.10)
    - Long 1 ATM Put (Theta -0.10)
    - Position Theta = -20 per day
    - Losing $20/day to time decay

    ### Example 2: Iron Condor (Positive Theta)
    - Sell ATM call spread (Theta +0.12)
    - Sell ATM put spread (Theta +0.12)
    - Position Theta = +24 per day
    - Earning $24/day from time decay

    ### Example 3: Covered Call (Slightly Positive Theta)
    - Own 100 shares (Theta = 0)
    - Sell 1 OTM Call (Theta +0.05)
    - Position Theta = +5 per day
    - Small daily income from decay

    ## Managing Time Decay

    ### For Long Options (Fighting Theta):

    **Strategy 1: Buy Further Dated Options**
    - 60-90 days out typically optimal
    - Lower daily Theta
    - More time for thesis to play out

    **Strategy 2: Avoid Last 30 Days**
    - Theta accelerates dramatically
    - Roll to later expiration if still bullish

    **Strategy 3: Use Spreads**
    - Vertical spreads reduce Theta
    - Sell closer-dated option to offset decay
    - Calendar spreads profit from Theta differential

    ### For Short Options (Harnessing Theta):

    **Strategy 1: Sell 30-45 Days Out**
    - Sweet spot for Theta collection
    - Still avoiding excessive Gamma risk
    - Good balance of premium and time

    **Strategy 2: Target ATM or Slightly OTM**
    - Maximum Theta for risk taken
    - Higher probability of success

    **Strategy 3: Manage Winners Early**
    - Take profits at 50-70% max gain
    - Theta decelerates as option goes OTM
    - Redeploy capital to new trades

    ## Theta and Implied Volatility

    **Higher IV = Higher Theta (in absolute terms)**

    ### Example:
    - Low IV environment: ATM option Theta = -0.05
    - High IV environment: Same option Theta = -0.15
    - More extrinsic value means more to decay

    **Impact:**
    - Selling options in high IV = collect more Theta
    - Buying options in high IV = pay more Theta

    ## Weekend and Holiday Theta

    Options decay even when markets are closed:

    ### Friday Close to Monday Open:
    - 3 days of Theta decay
    - Especially significant for short-dated options
    - Factor into trade timing

    ### Holidays:
    - Markets closed but time passes
    - Theta continues to erode
    - Can be favorable for short option positions

    ## Theta Strategies

    ### Positive Theta Strategies (Income):
    1. **Covered Calls** - Modest Theta collection
    2. **Cash-Secured Puts** - Moderate Theta collection
    3. **Credit Spreads** - Good Theta with defined risk
    4. **Iron Condors** - Maximum Theta collection
    5. **Butterflies** - Theta collection with precision

    ### Negative Theta Strategies (Speculation):
    1. **Long Calls/Puts** - Fighting Theta for directional move
    2. **Long Straddles/Strangles** - High Theta cost, betting on big move
    3. **Debit Spreads** - Reduced Theta vs naked long

    ## Key Takeaways

    1. **Theta is time decay** - Options lose value as expiration approaches
    2. **Accelerates near expiration** - Last 30 days most critical
    3. **Highest for ATM options** - Maximum extrinsic value to decay
    4. **Long options fight Theta** - Need stock movement to offset
    5. **Short options collect Theta** - Passage of time is profitable
    6. **Manage with time frames** - Choose expiration strategically
    7. **Balance with other Greeks** - Theta vs Gamma tradeoff crucial

    ---

    ### Practice Questions
    Test your understanding with 5 questions on Theta and time decay management.
  MARKDOWN
}

quiz_theta = {
  title: 'Theta & Time Decay Quiz',
  description: 'Test your understanding of Theta, time decay, and strategies for managing time erosion in options trading.',
  time_limit: 12,
  passing_score: 60
}

questions_theta = [
  {
    text: 'An option has a Theta of -0.07. What does this mean for a trader who owns 3 contracts?',
    options: {
      'A' => 'The position gains $7 per day from time decay',
      'B' => 'The position loses $7 per day from time decay',
      'C' => 'The position gains $21 per day from time decay',
      'D' => 'The position loses $21 per day from time decay'
    },
    explanation: 'Theta of -0.07 means each contract loses $7/day (0.07 × 100). For 3 contracts: 3 × $7 = $21/day loss. Negative Theta for long options means value erodes with time.',
    difficulty: 1.0,
    level: 'medium',
    topic: 'theta-calculation',
    section_anchor: 'theta-examples'
  },
  {
    text: 'For which type of option is Theta typically HIGHEST in absolute value?',
    options: {
      'A' => 'Deep in-the-money options',
      'B' => 'At-the-money options near expiration',
      'C' => 'Far out-of-the-money options',
      'D' => 'Long-dated LEAP options'
    },
    explanation: 'At-the-money (ATM) options near expiration have the highest absolute Theta because they have maximum extrinsic value that decays rapidly as expiration approaches.',
    difficulty: 0.7,
    level: 'easy',
    topic: 'theta-characteristics',
    section_anchor: 'atm-vs-itm-otm'
  },
  {
    text: 'A trader sells an iron condor with a position Theta of +$35. What happens over the weekend (Friday close to Monday open)?',
    options: {
      'A' => 'The position gains approximately $35 from time decay',
      'B' => 'The position gains approximately $105 from time decay',
      'C' => 'The position loses approximately $35 from time decay',
      'D' => 'No time decay occurs because markets are closed'
    },
    explanation: 'Even though markets are closed, time passes over the weekend (3 days: Saturday, Sunday, Monday). Positive Theta of $35/day × 3 days ≈ $105 gain from time decay.',
    difficulty: 1.5,
    level: 'hard',
    topic: 'weekend-theta',
    section_anchor: 'weekend-theta'
  },
  {
    text: 'When selling options to collect Theta, which expiration window is generally considered optimal?',
    options: {
      'A' => '90-120 days to expiration',
      'B' => '60-90 days to expiration',
      'C' => '30-45 days to expiration',
      'D' => '0-15 days to expiration'
    },
    explanation: '30-45 days to expiration is the sweet spot for Theta collection. This timeframe balances maximizing Theta decay while managing Gamma risk, which becomes excessive closer to expiration.',
    difficulty: 1.2,
    level: 'medium',
    topic: 'theta-management',
    section_anchor: 'managing-theta'
  },
  {
    text: 'A long straddle has position Theta of -$40/day. The trader expects a big move in 3 days. What is the approximate time decay cost the trader must overcome?',
    options: {
      'A' => '$40',
      'B' => '$80',
      'C' => '$120',
      'D' => '$160'
    },
    explanation: 'Position Theta of -$40/day × 3 days = -$120. The trader must overcome $120 in time decay through favorable stock movement for the trade to be profitable.',
    difficulty: 1.3,
    level: 'medium',
    topic: 'theta-cost',
    section_anchor: 'negative-theta-strategies'
  }
]

create_lesson_quiz_pair(module_greeks, lesson_theta, quiz_theta, questions_theta, 3)

# -----------------------------------------------------------------------------
# Lesson 3.4: Vega & Volatility Sensitivity
# -----------------------------------------------------------------------------
lesson_vega = {
  slug: 'vega-volatility',
  title: 'Vega & Volatility Sensitivity',
  reading_time: 15,
  key_concepts: ['vega', 'implied-volatility', 'iv-rank', 'volatility-trading'],
  content: <<~MARKDOWN
    # Vega & Volatility Sensitivity

    ## What is Vega?

    **Vega** measures the rate of change in an option's price for a 1% change in implied volatility (IV), holding all else constant.

    ### Key Points:
    - **Vega is the "volatility sensitivity" of options**
    - Expressed in dollars per 1% IV change
    - Always positive for long options
    - Always negative for short options
    - Highest for ATM options with time remaining

    ### Vega Values:
    - Typically 0.05 to 0.30 per contract
    - Higher for longer-dated options
    - Highest for ATM strikes
    - Lower for ITM and OTM strikes

    ## Understanding Vega with Examples

    ### Example 1: Long Call Vega
    - Stock at $50
    - $50 Call, 60 days to expiration
    - Option price: $3.50
    - Current IV: 30%
    - Vega: 0.12
    - **If IV rises to 31%:** Option worth ~$3.62 (+$12)
    - **If IV drops to 29%:** Option worth ~$3.38 (-$12)

    ### Example 2: Short Put Vega
    - Stock at $50
    - Sell $48 Put, 45 days to expiration
    - Collect $2.00 premium ($200)
    - Current IV: 25%
    - Vega: -0.10
    - **If IV rises to 26%:** Put worth $2.10 (loss of $10)
    - **If IV drops to 24%:** Put worth $1.90 (gain of $10)

    ## Implied Volatility (IV)

    **Implied Volatility** is the market's forecast of future volatility, derived from option prices.

    ### Understanding IV:

    **High IV:**
    - Options are expensive
    - Market expects larger moves
    - Good for selling premium
    - Bad for buying options

    **Low IV:**
    - Options are cheap
    - Market expects smaller moves
    - Good for buying options
    - Bad for selling premium

    ### IV vs Historical Volatility (HV):

    **Historical Volatility (HV):**
    - Actual stock movement in the past
    - Objective measurement
    - Example: Stock moved 20% annually last year = 20% HV

    **Implied Volatility (IV):**
    - Expected future movement priced into options
    - Forward-looking
    - Example: Options priced for 30% movement = 30% IV

    ## IV Rank and IV Percentile

    ### IV Rank:
    **Compares current IV to the past year's range**

    Formula: IV Rank = (Current IV - 52-week Low IV) / (52-week High IV - 52-week Low IV) × 100

    ### Example:
    - 52-week IV range: 15% to 45%
    - Current IV: 30%
    - IV Rank = (30 - 15) / (45 - 15) × 100 = 50%

    **Interpretation:**
    - **IV Rank 0-25%:** Low volatility (buy options)
    - **IV Rank 25-50%:** Below average volatility
    - **IV Rank 50-75%:** Above average volatility
    - **IV Rank 75-100%:** High volatility (sell options)

    ### IV Percentile:
    **Percentage of days in past year with IV below current level**

    - 80th percentile: Current IV higher than 80% of past year
    - Good indicator for premium selling opportunities

    ## Position Vega

    **Position Vega** = Sum of all individual option Vegas

    ### Example 1: Long Straddle (Positive Vega)
    - Long 1 ATM Call (Vega +0.15)
    - Long 1 ATM Put (Vega +0.15)
    - Position Vega = +30 per contract
    - Benefits from IV increase

    ### Example 2: Iron Condor (Negative Vega)
    - Short call spread (Vega -0.10)
    - Short put spread (Vega -0.10)
    - Position Vega = -20 per contract
    - Benefits from IV decrease

    ### Example 3: Calendar Spread (Positive Vega)
    - Buy 60-day ATM call (Vega +0.18)
    - Sell 30-day ATM call (Vega -0.12)
    - Net Position Vega = +6
    - Profits from IV increase, especially near-term

    ## Vega Risk Management

    ### For Long Options (Positive Vega):

    **Buy when IV is low:**
    - Options relatively cheap
    - Upside if IV expands
    - Downside if IV contracts further

    **Risks:**
    - IV crush after earnings
    - Volatility mean reversion
    - Time decay accelerates if IV stays low

    **Example - Earnings Play:**
    - IV at 60%, IV Rank 90%
    - Buy call 2 days before earnings = dangerous
    - After earnings: IV drops to 30% (IV crush)
    - Stock up 3%, but option down 20% due to Vega loss

    ### For Short Options (Negative Vega):

    **Sell when IV is high:**
    - Collect elevated premium
    - Benefit if IV contracts
    - Risk if IV expands

    **Best Practices:**
    - Sell at IV Rank > 50%
    - Target high IV percentile (>70th)
    - Avoid selling into IV expansion

    ## Vega and Time to Expiration

    **Longer-dated options = Higher Vega**

    ### Example Comparison:
    Stock at $50, ATM $50 calls, IV at 25%

    - **7 DTE:** Vega = 0.03 (low Vega)
    - **30 DTE:** Vega = 0.08 (moderate Vega)
    - **60 DTE:** Vega = 0.14 (high Vega)
    - **180 DTE:** Vega = 0.25 (very high Vega)

    **Implications:**
    - LEAPS most sensitive to IV changes
    - Weekly options least sensitive
    - Calendar spreads profit from Vega differences

    ## Volatility Trading Strategies

    ### High Vega Strategies (Bet on volatility increase):

    1. **Long Straddles/Strangles**
       - Buy when IV low
       - Profit from IV expansion + movement

    2. **Long Calendar Spreads**
       - Positive net Vega
       - Profit if IV increases

    3. **Ratio Backspreads**
       - Long more options than short
       - Net positive Vega

    ### Low/Negative Vega Strategies (Bet on volatility decrease):

    1. **Short Straddles/Strangles**
       - Sell when IV high
       - Profit from IV contraction

    2. **Iron Condors**
       - Collect premium in high IV
       - Benefit from IV crush

    3. **Credit Spreads**
       - Sell when IV elevated
       - IV contraction helps position

    ## Vega and Earnings

    **Earnings are major IV events**

    ### Before Earnings:
    - IV inflates (higher option prices)
    - Vega increases
    - Uncertainty priced in

    ### After Earnings:
    - **IV Crush:** IV drops sharply
    - Vega loss can be 30-50% overnight
    - Even correct directional bets can lose

    ### Example:
    - Before earnings: $50 Call worth $3.00 (IV 60%)
    - After earnings announcement: Stock at $52 (+4%)
    - Call now worth $2.50 despite stock up
    - IV dropped to 30% = Vega loss overwhelmed Delta gain

    ## Managing Vega Exposure

    ### Monitor Position Vega:
    - Track total portfolio Vega
    - Understand IV sensitivity
    - Avoid concentrated Vega risk

    ### Hedge Vega:
    - **Positive Vega position:** Sell some options to reduce
    - **Negative Vega position:** Buy options to reduce
    - **Calendar spreads:** Balance near and far-term Vega

    ### Use IV Metrics:
    - Check IV Rank before entering
    - Compare IV to historical average
    - Avoid buying in high IV (unless event-based)
    - Prefer selling in high IV

    ## Key Takeaways

    1. **Vega measures IV sensitivity** - How option price changes with volatility
    2. **Long options = positive Vega** - Benefit from IV increase
    3. **Short options = negative Vega** - Benefit from IV decrease
    4. **IV Rank guides strategy** - Sell high IV, buy low IV
    5. **Earnings cause IV crush** - Vega loss can overwhelm other gains
    6. **Longer-dated = higher Vega** - LEAPS most sensitive
    7. **Monitor and manage** - Track position Vega alongside Delta/Theta
    8. **Volatility mean reverts** - High IV tends to decline, low IV tends to rise

    ---

    ### Practice Questions
    Test your understanding with 5 questions on Vega and volatility sensitivity.
  MARKDOWN
}

quiz_vega = {
  title: 'Vega & Volatility Sensitivity Quiz',
  description: 'Test your understanding of Vega, implied volatility, IV Rank, and volatility trading strategies.',
  time_limit: 12,
  passing_score: 60
}

questions_vega = [
  {
    text: 'An option has a Vega of 0.15. If implied volatility increases from 25% to 28%, how much does the option price increase?',
    options: {
      'A' => '$0.15',
      'B' => '$0.30',
      'C' => '$0.45',
      'D' => '$0.75'
    },
    explanation: 'Vega of 0.15 means the option gains $15 per contract for each 1% increase in IV. IV increased by 3% (28% - 25% = 3%), so: 3 × $15 = $45 per contract = $0.45.',
    difficulty: 1.1,
    level: 'medium',
    topic: 'vega-calculation',
    section_anchor: 'vega-examples'
  },
  {
    text: 'A stock has an IV Rank of 85%. What does this suggest for options trading strategies?',
    options: {
      'A' => 'Good opportunity to buy options because they are cheap',
      'B' => 'Good opportunity to sell options because IV is elevated',
      'C' => 'Avoid trading options until IV normalizes',
      'D' => 'IV Rank has no impact on strategy selection'
    },
    explanation: 'IV Rank of 85% means current IV is very high relative to the past year (higher than 85% of the range). This suggests selling premium/options is favorable, as high IV typically mean-reverts downward.',
    difficulty: 1.0,
    level: 'medium',
    topic: 'iv-rank',
    section_anchor: 'iv-rank-percentile'
  },
  {
    text: 'What typically happens to option prices immediately after an earnings announcement?',
    options: {
      'A' => 'Prices increase due to higher Theta',
      'B' => 'Prices decrease due to IV crush (Vega loss)',
      'C' => 'Prices remain unchanged regardless of stock movement',
      'D' => 'Prices always increase with positive earnings'
    },
    explanation: 'After earnings, implied volatility typically drops sharply (IV crush). This Vega loss can cause option prices to decline even if the stock moves in the anticipated direction.',
    difficulty: 1.3,
    level: 'medium',
    topic: 'iv-crush',
    section_anchor: 'vega-earnings'
  },
  {
    text: 'Which option position has the HIGHEST absolute Vega?',
    options: {
      'A' => '7-day at-the-money call',
      'B' => '30-day at-the-money call',
      'C' => '180-day at-the-money call (LEAP)',
      'D' => '7-day far out-of-the-money call'
    },
    explanation: 'Longer-dated at-the-money options have the highest Vega. A 180-day LEAP has much more time value sensitive to IV changes compared to shorter-dated options.',
    difficulty: 0.9,
    level: 'easy',
    topic: 'vega-characteristics',
    section_anchor: 'vega-time-to-expiration'
  },
  {
    text: 'A trader buys a long straddle (long call + long put) with position Vega of +$50. IV increases from 30% to 35%. Assuming no other changes, what is the approximate impact on the position value?',
    options: {
      'A' => '+$50',
      'B' => '+$150',
      'C' => '+$250',
      'D' => '+$350'
    },
    explanation: 'Position Vega of +$50 means $50 gain per 1% increase in IV. IV increased by 5% (35% - 30%), so: 5 × $50 = $250 gain.',
    difficulty: 1.5,
    level: 'hard',
    topic: 'position-vega',
    section_anchor: 'position-vega'
  }
]

create_lesson_quiz_pair(module_greeks, lesson_vega, quiz_vega, questions_vega, 4)

puts "✅ Module 3 Greeks lessons created successfully"

# =============================================================================
# MODULE 4: RISK MANAGEMENT (20 questions across 4 lessons)
# =============================================================================
module_risk = course.course_modules.find_or_create_by!(slug: 'risk-management') do |m|
  m.title = 'Risk Management'
  m.description = 'Professional risk management techniques including position sizing rules, portfolio-level Greeks analysis, delta hedging, volatility trading strategies, IV analysis, and advanced position adjustments and rolling techniques.'
  m.sequence_order = 4
  m.estimated_minutes = 600
  m.published = true
end

puts "✓ Module 4: Risk Management"

# -----------------------------------------------------------------------------
# Lesson 4.1: Position Sizing & Risk Management
# -----------------------------------------------------------------------------
lesson_position_sizing = {
  slug: 'position-sizing-risk-management',
  title: 'Position Sizing & Risk Management',
  reading_time: 15,
  key_concepts: ['position-sizing', 'risk-per-trade', 'portfolio-allocation', 'max-loss'],
  content: <<~MARKDOWN
    # Position Sizing & Risk Management

    ## The Foundation of Successful Trading

    **Risk management** is THE most important skill in options trading. Even the best strategy will fail without proper position sizing and risk control.

    ### Core Principle:
    **Preserve capital first, make profits second.**

    - Survive to trade another day
    - Small losses are acceptable
    - Protecting against catastrophic losses is critical

    ## Position Sizing Rules

    ### Rule 1: Risk Per Trade Limit

    **Never risk more than 1-2% of total portfolio on any single trade.**

    ### Example - $50,000 Portfolio:
    - 1% risk = $500 maximum loss per trade
    - 2% risk = $1,000 maximum loss per trade

    ### Why This Matters:
    - 10 consecutive losses at 2% = 18% portfolio drawdown (recoverable)
    - 10 consecutive losses at 10% = 65% portfolio drawdown (devastating)
    - 10 consecutive losses at 20% = 89% portfolio drawdown (nearly terminal)

    ### How to Calculate Position Size:

    **For Debit Spreads:**
    - Max Loss = Debit Paid
    - Position Size = (Portfolio × Risk %) / Max Loss Per Contract

    **Example:**
    - $50,000 portfolio, 2% risk = $1,000 max loss
    - Bull call spread costs $2.50 ($250 per contract)
    - Max contracts: $1,000 / $250 = 4 contracts

    **For Credit Spreads:**
    - Max Loss = Width of Spread - Credit Received
    - Position Size = (Portfolio × Risk %) / Max Loss Per Contract

    **Example:**
    - $50,000 portfolio, 2% risk = $1,000 max loss
    - Bull put spread: $5 wide, credit $1.50 ($150)
    - Max loss per contract = ($5.00 - $1.50) × 100 = $350
    - Max contracts: $1,000 / $350 = 2 contracts

    **For Naked Options (Higher Risk):**
    - Calculate realistic max loss (not theoretical infinite)
    - Use technical levels (support/resistance) to define risk
    - Consider 2-3× standard move as worst case

    ## Portfolio Allocation

    ### Conservative Allocation (Beginner/Risk-Averse):
    - **50-70%** in cash or stable investments
    - **20-30%** in defined-risk options trades
    - **0-10%** in higher-risk strategies
    - Maximum 5-8 positions

    ### Moderate Allocation (Intermediate):
    - **30-50%** in cash or stable investments
    - **40-60%** in defined-risk options trades
    - **10-20%** in higher-risk strategies
    - Maximum 8-12 positions

    ### Aggressive Allocation (Advanced):
    - **10-30%** in cash or stable investments
    - **50-70%** in defined-risk options trades
    - **20-30%** in higher-risk strategies
    - Maximum 10-15 positions

    ## Diversification in Options

    ### Diversify Across:

    **1. Sectors:**
    - Don't concentrate in tech, finance, or any single sector
    - Sector crashes can wipe out correlated positions

    **2. Underlyings:**
    - Don't put all positions on same stock
    - Maximum 3-4 positions on same underlying

    **3. Strategies:**
    - Mix credit spreads, debit spreads, iron condors, etc.
    - Different strategies profit in different conditions

    **4. Expiration Dates:**
    - Avoid all positions expiring same day
    - Stagger expirations across weeks/months

    **5. Directional Bias:**
    - Don't be all bullish or all bearish
    - Market reversals can devastate directional portfolios

    ## Maximum Loss Limits

    ### Per-Trade Stop Loss:
    - Exit when loss reaches 100-200% of credit received (credit spreads)
    - Exit when loss reaches 50-75% of max loss (debit spreads)
    - Don't hold losers to expiration hoping for miracles

    ### Daily Loss Limit:
    - Stop trading if down 3-5% in single day
    - Prevents emotional revenge trading
    - Allows time to reassess

    ### Weekly/Monthly Loss Limit:
    - Stop trading if down 10% in a week
    - Stop trading if down 15-20% in a month
    - Take break, review trades, adjust strategy

    ## The Kelly Criterion (Advanced)

    **Kelly Criterion** helps calculate optimal position size based on win rate and risk/reward.

    ### Formula:
    Kelly % = (Win Rate × Avg Win) - (Loss Rate × Avg Loss) / Avg Win

    ### Example:
    - Win Rate: 65%
    - Avg Win: $200
    - Loss Rate: 35%
    - Avg Loss: $150
    - Kelly % = (0.65 × 200) - (0.35 × 150) / 200 = 38.75%

    **But be cautious:**
    - Kelly can suggest very high position sizes
    - Most traders use 25-50% of Kelly suggestion
    - "Quarter Kelly" or "Half Kelly" more conservative

    ## Buying Power Management

    ### Understand Margin Requirements:

    **Defined-Risk Trades:**
    - Spreads: Margin = Max Loss
    - Iron Condors: Margin = Wider side max loss
    - Example: $5 wide spread, $1.50 credit = $350 margin

    **Undefined-Risk Trades:**
    - Naked calls/puts: High margin requirements
    - Can change with volatility
    - Avoid using >50% of buying power

    ### Margin Call Prevention:
    - Never use 100% of available buying power
    - Keep 30-40% cushion for adverse moves
    - Monitor margin daily, especially in volatile markets

    ## Risk of Ruin

    **Risk of Ruin** = probability of losing entire account

    ### Factors:
    1. Position sizing (higher = higher ruin risk)
    2. Win rate (lower = higher ruin risk)
    3. Risk/reward ratio (worse = higher ruin risk)

    ### Example:
    - 20% risk per trade, 50% win rate = 100% risk of ruin (eventually)
    - 2% risk per trade, 50% win rate = <1% risk of ruin
    - 2% risk per trade, 60% win rate = near 0% risk of ruin

    ## Psychological Risk Management

    ### Position Size Comfort Test:
    **If losing the trade would cause significant stress, the position is TOO LARGE.**

    ### Signs Position is Too Large:
    - Checking constantly (every 5-10 minutes)
    - Can't sleep thinking about it
    - Feel panicked when stock moves against you
    - Considering violating stop loss rules

    ### Proper Position Size Feels:
    - "I hope this works but I'll be fine if it doesn't"
    - Check a few times per day, not every minute
    - Accept losses without emotional damage

    ## Common Position Sizing Mistakes

    ### Mistake 1: Oversizing Winners
    - Had 3 winners in a row → increase size dramatically
    - "I'm on fire!" mentality
    - Then big loss wipes out all gains

    ### Mistake 2: Undersizing After Losses
    - Had 2 losses → reduce size too much
    - Miss profitable opportunities
    - Can't recover from drawdown

    ### Mistake 3: Revenge Trading
    - Big loss → immediately enter bigger position to "make it back"
    - Emotional, not logical
    - Often leads to bigger losses

    ### Mistake 4: Ignoring Correlation
    - 10 positions all in tech stocks
    - "Diversified" but not really
    - All lose together in sector correction

    ## Key Takeaways

    1. **Risk 1-2% per trade maximum** - Foundation of risk management
    2. **Size positions mathematically** - Not based on gut feeling
    3. **Diversify across multiple dimensions** - Sector, underlying, strategy, date
    4. **Use stop losses** - Don't hold losers to zero
    5. **Manage buying power** - Keep 30-40% cushion
    6. **Position size for comfort** - If stressed, too large
    7. **Avoid common mistakes** - Oversizing, revenge trading, false diversification
    8. **Survive first, profit second** - You can't win if you're out of the game

    ---

    ### Practice Questions
    Test your understanding with 5 questions on position sizing and risk management.
  MARKDOWN
}

quiz_position_sizing = {
  title: 'Position Sizing & Risk Management Quiz',
  description: 'Test your understanding of position sizing, risk management, and portfolio allocation strategies.',
  time_limit: 12,
  passing_score: 60
}

questions_position_sizing = [
  {
    text: 'A trader has a $100,000 account and follows a 2% risk-per-trade rule. What is the maximum dollar amount they should risk on any single trade?',
    options: {
      'A' => '$1,000',
      'B' => '$2,000',
      'C' => '$5,000',
      'D' => '$10,000'
    },
    explanation: '2% of $100,000 = $2,000. This is the maximum loss the trader should accept on any single trade to maintain proper risk management.',
    difficulty: 0.6,
    level: 'easy',
    topic: 'risk-per-trade',
    section_anchor: 'position-sizing-rules'
  },
  {
    text: 'A trader with a $50,000 account wants to trade a bull put spread that is $5 wide and collects $1.50 credit. Following a 2% risk rule, how many contracts should they trade?',
    options: {
      'A' => '1 contract',
      'B' => '2 contracts',
      'C' => '3 contracts',
      'D' => '4 contracts'
    },
    explanation: '2% of $50,000 = $1,000 max risk. Max loss per contract = ($5 - $1.50) × 100 = $350. Contracts = $1,000 / $350 = 2.85, round down to 2 contracts to stay within risk limit.',
    difficulty: 1.4,
    level: 'medium',
    topic: 'position-sizing-calculation',
    section_anchor: 'position-sizing-rules'
  },
  {
    text: 'Which of the following represents proper portfolio diversification for an options trader?',
    options: {
      'A' => '10 iron condors all on SPY expiring on the same date',
      'B' => '8 positions across 4 different sectors with staggered expirations',
      'C' => '15 bull call spreads all in the technology sector',
      'D' => 'All buying power allocated to a single trade with high conviction'
    },
    explanation: 'Proper diversification means spreading risk across sectors, underlyings, and expiration dates. Option B demonstrates this by having multiple sectors and staggered expirations.',
    difficulty: 0.9,
    level: 'easy',
    topic: 'diversification',
    section_anchor: 'diversification'
  },
  {
    text: 'A trader experiences a 2% loss on Monday, a 3% loss on Tuesday, and a 2% loss on Wednesday. If they have a 5% daily loss limit, what should they do?',
    options: {
      'A' => 'Continue trading normally since no single day exceeded 5%',
      'B' => 'Stop trading for the week and review their strategy',
      'C' => 'Increase position size to recover losses',
      'D' => 'Only trade half their normal position size'
    },
    explanation: 'While individual days didn\'t exceed the 5% limit, three consecutive losing days totaling 7% loss indicates something is wrong. The trader should stop, review, and reassess before continuing.',
    difficulty: 1.6,
    level: 'hard',
    topic: 'loss-limits',
    section_anchor: 'maximum-loss-limits'
  },
  {
    text: 'What is the primary psychological indicator that a position size is TOO LARGE?',
    options: {
      'A' => 'The trade has high profit potential',
      'B' => 'You check the position constantly and feel significant stress',
      'C' => 'The position uses defined-risk strategies',
      'D' => 'The position follows your written trading plan'
    },
    explanation: 'If losing the trade causes significant stress, constant checking, or sleep disruption, the position is too large regardless of the strategy. Proper sizing should allow emotional detachment.',
    difficulty: 1.0,
    level: 'medium',
    topic: 'psychological-risk',
    section_anchor: 'psychological-risk-management'
  }
]

create_lesson_quiz_pair(module_risk, lesson_position_sizing, quiz_position_sizing, questions_position_sizing, 1)

# -----------------------------------------------------------------------------
# Lesson 4.2: Portfolio Greeks & Hedging
# -----------------------------------------------------------------------------
lesson_portfolio_greeks = {
  slug: 'portfolio-greeks-hedging',
  title: 'Portfolio Greeks & Hedging',
  reading_time: 15,
  key_concepts: ['portfolio-greeks', 'delta-hedging', 'greek-neutrality', 'dynamic-hedging'],
  content: <<~MARKDOWN
    # Portfolio Greeks & Hedging

    ## Portfolio-Level Risk Management

    Individual position Greeks are important, but **portfolio-level Greeks** tell the complete risk story.

    ### Portfolio Greeks = Sum of all position Greeks

    **Example Portfolio:**
    - Position 1: Delta +150, Gamma +20, Theta -15, Vega +30
    - Position 2: Delta -80, Gamma -10, Theta +8, Vega -15
    - Position 3: Delta +50, Gamma +5, Theta -5, Vega +10
    - **Portfolio:** Delta +120, Gamma +15, Theta -12, Vega +25

    ## Understanding Portfolio Delta

    **Portfolio Delta** measures directional exposure to underlying price movement.

    ### Interpreting Portfolio Delta:

    **Positive Delta (Bullish):**
    - Portfolio profits if market goes up
    - Portfolio loses if market goes down
    - Delta +500 ≈ long 500 shares worth of exposure

    **Negative Delta (Bearish):**
    - Portfolio profits if market goes down
    - Portfolio loses if market goes up
    - Delta -300 ≈ short 300 shares worth of exposure

    **Near-Zero Delta (Neutral):**
    - Portfolio relatively insensitive to direction
    - Profits from other factors (Theta, Vega, Gamma)
    - Delta -20 to +20 considered neutral for most portfolios

    ### Example - Directional Bias:
    - $100,000 portfolio
    - Portfolio Delta: +800
    - If SPY moves up $1, portfolio gains ~$800
    - If SPY moves down $1, portfolio loses ~$800
    - Effective leverage: 0.8% move for 1% SPY move

    ## Delta Hedging

    **Delta hedging** neutralizes directional risk by offsetting position Delta.

    ### Why Delta Hedge?
    - Remove directional risk
    - Isolate other Greeks (Gamma, Theta, Vega)
    - Reduce portfolio volatility
    - Profit from volatility/time decay without market direction

    ### Basic Delta Hedging with Stock:

    **Example 1 - Hedge Long Calls:**
    - Own 10 ATM calls (Delta 0.50 each)
    - Position Delta: 10 × 100 × 0.50 = +500
    - **Hedge:** Short 500 shares
    - Net Delta: +500 - 500 = 0 (delta-neutral)

    **Example 2 - Hedge Short Puts:**
    - Short 5 puts (Delta -0.40 each)
    - Position Delta: 5 × 100 × (-0.40) = -200
    - **Hedge:** Long 200 shares
    - Net Delta: -200 + 200 = 0 (delta-neutral)

    ### Delta Hedging with Options:

    **Example - Hedge with opposite options:**
    - Long 10 calls (Delta +500)
    - Buy 12 puts (Delta -0.42 each) = -504
    - Net Delta: +500 - 504 = -4 (approximately neutral)

    ## Dynamic Delta Hedging

    **Delta changes as stock moves (due to Gamma).** Hedges must be rebalanced.

    ### Example Scenario:
    **Day 1:**
    - Long 10 calls (Delta 0.50, Gamma 0.05)
    - Position Delta: +500
    - Hedge: Short 500 shares
    - Net Delta: 0

    **Day 2 - Stock up $2:**
    - Call Delta now: 0.50 + (2 × 0.05) = 0.60
    - Position Delta: 10 × 100 × 0.60 = +600
    - Still short 500 shares
    - Net Delta: +600 - 500 = +100 (now delta-long)
    - **Rebalance:** Short 100 more shares

    ### Rebalancing Frequency:
    - **High Gamma positions:** Daily or more
    - **Low Gamma positions:** Weekly
    - **Near expiration:** Intraday if needed
    - **Cost consideration:** Each rebalance = transaction costs

    ## Portfolio Gamma Management

    **Portfolio Gamma** determines how fast Portfolio Delta changes.

    ### High Positive Gamma:
    - Delta increases favorably with movement
    - Good for volatile markets
    - Expensive (negative Theta)
    - Delta hedge accelerates profits

    ### High Negative Gamma:
    - Delta moves against you with movement
    - Dangerous in volatile markets
    - Benefits from Theta collection
    - Requires active monitoring

    ### Example - Gamma Risk:
    - Portfolio Gamma: -100
    - Current Delta: 0 (hedged)
    - Market drops $3
    - New Delta: 0 - (3 × 100) = -300
    - Now significantly delta-short (losing on down moves)
    - Must buy 300 shares to rehedge

    ## Portfolio Theta Management

    **Portfolio Theta** shows daily P&L from time decay.

    ### Positive Portfolio Theta:
    - Earn money daily from time decay
    - Typically short options (negative Gamma)
    - Prefer stable, range-bound markets
    - Example: Iron condor portfolio

    ### Negative Portfolio Theta:
    - Lose money daily to time decay
    - Typically long options (positive Gamma)
    - Need movement to offset decay
    - Example: Long straddle portfolio

    ### Theta/Gamma Tradeoff:
    **Long Gamma = Negative Theta** (pay for convexity)
    **Short Gamma = Positive Theta** (collect for taking risk)

    ### Target Portfolio Theta:
    - Income-focused: Target +$50-100/day per $100k
    - Neutral: Target ±$20/day per $100k
    - Speculation: Negative Theta acceptable short-term

    ## Portfolio Vega Management

    **Portfolio Vega** shows sensitivity to IV changes.

    ### Positive Portfolio Vega:
    - Benefit from IV increase
    - Hurt by IV decrease
    - Typically net long options
    - Good when IV low (IV Rank <30%)

    ### Negative Portfolio Vega:
    - Benefit from IV decrease
    - Hurt by IV increase
    - Typically net short options
    - Good when IV high (IV Rank >60%)

    ### Example - Vega Risk:
    - Portfolio Vega: +150
    - Market event causes IV drop from 25% to 20% (-5%)
    - Portfolio loss: 5 × $150 = -$750 (from Vega alone)
    - Even with favorable Delta/Gamma moves

    ## Greek-Neutral Strategies

    ### Delta-Neutral:
    - Portfolio Delta near zero
    - No directional bias
    - Profit from Theta, Vega, or Gamma

    **Example Strategies:**
    - Iron condors
    - Strangles (can be delta-neutral)
    - Calendar spreads
    - Butterflies

    ### Delta-Gamma Neutral:
    - Both Delta and Gamma near zero
    - Insensitive to direction AND acceleration
    - Complex to maintain
    - Used by market makers

    ### Vega-Neutral:
    - Portfolio Vega near zero
    - Insensitive to IV changes
    - Combine long and short options with different expirations

    ## Hedging with ETFs and Futures

    ### SPY/SPX Options:
    - Hedge portfolio Delta with SPY shares or SPX futures
    - 1 SPX future ≈ $450,000 notional (at SPX 4500)
    - 1 SPY share ≈ $450 (at SPY 450)

    **Example:**
    - Multi-stock portfolio Delta: +2000
    - **Hedge:** Short 2000 shares SPY OR 1 SPX future
    - Neutralizes market exposure
    - Keeps individual stock risk

    ### Sector Hedging:
    - Tech-heavy portfolio: Hedge with QQQ
    - Financial-heavy portfolio: Hedge with XLF
    - Energy-heavy portfolio: Hedge with XLE

    ## Monitoring Tools and Metrics

    ### Key Portfolio Metrics:

    **1. Net Delta / Portfolio Size:**
    - Example: Delta +300 on $100k = 0.3% exposure
    - Keep under 2-5% unless directional

    **2. Theta / Portfolio Size:**
    - Example: Theta +$50 on $100k = 0.05% daily
    - Income traders target 0.05-0.15% daily

    **3. Vega / Portfolio Size:**
    - Example: Vega +200 on $100k = 0.2% per IV point
    - Monitor when IV Rank changes

    **4. Gamma / Portfolio Size:**
    - High Gamma: Requires frequent rebalancing
    - Low Gamma: Can be passive

    ### Daily Portfolio Review Checklist:
    1. Check net Delta - rehedge if needed
    2. Review Theta P&L - meeting targets?
    3. Monitor Vega - IV environment changed?
    4. Assess Gamma - rebalancing frequency adequate?
    5. Check margin usage - within limits?

    ## Advanced Hedging Techniques

    ### 1. Partial Hedging:
    - Don't hedge 100% of Delta
    - Keep 20-30% directional bias
    - Example: Delta +500, hedge only -350

    ### 2. Tactical Hedging:
    - Hedge more when uncertain
    - Reduce hedge when confident
    - Adjust based on market conditions

    ### 3. Correlation Hedging:
    - Don't hedge each position individually
    - Hedge portfolio Beta
    - More efficient, lower transaction costs

    ## Common Hedging Mistakes

    ### Mistake 1: Over-Hedging
    - Hedging every position individually
    - Excessive transaction costs
    - Eliminates all profit potential

    ### Mistake 2: Under-Hedging
    - Ignoring portfolio-level exposure
    - Unexpected directional risk
    - Large losses on market moves

    ### Mistake 3: Static Hedging
    - Set hedge once, forget it
    - Delta changes with price/time
    - Hedge becomes ineffective

    ### Mistake 4: Ignoring Other Greeks
    - Focus only on Delta
    - Miss Vega or Gamma risks
    - Hedged Delta but still lose money

    ## Key Takeaways

    1. **Think portfolio-level** - Not just individual positions
    2. **Monitor all Greeks** - Delta, Gamma, Theta, Vega
    3. **Delta hedge strategically** - Neutralize unwanted directional risk
    4. **Rebalance dynamically** - Gamma changes Delta constantly
    5. **Balance Theta/Gamma** - Understand the tradeoff
    6. **Use ETFs efficiently** - SPY/SPX for portfolio hedging
    7. **Review daily** - Greeks change, hedge accordingly
    8. **Avoid common mistakes** - Over/under hedging, static hedges

    ---

    ### Practice Questions
    Test your understanding with 5 questions on portfolio Greeks and hedging strategies.
  MARKDOWN
}

quiz_portfolio_greeks = {
  title: 'Portfolio Greeks & Hedging Quiz',
  description: 'Test your understanding of portfolio-level Greeks, delta hedging, and dynamic hedging strategies.',
  time_limit: 12,
  passing_score: 60
}

questions_portfolio_greeks = [
  {
    text: 'A portfolio has three positions with the following Deltas: Position A: +200, Position B: -150, Position C: +80. What is the portfolio Delta?',
    options: {
      'A' => '+330',
      'B' => '+130',
      'C' => '-70',
      'D' => '+430'
    },
    explanation: 'Portfolio Delta = Sum of all position Deltas = +200 + (-150) + 80 = +130. This indicates the portfolio has net bullish exposure equivalent to 130 shares.',
    difficulty: 0.8,
    level: 'easy',
    topic: 'portfolio-delta',
    section_anchor: 'portfolio-delta'
  },
  {
    text: 'A trader owns 8 call contracts (Delta 0.60 each). How many shares should they SHORT to create a delta-neutral hedge?',
    options: {
      'A' => '60 shares',
      'B' => '480 shares',
      'C' => '600 shares',
      'D' => '800 shares'
    },
    explanation: 'Position Delta = 8 contracts × 100 shares × 0.60 = 480. To neutralize, short 480 shares. This creates Delta +480 (calls) - 480 (short stock) = 0.',
    difficulty: 1.2,
    level: 'medium',
    topic: 'delta-hedging',
    section_anchor: 'delta-hedging'
  },
  {
    text: 'A delta-neutral portfolio has Gamma of -120. The underlying moves up $2. What is the approximate new portfolio Delta?',
    options: {
      'A' => '-240',
      'B' => '-120',
      'C' => '0',
      'D' => '+120'
    },
    explanation: 'Negative Gamma means Delta moves against the stock. New Delta = 0 + (-120 × 2) = -240. The portfolio is now delta-short and losing on upward moves, requiring rehedging.',
    difficulty: 1.5,
    level: 'hard',
    topic: 'gamma-impact',
    section_anchor: 'portfolio-gamma-management'
  },
  {
    text: 'What is the primary relationship between Portfolio Theta and Portfolio Gamma?',
    options: {
      'A' => 'Both are always positive together',
      'B' => 'Long Gamma typically means negative Theta (inverse relationship)',
      'C' => 'They are unrelated',
      'D' => 'Both are always negative together'
    },
    explanation: 'Long Gamma (positive) typically comes with negative Theta - you pay time decay for convexity. Short Gamma (negative) comes with positive Theta - you collect time decay for taking risk.',
    difficulty: 1.1,
    level: 'medium',
    topic: 'theta-gamma-tradeoff',
    section_anchor: 'portfolio-theta-management'
  },
  {
    text: 'A $100,000 portfolio has Portfolio Vega of +$200. Implied volatility decreases from 30% to 25%. What is the approximate impact on the portfolio?',
    options: {
      'A' => '+$200 gain',
      'B' => '-$200 loss',
      'C' => '+$1,000 gain',
      'D' => '-$1,000 loss'
    },
    explanation: 'IV decreased by 5 percentage points (30% - 25%). Portfolio Vega of +$200 means $200 gain per 1% increase in IV, so: 5 × (-$200) = -$1,000 loss from positive Vega with IV decrease.',
    difficulty: 1.4,
    level: 'hard',
    topic: 'portfolio-vega',
    section_anchor: 'portfolio-vega-management'
  }
]

create_lesson_quiz_pair(module_risk, lesson_portfolio_greeks, quiz_portfolio_greeks, questions_portfolio_greeks, 2)

# -----------------------------------------------------------------------------
# Lesson 4.3: Volatility Trading & IV Analysis
# -----------------------------------------------------------------------------
lesson_volatility_trading = {
  slug: 'volatility-trading-iv-analysis',
  title: 'Volatility Trading & IV Analysis',
  reading_time: 15,
  key_concepts: ['volatility-trading', 'iv-analysis', 'volatility-skew', 'term-structure'],
  content: <<~MARKDOWN
    # Volatility Trading & IV Analysis

    ## Trading Volatility vs. Direction

    Most traders focus on stock direction (bull/bear), but **volatility trading** focuses on how much stocks move, not which direction.

    ### Key Concept:
    **You can profit from volatility without predicting direction.**

    ### Volatility Trading Benefits:
    - Less dependent on market timing
    - Profit from market uncertainty
    - Diversifies from directional strategies
    - Can work in any market environment

    ## Implied Volatility Deep Dive

    **Implied Volatility (IV)** is THE most important factor for volatility traders.

    ### What IV Really Means:

    **IV of 30%:**
    - Market expects $100 stock to move ±$30 over next year (1 standard deviation)
    - Daily expected move: $30 / √252 ≈ $1.89
    - 68% probability stock stays between $70-$130 in one year

    **IV of 60%:**
    - Market expects $100 stock to move ±$60 over next year
    - Daily expected move: $60 / √252 ≈ $3.78
    - Much larger expected movement

    ## IV Rank and IV Percentile (Review and Application)

    ### IV Rank Formula:
    IV Rank = (Current IV - 52-week Low) / (52-week High - 52-week Low) × 100

    ### Trading Guidelines:

    **IV Rank 0-25% (Low Volatility):**
    - **Strategy:** Buy options (long Vega)
    - Long straddles/strangles
    - Debit spreads
    - Calendar spreads (long)
    - Rationale: IV likely to increase

    **IV Rank 25-50% (Below Average):**
    - **Strategy:** Neutral to slightly bullish on volatility
    - Selective buying opportunities
    - Some selling with caution

    **IV Rank 50-75% (Above Average):**
    - **Strategy:** Begin selling options (short Vega)
    - Credit spreads
    - Iron condors
    - Covered calls
    - Rationale: IV likely to decrease

    **IV Rank 75-100% (High Volatility):**
    - **Strategy:** Aggressively sell options
    - Short strangles (if comfortable)
    - Iron condors
    - Credit spreads
    - Rationale: IV very likely to revert lower

    ## Volatility Skew

    **Volatility Skew** shows how IV varies across different strike prices for the same expiration.

    ### Types of Skew:

    **1. Negative Skew (Equity Skew):**
    - OTM puts have HIGHER IV than OTM calls
    - Common in stocks and indices
    - Reflects crash risk premium

    **Example - SPY:**
    - $450 Call (ATM): IV = 20%
    - $430 Put (OTM): IV = 25%
    - $470 Call (OTM): IV = 18%
    - Put protection more expensive

    **2. Positive Skew:**
    - OTM calls have HIGHER IV than OTM puts
    - Common in commodities, crypto
    - Reflects upside volatility/momentum

    **3. Flat Skew:**
    - Similar IV across strikes
    - Rare, usually temporary
    - Market sees symmetric risk

    ### Trading the Skew:

    **When Skew is Steep (High put IV):**
    - Sell OTM puts (collect elevated premium)
    - Buy calls (relatively cheap)
    - Bull risk reversals (sell put, buy call)

    **When Skew is Flat:**
    - Neutral strategies
    - Iron condors more balanced
    - Straddles/strangles more attractive

    ## Volatility Term Structure

    **Term Structure** shows how IV varies across different expiration dates.

    ### Normal Term Structure (Contango):
    - Far-dated IV > Near-dated IV
    - Upward sloping curve
    - More uncertainty further out in time
    - Normal market state

    **Example:**
    - 30-day IV: 20%
    - 60-day IV: 23%
    - 90-day IV: 25%

    ### Inverted Term Structure (Backwardation):
    - Near-dated IV > Far-dated IV
    - Downward sloping curve
    - Imminent event/uncertainty
    - Unusual market state

    **Example (Before Earnings):**
    - 7-day IV: 50% (includes earnings)
    - 30-day IV: 30%
    - 60-day IV: 25%

    ### Trading Term Structure:

    **Normal Term Structure:**
    - **Calendar Spreads:** Sell near-dated, buy far-dated
    - Collect from near-term decay
    - Maintain far-term protection

    **Inverted Term Structure:**
    - **Reverse Calendar Spreads:** Buy near-dated, sell far-dated
    - Profit from near-term IV crush
    - Example: After earnings announcement

    ## Volatility Mean Reversion

    **Key Principle:** Volatility tends to revert to its mean over time.

    ### High IV → Contracts
    - Markets calm down after spikes
    - Implied volatility tends to overestimate realized volatility
    - Selling options in high IV statistically profitable

    ### Low IV → Expands
    - Complacency doesn't last forever
    - Volatility spikes happen
    - Buying options in low IV offers good risk/reward

    ### Trading Mean Reversion:

    **Sell Premium When:**
    - IV Rank > 70%
    - IV > Historical Volatility by 10+ points
    - Post-spike environments
    - Market showing signs of stabilization

    **Buy Options When:**
    - IV Rank < 30%
    - IV < Historical Volatility
    - Extended low volatility periods
    - Market complacency high

    ## VIX - The Volatility Index

    **VIX** measures 30-day implied volatility of S&P 500 options.

    ### VIX Interpretation:

    **VIX < 15:**
    - Low volatility, market complacency
    - Good time to buy protection
    - Straddles/strangles attractive
    - Market expecting small moves

    **VIX 15-25:**
    - Normal volatility range
    - Balanced strategies appropriate
    - No strong signal either way

    **VIX 25-35:**
    - Elevated volatility
    - Good time to sell premium
    - Iron condors, credit spreads
    - Market expecting larger moves

    **VIX > 35:**
    - High volatility, fear/panic
    - Excellent time to sell premium
    - Careful with sizing (big moves possible)
    - Short strangles, iron condors profitable

    ### VIX Mean Reversion:
    - VIX tends to revert to ~18-20
    - Spikes above 30 usually temporary
    - Below 12 tends to bounce back

    ## Realized Volatility vs. Implied Volatility

    ### Realized Volatility (RV):
    - Actual stock movement that occurred
    - Historical, objective measurement
    - Calculated from price data

    ### Implied Volatility (IV):
    - Expected future movement
    - Forward-looking, subjective
    - Derived from option prices

    ### The Volatility Risk Premium:

    **Key Insight:** IV typically OVERSTATES RV

    **Example:**
    - Stock IV: 30%
    - Actual RV over period: 22%
    - IV overstated by 8 points

    **Why?**
    - Market participants pay premium for protection
    - Fear drives option buying
    - Sellers demand compensation for risk

    **Trading Opportunity:**
    - Systematically selling options profits from this premium
    - IV > RV most of the time
    - Short premium strategies have edge

    ## Volatility Trading Strategies

    ### 1. Long Volatility Trades:

    **Long Straddle:**
    - Buy ATM call + ATM put
    - Profit from big move either direction
    - Best: Low IV, expecting volatility spike
    - Risk: Time decay, volatility contraction

    **Long Strangle:**
    - Buy OTM call + OTM put
    - Cheaper than straddle
    - Need bigger move to profit
    - Best: Low IV, expecting major event

    **Calendar Spread (Long Volatility):**
    - Sell near-term option, buy far-term option
    - Profit if IV increases in far-term
    - Best: Normal term structure, neutral direction

    ### 2. Short Volatility Trades:

    **Short Straddle:**
    - Sell ATM call + ATM put
    - Profit from range-bound price action
    - Best: High IV, expecting contraction
    - Risk: Unlimited, requires risk management

    **Iron Condor:**
    - Sell OTM call spread + OTM put spread
    - Defined risk, profit from range
    - Best: High IV, expecting range-bound
    - Risk: Defined loss if price breaks range

    **Short Strangle:**
    - Sell OTM call + OTM put
    - Wider breakeven than straddle
    - Higher probability, lower premium
    - Best: High IV, stable market

    ### 3. Volatility Arbitrage:

    **Calendar Spread Arbitrage:**
    - Exploit term structure inefficiencies
    - Profit from IV differential between expirations

    **Skew Trading:**
    - Buy cheaper strikes (low IV)
    - Sell expensive strikes (high IV)
    - Profit from skew normalization

    ## Advanced IV Analysis Tools

    ### 1. IV vs. HV Spread:
    - Compare IV to 20-day, 30-day Historical Volatility
    - IV > HV by 5+ points = overpriced options
    - IV < HV by 5+ points = underpriced options

    ### 2. IV Percentile:
    - What % of time IV was lower over past year
    - 80th percentile = IV higher than 80% of days
    - Better than IV Rank for extreme values

    ### 3. ATM IV vs. Wing IV:
    - Compare ATM option IV to OTM wings
    - Steep difference = opportunity to sell wings
    - Flat difference = balanced risk

    ## Key Takeaways

    1. **Trade volatility, not just direction** - Profitable in all markets
    2. **Use IV Rank religiously** - Buy low IV, sell high IV
    3. **Understand skew** - Different strikes have different IV
    4. **Monitor term structure** - Exploit calendar opportunities
    5. **Volatility mean reverts** - High IV falls, low IV rises
    6. **VIX is your friend** - Key indicator for volatility trades
    7. **IV overstates RV** - Selling premium has statistical edge
    8. **Match strategy to IV environment** - Right tool for right time

    ---

    ### Practice Questions
    Test your understanding with 5 questions on volatility trading and IV analysis.
  MARKDOWN
}

quiz_volatility_trading = {
  title: 'Volatility Trading & IV Analysis Quiz',
  description: 'Test your understanding of volatility trading, IV analysis, skew, and term structure.',
  time_limit: 12,
  passing_score: 60
}

questions_volatility_trading = [
  {
    text: 'A stock has IV Rank of 15%. What strategy is most appropriate?',
    options: {
      'A' => 'Sell iron condors to collect premium',
      'B' => 'Buy straddles or strangles (long volatility)',
      'C' => 'Sell naked options aggressively',
      'D' => 'Avoid trading options entirely'
    },
    explanation: 'IV Rank of 15% indicates very low implied volatility relative to the past year. This is typically when options are cheap and good opportunities to buy options (long volatility strategies) exist.',
    difficulty: 1.0,
    level: 'medium',
    topic: 'iv-rank-application',
    section_anchor: 'iv-rank-application'
  },
  {
    text: 'What is "negative skew" in options?',
    options: {
      'A' => 'When near-term IV is higher than far-term IV',
      'B' => 'When OTM puts have higher IV than OTM calls',
      'C' => 'When all options have negative Vega',
      'D' => 'When the VIX is declining'
    },
    explanation: 'Negative skew (also called equity skew) occurs when out-of-the-money puts have higher implied volatility than out-of-the-money calls, reflecting the market\'s higher demand for downside protection.',
    difficulty: 1.1,
    level: 'medium',
    topic: 'volatility-skew',
    section_anchor: 'volatility-skew'
  },
  {
    text: 'A stock shows the following IV term structure: 7-day IV = 55%, 30-day IV = 30%, 60-day IV = 25%. What is this called and what might cause it?',
    options: {
      'A' => 'Normal term structure; typical market conditions',
      'B' => 'Inverted term structure; likely an upcoming earnings announcement',
      'C' => 'Flat term structure; balanced market sentiment',
      'D' => 'Skewed term structure; market manipulation'
    },
    explanation: 'This is inverted term structure (near-term IV > far-term IV). It typically occurs before major events like earnings announcements where near-term uncertainty is extremely high, causing short-dated options to be expensive.',
    difficulty: 1.6,
    level: 'hard',
    topic: 'term-structure',
    section_anchor: 'volatility-term-structure'
  },
  {
    text: 'The VIX index is at 38. What does this suggest for options strategies?',
    options: {
      'A' => 'Buy straddles; options are cheap',
      'B' => 'Sell premium; options are expensive and IV likely to decline',
      'C' => 'Avoid options trading; too risky',
      'D' => 'VIX level is irrelevant to strategy selection'
    },
    explanation: 'VIX at 38 indicates elevated fear and high implied volatility. This is typically an excellent time to sell premium (iron condors, credit spreads) as IV tends to revert lower from these elevated levels.',
    difficulty: 1.2,
    level: 'medium',
    topic: 'vix-interpretation',
    section_anchor: 'vix-volatility-index'
  },
  {
    text: 'Over time, what is the typical relationship between Implied Volatility (IV) and Realized Volatility (RV)?',
    options: {
      'A' => 'IV typically understates RV',
      'B' => 'IV typically overstates RV (volatility risk premium)',
      'C' => 'IV and RV are always equal',
      'D' => 'No consistent relationship exists'
    },
    explanation: 'IV typically overstates RV - this is called the volatility risk premium. Market participants pay a premium for protection, meaning option sellers on average profit from this overpricing of volatility.',
    difficulty: 1.3,
    level: 'medium',
    topic: 'volatility-risk-premium',
    section_anchor: 'realized-vs-implied-volatility'
  }
]

create_lesson_quiz_pair(module_risk, lesson_volatility_trading, quiz_volatility_trading, questions_volatility_trading, 3)

# -----------------------------------------------------------------------------
# Lesson 4.4: Advanced Trade Adjustments
# -----------------------------------------------------------------------------
lesson_trade_adjustments = {
  slug: 'advanced-trade-adjustments',
  title: 'Advanced Trade Adjustments',
  reading_time: 15,
  key_concepts: ['trade-adjustments', 'rolling-options', 'trade-repair', 'position-management'],
  content: <<~MARKDOWN
    # Advanced Trade Adjustments

    ## Why Adjust Trades?

    **Trade adjustments** are modifications to existing positions to:
    - Reduce risk exposure
    - Extend profitability
    - Repair losing positions
    - Lock in gains
    - Adapt to changing market conditions

    ### Key Principle:
    **Successful trading isn't just about entries—it's about managing positions.**

    ## Rolling Options

    **Rolling** means closing an existing option and opening a new one, typically to extend time or adjust strike.

    ### Types of Rolls:

    **1. Roll Out (Time Roll):**
    - Close current expiration
    - Open later expiration
    - Same strike price
    - Extends time for thesis to work

    **Example:**
    - Short $50 put expiring in 7 days
    - Stock at $48, position losing
    - **Roll:** Close 7-day put, sell 45-day $50 put
    - Collect more premium, give trade more time

    **2. Roll Up:**
    - Close current strike
    - Open higher strike (calls) or higher strike (puts)
    - Adjusts to stock price movement

    **Example:**
    - Short $100 put, stock rallied to $110
    - **Roll:** Close $100 put, sell $105 put
    - Follow the stock higher, collect more premium

    **3. Roll Down:**
    - Close current strike
    - Open lower strike
    - Typically for puts when stock falls

    **Example:**
    - Short $50 call, stock dropped to $45
    - **Roll:** Close $50 call, sell $45 call
    - Follow stock lower, stay in profitable range

    **4. Roll Out and Up/Down:**
    - Combine time and strike adjustments
    - Most common adjustment
    - Adapt to both time decay and price movement

    ### When to Roll:

    **For Credit Spreads:**
    - Roll when approaching max loss (150-200% of credit)
    - Roll to avoid assignment
    - Roll to extend duration in winning trade

    **For Covered Calls:**
    - Roll up when stock rallies past strike
    - Roll out to collect more premium
    - Roll down if stock drops significantly

    **For Cash-Secured Puts:**
    - Roll out if stock drops below strike near expiration
    - Roll down if bullish but need lower entry
    - Roll out and down for best credit

    ## Adjusting Vertical Spreads

    ### Bull Call Spread Adjustments:

    **Scenario 1: Stock Stalls Below Profit Zone**
    - Original: $50/$55 bull call spread, stock at $52
    - Not profitable enough, expiring soon
    - **Adjustment:** Roll entire spread out in time
    - New: $50/$55 bull call spread, 45 days out

    **Scenario 2: Stock Drops Significantly**
    - Original: $50/$55 bull call spread, stock at $45
    - Position near max loss
    - **Adjustment:** Close spread, open $45/$50 bull call spread further out
    - Lower strikes, more time, convert to breakeven

    **Scenario 3: Stock Rallies Past Spread**
    - Original: $50/$55 bull call spread, stock at $58
    - At max profit, want to extend
    - **Adjustment:** Close current spread, open $55/$60 spread
    - Follow stock higher, capture more upside

    ### Bear Put Spread Adjustments:

    **Scenario: Stock Rallies Against Position**
    - Original: $50/$45 bear put spread, stock at $53
    - Losing money, want to reduce loss
    - **Adjustment:** Roll down to $55/$50 bear put spread
    - Higher strikes match new stock price
    - Collect credit to offset loss

    ## Adjusting Iron Condors

    **Iron Condors** are complex but commonly need adjustments.

    ### Adjustment Strategy 1: Roll Tested Side

    **Scenario: Stock Breaks Above Call Side**
    - Original Iron Condor: $95/$100 put spread, $110/$115 call spread
    - Stock rallies to $113 (testing call side)
    - **Adjustment:**
      - Close $110/$115 call spread (take loss)
      - Open $115/$120 call spread (further OTM)
      - Keep put side as is
    - Result: Inverted call side, reduce loss potential

    ### Adjustment Strategy 2: Convert to Straddle

    **Scenario: Stock Stays Within Range**
    - Iron Condor near expiration, profitable
    - Want to continue collecting
    - **Adjustment:**
      - Close entire condor
      - Sell ATM straddle or strangle in next expiration
      - Keep collecting Theta

    ### Adjustment Strategy 3: Add Width

    **Scenario: Narrow Condor Under Pressure**
    - Original: Narrow iron condor, stock moving
    - **Adjustment:**
      - Add wider iron condor at later expiration
      - Creates diagonal spread with more breathing room

    ## Repairing Losing Trades

    ### Repair Strategy 1: Averaging Down (Careful!)

    **Long Stock + Covered Call Repair:**
    - Own 100 shares at $100, now at $90 (down $1,000)
    - **Repair:** Sell 2x $95 calls (collect $400)
    - If stock recovers to $95, profit = $400 (call premium) + $500 (stock) = $900
    - Reduces loss significantly

    **Risk:** Stock could rally past $95, capping gains

    ### Repair Strategy 2: Ratio Spread

    **Failed Bull Call Spread:**
    - Original: $50/$55 call spread, paid $2 ($200)
    - Stock at $48, spread worth $0.50 ($50), down $150
    - **Repair:** Buy 1 more $50 call for $1 ($100)
    - New position: Long 2x $50 calls, short 1x $55 call
    - Breakeven if stock reaches $52.50
    - Turned losing spread into ratio spread with upside

    ### Repair Strategy 3: Extend Time

    **Simple but Effective:**
    - Position losing due to time decay
    - Close current position (accept small loss)
    - Reopen same structure with 60-90 days
    - More time for thesis to play out

    ## Managing Winners

    ### Taking Profits Early

    **For Credit Spreads:**
    - Close at 50-70% of max profit
    - Example: Collected $100 credit, max profit $100
    - Close when can buy back for $30-50
    - Frees capital, reduces risk, high win rate

    **Why This Works:**
    - Last 30-50% profit takes longest time
    - Highest risk period (Gamma increases near expiration)
    - Better to redeploy capital to new trades

    ### Scaling Out

    **Multi-Contract Positions:**
    - Close partial position at profit targets
    - Let remainder run for bigger gains

    **Example:**
    - Sold 5 iron condors
    - Close 3 at 60% profit (lock gains)
    - Let 2 run to 80-100% (maximize if continues)
    - Balanced approach, reduces risk while keeping upside

    ## Adjustment Decision Framework

    ### Questions to Ask Before Adjusting:

    1. **Is thesis still valid?**
       - Yes → Adjust to give more time/room
       - No → Close, accept loss, move on

    2. **Will adjustment improve risk/reward?**
       - Calculate new breakeven
       - Compare to current position
       - Only adjust if meaningfully better

    3. **Am I throwing good money after bad?**
       - Be honest about position
       - Sometimes best "adjustment" is closing
       - Don't add risk to failing trade

    4. **What are transaction costs?**
       - Multiple adjustments add commissions
       - Wide bid-ask spreads reduce profits
       - Sometimes cheaper to close and reopen fresh

    5. **Is adjustment mechanical or emotional?**
       - Follow plan, not fear
       - Don't adjust to avoid realizing loss
       - Accept losses when thesis broken

    ## Advanced Adjustment Techniques

    ### 1. Partial Rolls:
    - Roll 50% of position
    - Keep 50% at original strike/expiration
    - Balances conviction with risk management

    ### 2. Butterfly Additions:
    - Position under pressure
    - Add butterfly centered at problem area
    - Adds premium, creates neutral zone

    ### 3. Calendar Spread Conversion:
    - Losing vertical spread
    - Close short leg, keep long leg
    - Sell new short leg in different expiration
    - Creates calendar spread with positive Vega

    ### 4. Delta Hedging:
    - Positive Delta position losing from stock drop
    - Don't close position, hedge with short stock or puts
    - Neutralizes Delta, isolates other Greeks
    - Gives more time for recovery

    ## Common Adjustment Mistakes

    ### Mistake 1: Over-Adjusting
    - Adjusting every small movement
    - Death by a thousand cuts (commissions)
    - Let positions breathe

    ### Mistake 2: Adjusting Too Late
    - Wait until max loss
    - No good options remaining
    - Adjust early when more choices available

    ### Mistake 3: Adjusting Without Plan
    - Reactive vs. proactive
    - Should have adjustment rules BEFORE entering
    - "If stock hits X, I will do Y"

    ### Mistake 4: Rolling for Credit Without Improving Position
    - "I collected $0.50 credit so it's good"
    - But moved further OTM, more risk
    - Credit alone doesn't make adjustment good

    ### Mistake 5: Not Tracking Cumulative P&L
    - Adjust 5 times, "each adjustment profitable"
    - Total P&L on original trade still negative
    - Track total trade P&L, not just adjustment

    ## Key Takeaways

    1. **Plan adjustments before entering** - Know what you'll do if X happens
    2. **Roll early, not late** - More options when position not dire
    3. **Take profits at 50-70%** - Don't be greedy, redeploy capital
    4. **Question every adjustment** - Improving position or avoiding loss?
    5. **Thesis still valid?** - If not, close, don't adjust
    6. **Track total P&L** - Not just individual adjustment credits
    7. **Sometimes best adjustment is close** - Accept loss, move on
    8. **Transaction costs matter** - Don't adjust excessively

    ---

    ### Practice Questions
    Test your understanding with 5 questions on advanced trade adjustments and rolling strategies.
  MARKDOWN
}

quiz_trade_adjustments = {
  title: 'Advanced Trade Adjustments Quiz',
  description: 'Test your understanding of trade adjustments, rolling options, and position management techniques.',
  time_limit: 12,
  passing_score: 60
}

questions_trade_adjustments = [
  {
    text: 'A trader sold a $50 cash-secured put expiring in 5 days. The stock dropped to $47 and the put is now losing money. What is the most common adjustment?',
    options: {
      'A' => 'Close the position immediately for a loss',
      'B' => 'Roll out (extend expiration) to collect more premium and give more time',
      'C' => 'Do nothing and accept assignment',
      'D' => 'Buy a call to hedge the position'
    },
    explanation: 'Rolling out (extending expiration) is the most common adjustment for losing short puts. This collects additional premium and gives more time for the stock to recover above the strike, potentially avoiding assignment.',
    difficulty: 1.0,
    level: 'medium',
    topic: 'rolling-basics',
    section_anchor: 'rolling-options'
  },
  {
    text: 'What does "rolling up" mean for a covered call position?',
    options: {
      'A' => 'Extending the expiration to a later date',
      'B' => 'Closing the current call and selling a call at a higher strike',
      'C' => 'Buying back shares at a higher price',
      'D' => 'Selling additional calls at the same strike'
    },
    explanation: 'Rolling up means closing the current call and selling a new call at a higher strike price. This is typically done when the stock has rallied past the original strike, allowing the trader to capture more upside while still collecting premium.',
    difficulty: 0.8,
    level: 'easy',
    topic: 'rolling-covered-calls',
    section_anchor: 'rolling-options'
  },
  {
    text: 'For credit spreads, at what profit percentage is it generally recommended to close the position and take profits?',
    options: {
      'A' => '25-30% of max profit',
      'B' => '50-70% of max profit',
      'C' => '90-100% of max profit',
      'D' => 'Never close early; always hold to expiration'
    },
    explanation: 'Closing credit spreads at 50-70% of max profit is recommended because the last 30-50% takes the longest time and carries the highest risk (Gamma increases near expiration). This allows capital redeployment and maintains a high win rate.',
    difficulty: 1.1,
    level: 'medium',
    topic: 'taking-profits',
    section_anchor: 'managing-winners'
  },
  {
    text: 'An iron condor has been tested on the call side as the stock rallied. What is one effective adjustment strategy?',
    options: {
      'A' => 'Close the entire iron condor immediately',
      'B' => 'Close the call side spread and open a new call spread further out-of-the-money',
      'C' => 'Double down by selling more call spreads at the current strikes',
      'D' => 'Remove the put side and hope the stock drops'
    },
    explanation: 'Rolling the tested call side by closing it and opening a new call spread further OTM is a common adjustment. This inverts that side of the iron condor, giving more room for the stock to move while reducing potential loss.',
    difficulty: 1.4,
    level: 'hard',
    topic: 'iron-condor-adjustments',
    section_anchor: 'adjusting-iron-condors'
  },
  {
    text: 'What is the most important question to ask before making any trade adjustment?',
    options: {
      'A' => 'How much credit can I collect from the adjustment?',
      'B' => 'Is my original thesis still valid?',
      'C' => 'What will other traders think of this adjustment?',
      'D' => 'Can I avoid realizing a loss?'
    },
    explanation: 'The most critical question is whether your original thesis is still valid. If the reason you entered the trade no longer applies, the best "adjustment" is often to close the position and move on, rather than throwing good money after bad.',
    difficulty: 1.2,
    level: 'medium',
    topic: 'adjustment-framework',
    section_anchor: 'adjustment-decision-framework'
  }
]

create_lesson_quiz_pair(module_risk, lesson_trade_adjustments, quiz_trade_adjustments, questions_trade_adjustments, 4)

puts "✅ Module 4 Risk Management lessons created successfully"

puts ""
puts "=" * 80
puts "🎉 OPTIONS TRADING COURSE - COMPLETE! 🎉"
puts "=" * 80
puts ""
puts "✅ Module 1: Options Basics (4 lessons, 20 questions) - COMPLETE"
puts "   1.1 Introduction to Options"
puts "   1.2 Understanding Call Options"
puts "   1.3 Understanding Put Options"
puts "   1.4 Options Pricing Basics"
puts ""
puts "✅ Module 2: Options Strategies (4 lessons, 20 questions) - COMPLETE"
puts "   2.1 Covered Calls & Cash-Secured Puts"
puts "   2.2 Vertical Spreads (Bull/Bear Call/Put Spreads)"
puts "   2.3 Iron Condors & Butterflies"
puts "   2.4 Straddles, Strangles & Calendar Spreads"
puts ""
puts "✅ Module 3: The Greeks (4 lessons, 20 questions) - COMPLETE"
puts "   3.1 Delta & Position Delta ✓"
puts "   3.2 Gamma & Curvature ✓"
puts "   3.3 Theta & Time Decay Management ✓"
puts "   3.4 Vega & Volatility Sensitivity ✓"
puts ""
puts "✅ Module 4: Risk Management (4 lessons, 20 questions) - COMPLETE"
puts "   4.1 Position Sizing & Risk Management ✓"
puts "   4.2 Portfolio Greeks & Hedging ✓"
puts "   4.3 Volatility Trading & IV Analysis ✓"
puts "   4.4 Advanced Trade Adjustments ✓"
puts ""
puts "=" * 80
puts "FINAL STATUS: 16 Lessons | 80 Questions | ~50 hours content"
puts "=" * 80
puts ""
puts "📚 Complete Course Content:"
puts ""
puts "  MODULE 1 - OPTIONS BASICS:"
puts "    ✓ Options fundamentals and terminology"
puts "    ✓ Call options mechanics and strategies"
puts "    ✓ Put options mechanics and strategies"
puts "    ✓ Pricing models and factors"
puts ""
puts "  MODULE 2 - OPTIONS STRATEGIES:"
puts "    ✓ Income strategies (covered calls, cash-secured puts)"
puts "    ✓ Vertical spreads for all market conditions"
puts "    ✓ Advanced neutral strategies (iron condors, butterflies)"
puts "    ✓ Volatility strategies (straddles, strangles, calendars)"
puts ""
puts "  MODULE 3 - THE GREEKS:"
puts "    ✓ Delta & directional exposure"
puts "    ✓ Gamma & option curvature"
puts "    ✓ Theta & time decay management"
puts "    ✓ Vega & volatility sensitivity"
puts ""
puts "  MODULE 4 - RISK MANAGEMENT:"
puts "    ✓ Position sizing & portfolio allocation"
puts "    ✓ Portfolio Greeks & hedging strategies"
puts "    ✓ Volatility trading & IV analysis"
puts "    ✓ Advanced trade adjustments & rolling"
puts ""
puts "🎯 Learning Outcomes:"
puts "  ✓ Master all four major Greek sensitivities"
puts "  ✓ Execute 12+ options trading strategies"
puts "  ✓ Implement professional risk management"
puts "  ✓ Analyze and trade volatility"
puts "  ✓ Adjust and manage positions dynamically"
puts "  ✓ Build and hedge options portfolios"
puts ""
puts "📊 Practice & Assessment:"
puts "  ✓ 80 comprehensive practice questions"
puts "  ✓ Question-to-lesson mappings for targeted learning"
puts "  ✓ Detailed explanations for all answers"
puts "  ✓ Progressive difficulty levels (easy/medium/hard)"
puts "  ✓ Real-world scenarios and calculations"
puts ""
puts "Seed Command: rails db:seed:finance:options_trading"
puts "=" * 80
