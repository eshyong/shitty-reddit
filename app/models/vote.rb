# Represents a vote cast by a user. Can apply to posts or comments.
class Vote < ApplicationRecord
  belongs_to :voteable, polymorphic: true
  attribute :upvoted, :boolean, default: false
  attribute :downvoted, :boolean, default: false

  def up
    self.upvoted = self.upvoted ? false : true
    self.downvoted = false
  end

  def down
    self.downvoted = self.downvoted ? false : true
    self.upvoted = false
  end
end
