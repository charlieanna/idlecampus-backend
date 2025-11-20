class Challenge < ApplicationRecord
  has_many :submissions, dependent: :destroy
  has_and_belongs_to_many :tags
  serialize :tag_ids, Array

  def tags
    Tag.where(id: tag_ids)
  end

  
  def score
    # Calculate the average score of all submissions for this challenge
    if submissions.count > 0
      total_score = submissions.sum(:score)
      average_score = total_score / submissions.count
      return average_score
    else
      return 0
    end
  end
end
