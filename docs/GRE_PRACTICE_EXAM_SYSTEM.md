# GRE Practice Exam System Documentation

## Overview

The GRE Practice Exam System provides a complete solution for GRE Verbal Reasoning preparation, including full-length timed practice exams, scaled scoring (130-170), detailed weakness detection, and personalized study recommendations.

---

## Features

### 1. Full-Length Practice Exams
- **Duration**: 70 minutes (2 sections × 35 minutes)
- **Questions**: 40 questions total
- **Distribution**:
  - Reading Comprehension: 20 questions (50%)
  - Text Completion: 12 questions (30%)
  - Sentence Equivalence: 8 questions (20%)
- **Scoring**: Scaled to GRE 130-170 range
- **Auto-submission**: Automatically submits when time expires

### 2. Scaled Scoring (130-170)
- Converts percentage correct to GRE scaled score
- Based on Item Response Theory (IRT)
- Accounts for question difficulty
- Percentile estimates included
- Score interpretation provided

### 3. Weakness Detection
- **By Question Type**: Accuracy for Reading Comp, Text Completion, Sentence Equivalence
- **By Difficulty Level**: Performance on easy, medium, and hard questions
- **Time Management**: Average time per question, timeout rate
- **Severity Scores**: 0-1 scale indicating urgency of improvement needed

### 4. Personalized Recommendations
- Specific action items for each weak area
- Estimated practice needed (questions, hours, days)
- Priority topics ranked by severity
- Type-specific strategies

### 5. Study Plans
- Target score-based planning
- Week-by-week breakdown
- Daily practice tasks
- Milestone tracking
- Time estimates

### 6. Analytics Dashboard
- Score history and trends
- Performance by question type
- Skill dimension tracking
- Readiness assessment
- Practice recommendations

---

## Getting Started

### For Users

#### 1. Take a Practice Exam
```
Navigate to: /exam_simulations
Click: "Start GRE Verbal Reasoning Practice Test"
Complete: 40 questions in 70 minutes
```

#### 2. View Results
After submission, you'll see:
- **Scaled Score**: 130-170 range
- **Percentile**: Your ranking vs. all test-takers
- **Interpretation**: "Excellent" to "Needs Improvement"
- **Passing Status**: Whether you met the 150 score threshold

#### 3. Analyze Weaknesses
```
Navigate to: /gre_analytics/dashboard
```

You'll see:
- Overall verbal ability score
- Performance by question type
- Specific recommendations
- Study plan suggestions

#### 4. Get Personalized Study Plan
```
Navigate to: /gre_analytics/study_plan
Select: Target score (e.g., 160)
Select: Timeframe (e.g., 8 weeks)
Generate: Week-by-week plan
```

---

## For Developers

### Architecture

#### Models
- **ExamSimulation**: Stores practice exam attempts
  - Supports 'gre' certification type
  - Stores scaled scores (not percentages)
- **UserSkillDimension**: Tracks ability in 7 GRE dimensions
  - `gre_reading_comprehension`
  - `gre_text_completion`
  - `gre_sentence_equivalence`
  - `gre_quantitative_arithmetic` (future)
  - `gre_quantitative_algebra` (future)
  - `gre_quantitative_geometry` (future)
  - `gre_quantitative_data_analysis` (future)

#### Services
1. **GREScoreScalingService** (`app/services/gre_score_scaling_service.rb`)
   - Converts IRT ability (-3 to +3) to GRE score (130-170)
   - Converts percentage to GRE score
   - Provides percentile estimates
   - Score interpretation
   - Gap analysis for score improvement

2. **GREWeaknessDetectionService** (`app/services/gre_weakness_detection_service.rb`)
   - Analyzes performance by question type
   - Analyzes performance by difficulty
   - Tracks time management
   - Generates recommendations
   - Creates personalized study plans

#### Controllers
1. **ExamSimulationsController**
   - Extended to support GRE exams
   - Question selection based on GRE blueprint
   - Scaled scoring calculation

2. **GREAnalyticsController** (`app/controllers/gre_analytics_controller.rb`)
   - Dashboard view
   - Weakness analysis
   - Study plan generation
   - Score calculator
   - API endpoints for analytics data

---

## API Endpoints

### Practice Exams
```
GET  /exam_simulations              # List all exams
POST /exam_simulations/begin_exam   # Start new GRE exam (certification_type=gre)
GET  /exam_simulations/:id          # Take exam (timed)
POST /exam_simulations/:id/submit   # Submit answers
GET  /exam_simulations/:id/result   # View results
```

### Analytics
```
GET /gre_analytics/dashboard               # Main dashboard
GET /gre_analytics/weakness_analysis       # Detailed weaknesses
GET /gre_analytics/study_plan              # Generate study plan
GET /gre_analytics/score_calculator        # Score gap analysis
GET /gre_analytics/question_type_analysis  # JSON: Performance by type
GET /gre_analytics/difficulty_analysis     # JSON: Performance by difficulty
GET /gre_analytics/time_management         # JSON: Time stats
GET /gre_analytics/skill_progress          # JSON: Skill dimension progress
GET /gre_analytics/readiness_assessment    # JSON: Overall readiness
GET /gre_analytics/practice_recommendations # JSON: What to practice
```

---

## Score Scaling Algorithm

### IRT to GRE Conversion
```ruby
# IRT ability range: -2.5 to +2.5 (logits)
# GRE score range: 130 to 170

gre_score = 130 + ((ability - (-2.5)) / 5.0) * 40

# Examples:
# ability = -2.5 → score = 130
# ability = 0.0   → score = 150
# ability = +2.5  → score = 170
```

### Percentage to GRE Conversion
```ruby
# Convert percentage (0-100) to approximate ability
if percentage >= 50
  ability = ((percentage - 50) / 50.0) * 2.5
else
  ability = ((percentage - 50) / 50.0) * 2.5
end

# Then convert ability to GRE score (above formula)

# Examples:
# 50% correct → ability ≈ 0.0  → score ≈ 150
# 75% correct → ability ≈ 1.25 → score ≈ 160
# 90% correct → ability ≈ 2.0  → score ≈ 166
```

---

## Weakness Detection Algorithm

### Severity Calculation
```ruby
severity = case accuracy
  when 0...40  then 1.0  # Critical
  when 40...55 then 0.8  # High
  when 55...70 then 0.6  # Medium
  when 70...80 then 0.4  # Low
  else 0.2               # Minor
end
```

### Practice Needed Estimation
```ruby
gap = target_accuracy - current_accuracy
questions_needed = gap * 5  # 5 questions per 1% improvement
hours = questions_needed / 10.0  # 10 questions per hour
days = questions_needed / 20.0   # 20 questions per day
```

---

## Study Plan Generation

### Time Allocation
```ruby
hours_per_week = case score_gap
  when 0..5    then 5   # Light practice
  when 6..10   then 10  # Moderate practice
  when 11..15  then 15  # Intensive practice
  else 20               # Very intensive practice
end
```

### Weekly Breakdown
- Weeks 1-4: Content mastery (60% lessons, 40% practice)
- Weeks 5-8: Practice & review (40% lessons, 60% practice)
- Practice test every 2 weeks

### Priority Order
1. Areas with accuracy < 40% (Critical)
2. Areas with accuracy 40-70% (High/Medium)
3. Areas with accuracy 70-85% (Low)
4. Areas with accuracy > 85% (Maintenance)

---

## Configuration

### Exam Settings
```ruby
# config/initializers/gre_config.rb (create if needed)

GRE_CONFIG = {
  verbal: {
    duration_minutes: 70,
    total_questions: 40,
    passing_score: 150,
    distribution: {
      reading_comprehension: 0.50,  # 50%
      text_completion: 0.30,         # 30%
      sentence_equivalence: 0.20     # 20%
    }
  },
  quantitative: {
    duration_minutes: 70,
    total_questions: 40,
    passing_score: 150
  }
}
```

### Score Interpretation Thresholds
```ruby
160-170: Excellent (Top 13%)
155-159: Very Good (Top 30%)
150-154: Good (Around 50th percentile)
145-149: Fair (Below average)
140-144: Below Average
< 140:   Needs Improvement
```

---

## Database Schema

### exam_simulations
```sql
- id: integer
- user_id: integer
- certification_type: string  # 'gre' for GRE exams
- status: string  # 'in_progress', 'completed', 'expired'
- question_ids: text (JSON array)
- answers: text (JSON hash)
- correct_answers: text (JSON hash)
- score: decimal  # 130-170 for GRE, percentage for others
- correct_count: integer
- total_questions: integer
- time_limit: integer  # minutes
- started_at: datetime
- submitted_at: datetime
- time_taken: integer  # seconds
- passed: boolean
```

### user_skill_dimensions
```sql
- id: integer
- user_id: integer
- dimension: string  # e.g., 'gre_reading_comprehension'
- ability_estimate: decimal  # IRT ability (-3 to +3)
- standard_error: decimal
- confidence_lower: decimal
- confidence_upper: decimal
- n_observations: integer
- last_updated_at: datetime
```

---

## Future Enhancements

### Phase 1: Current Implementation ✅
- [x] GRE Verbal Reasoning course (65 questions)
- [x] Full-length practice exams
- [x] Scaled scoring (130-170)
- [x] Weakness detection
- [x] Study plan generation
- [x] Analytics dashboard

### Phase 2: Quantitative Reasoning (Planned)
- [ ] GRE Quantitative course content (200+ questions)
- [ ] Arithmetic, Algebra, Geometry, Data Analysis modules
- [ ] Quantitative practice exams
- [ ] Combined Verbal + Quantitative full exams

### Phase 3: Adaptive Testing (Planned)
- [ ] Adaptive section routing (GRE-style)
- [ ] Section 1 performance determines Section 2 difficulty
- [ ] More accurate ability estimation

### Phase 4: Analytical Writing (Planned)
- [ ] Essay prompts database
- [ ] Rubric-based scoring
- [ ] Automated feedback
- [ ] Sample essay repository

### Phase 5: Advanced Analytics (Planned)
- [ ] Predictive analytics (likelihood of reaching target score)
- [ ] Comparison with other users
- [ ] AI-powered recommendations
- [ ] Mobile app support

---

## Troubleshooting

### Issue: GRE exam not showing in exam list
**Solution**: Run seeds to ensure GRE course and skill dimensions are set up:
```bash
rails db:seed
```

### Issue: Score showing as percentage instead of 130-170
**Solution**: Ensure the certification_type is 'gre' (not 'GRE' or other variant)

### Issue: No weakness analysis data
**Solution**: Complete at least one practice exam first. Weakness detection requires performance data.

### Issue: Questions not assigned to skill dimensions
**Solution**: Run the GRE skill dimensions setup seed:
```bash
rails runner "load 'db/seeds/gre_skill_dimensions_setup.rb'"
```

---

## Support

For issues or questions:
1. Check this documentation
2. Review code comments in service files
3. Check database for data integrity
4. Review Rails logs for errors

---

## Credits

**GRE Practice Exam System** developed for Idle Campus
- **Score Scaling**: Based on Item Response Theory (IRT) principles
- **Content**: 65 original GRE Verbal Reasoning questions
- **Algorithms**: Weakness detection, spaced repetition, adaptive practice

**Version**: 1.0
**Last Updated**: November 2025
