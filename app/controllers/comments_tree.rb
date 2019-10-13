class CommentsTree
  attr_accessor :comment
  attr_accessor :children
  attr_accessor :depth

  def initialize(comment: nil, children: [], depth: 0)
    @comment = comment
    @children = children
    @depth = depth
  end

  def flatten
    _flatten(self)
  end

  def inspect
    parent_string = "#{@comment.inspect}"
    children_strings = @children.map do |child|
      inspect = child.inspect
      inspect.rjust(inspect.length + child.depth * 2)
    end

    if children_strings.empty?
      "#{parent_string}"
    else
      "#{parent_string}\n#{children_strings.join("\n")}"
    end
  end

  private
  def _flatten(parent, nodes = nil)
    nodes ||= []
    parent.children.each do |child|
      nodes << child
      _flatten(child, nodes)
    end
    nodes
  end
end
