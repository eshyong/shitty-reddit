require "test_helper"

class CommentsTreeTest < ActiveSupport::TestCase
  test "CommentsTree#build" do
    comments = [
      # Each has downvotes: 0
      Comment.new(id: 1, parent_id: nil, upvotes: 10),
      Comment.new(id: 2, parent_id: 1, upvotes: 3),
      Comment.new(id: 3, parent_id: 1, upvotes: 7),  # should be ordered before #2
      Comment.new(id: 4, parent_id: 3, upvotes: 0),
      Comment.new(id: 5, parent_id: nil, upvotes: 15),  # should be ordered before #1
      Comment.new(id: 6, parent_id: 5, upvotes: 0),
    ]
    builder = CommentsTreeBuilder.new(comments)
    tree = builder.build
    flattened = tree.flatten.map { |node| node.comment.id }
    assert flattened == [5, 6, 1, 3, 4, 2]
  end
end
