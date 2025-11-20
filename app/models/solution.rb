class Solution < ApplicationRecord
  # Associations
  # belongs_to :user
  belongs_to :problem

  # Validations
  # validates :code, presence: true
  # validates :status, presence: true
  # validates :execution_result, presence: true

  # You can add custom methods here to handle code execution, 
  # result processing, etc.
end
