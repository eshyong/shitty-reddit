class Comment < ApplicationRecord
  belongs_to :post
  validates :user, presence: true
  validates :body, presence: true
  attribute :upvotes, default: 0
  attribute :downvotes, default: 0
end
