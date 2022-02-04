class Comment < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :tweet, counter_cache: :comments_counter
  # Validations
  validates :body, presence: true, length: { maximum: 140 }
end
