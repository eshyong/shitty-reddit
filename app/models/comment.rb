class Comment < ApplicationRecord
  include VoteableContent

  belongs_to :post
  has_many :votes, as: :voteable
  validates :user, presence: true
  validates :body, presence: true
  attribute :upvotes, default: 0
  attribute :downvotes, default: 0
end
