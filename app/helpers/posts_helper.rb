module PostsHelper
  def upvote_button
    button_to('↑', upvote_path, html_options('upvote-button'))
  end

  def downvote_button
    button_to('↓', downvote_path, html_options('downvote-button'))
  end

  def html_options(classname)
    html_options = { params: { id: @post.id } }
    if @upvoted && classname == 'upvote-button'
      classname = "#{classname} upvoted"
    elsif @downvoted && classname == 'downvote-button'
      classname = "#{classname} downvoted"
    end
    html_options[:class] = classname
    html_options
  end
end
