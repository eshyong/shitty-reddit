# Represents a post on the website. Currently, that means a
# URL with comments, but images and text may be supported in the 
# future.
#
# Requires special upvote/downvote logic for canceling/replacing previous
# votes.
class Post < ApplicationRecord
  include Voteable

  has_many :comments
  has_many :votes, as: :voteable
  attribute :upvotes, default: 0
  attribute :downvotes, default: 0
end
