# frozen_string_literal: true

# Service for managing user skills and skill trees
class ProgressiveSkillService
  class << self
    # Award skill XP to a user
    def award_skill_xp(user, skill_slug, xp_amount, source_metadata = {})
      skill = ProgressiveSkill.find_by!(slug: skill_slug)
      
      user_skill = ProgressiveUserSkill.find_or_initialize_by(
        user: user,
        skill: skill
      )

      old_level = user_skill.level

      user_skill.xp += xp_amount
      user_skill.level = calculate_skill_level(user_skill.xp)
      user_skill.last_practiced_at = Time.current
      user_skill.save!

      # Check for skill level up
      if user_skill.level > old_level
        handle_skill_level_up(user, skill, old_level, user_skill.level)
      end

      user_skill
    end

    # Calculate skills earned from a challenge
    def award_skills_for_challenge(user, challenge, level_number)
      return [] if challenge.skill_tags.blank?

      xp_per_skill = 10 + (level_number * 5) # More XP for higher levels

      challenge.skill_tags.map do |skill_slug|
        award_skill_xp(user, skill_slug, xp_per_skill, {
          challenge_id: challenge.id,
          level_number: level_number
        })
      end
    end

    # Get skill tree data for a user
    def get_skill_tree(user)
      all_skills = ProgressiveSkill.all.order(:category, :name)
      user_skills = user.progressive_user_skills.index_by(&:skill_id)

      all_skills.map do |skill|
        user_skill = user_skills[skill.id]
        
        {
          id: skill.id,
          name: skill.name,
          slug: skill.slug,
          category: skill.category,
          description: skill.description,
          icon: skill.icon,
          level: user_skill&.level || 0,
          xp: user_skill&.xp || 0,
          xp_for_next_level: xp_for_skill_level((user_skill&.level || 0) + 1),
          progress_percentage: calculate_skill_progress_percentage(user_skill),
          last_practiced: user_skill&.last_practiced_at,
          related_challenges: get_related_challenges(skill)
        }
      end
    end

    # Get user's top skills
    def get_top_skills(user, limit = 5)
      user.progressive_user_skills
          .includes(:skill)
          .order(level: :desc, xp: :desc)
          .limit(limit)
          .map do |user_skill|
        {
          name: user_skill.skill.name,
          slug: user_skill.skill.slug,
          level: user_skill.level,
          xp: user_skill.xp
        }
      end
    end

    private

    # Calculate skill level from XP
    def calculate_skill_level(xp)
      # Formula: level increases every 100 XP
      (xp / 100).floor + 1
    end

    # Calculate XP required for a skill level
    def xp_for_skill_level(level)
      (level - 1) * 100
    end

    # Calculate progress percentage within current skill level
    def calculate_skill_progress_percentage(user_skill)
      return 0 unless user_skill

      current_level_xp = xp_for_skill_level(user_skill.level)
      next_level_xp = xp_for_skill_level(user_skill.level + 1)
      
      xp_in_level = user_skill.xp - current_level_xp
      xp_needed = next_level_xp - current_level_xp

      (xp_in_level.to_f / xp_needed * 100).round(1)
    end

    # Handle skill level up
    def handle_skill_level_up(user, skill, old_level, new_level)
      ProgressiveNotification.create!(
        user: user,
        notification_type: 'skill_level_up',
        title: "Skill Level Up!",
        message: "Your #{skill.name} skill reached level #{new_level}",
        data: {
          skill_id: skill.id,
          skill_name: skill.name,
          old_level: old_level,
          new_level: new_level
        },
        read: false
      )
    end

    # Get challenges related to a skill
    def get_related_challenges(skill)
      ProgressiveChallenge
        .where("skill_tags @> ARRAY[?]::varchar[]", skill.slug)
        .limit(5)
        .pluck(:id, :title, :slug)
        .map { |id, title, slug| { id: id, title: title, slug: slug } }
    end
  end
end