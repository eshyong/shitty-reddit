# Represents a post on the website. Currently, that means a
# URL with comments, but images and text may be supported in the 
# future.
#
# Requires special upvote/downvote logic for canceling/replacing previous
# votes.
class Post < ApplicationRecord
  has_many :comments
  has_many :votes, as: :voteable
  attribute :upvotes, default: 0
  attribute :downvotes, default: 0

  def upvote(vote)
    if vote.downvoted
      # need to also remove previous downvote
      self.downvotes -= 1
      self.upvotes += 1
    elsif vote.upvoted
      # if previously upvoted, negate it
      self.upvotes -= 1
    else
      # fresh vote
      self.upvotes += 1
    end
  end

  def downvote(vote)
    if vote.upvoted
      # also need to remove previous upvote
      self.upvotes -= 1
      self.downvotes += 1
    elsif vote.downvoted
      # if previously downvoted, negate it
      self.downvotes -= 1
    else
      # fresh vote
      self.downvotes += 1
    end
  end

  def upvoted?(user_id)
    vote = find_user_vote(user_id)
    !vote.nil? && vote.upvoted
  end

  def downvoted?(user_id)
    vote = find_user_vote(user_id)
    !vote.nil? && vote.downvoted
  end

  private
  def find_user_vote(user_id)
    self.votes.find_by(user_id: user_id)
  end
end
