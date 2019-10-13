require "comments_tree"

class CommentsTreeBuilder
  def initialize(comments)
    @comments = comments
  end

  def build
    tree_hash = {}
    @comments.each do |comment|
      tree_hash[comment.parent_id] ||= []
      tree_hash[comment.parent_id] << comment
    end
    root = _build(tree_hash, nil, 0)
    root
  end

  private
  def _build(tree_hash, parent_comment, depth)
    root = CommentsTree.new(comment: parent_comment, depth: depth)
    parent_id = parent_comment.nil? ? nil : parent_comment.id
    children = tree_hash[parent_id]

    # base case: no children found
    return root if children.nil?

    # build node and its children recursively
    children_nodes = children.map do |child|
      _build(tree_hash, child, depth + 1)
    end
    # sort by score, high to low
    children_nodes = children_nodes.sort_by do |child|
      child.comment.upvotes - child.comment.downvotes
    end
    root.children = children_nodes.reverse

    root
  end
end
