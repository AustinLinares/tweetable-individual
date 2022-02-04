class Comment < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :tweet, counter_cache: true
  # Validations
  validates :body, presence: true, length: { maximum: 140 }
end
