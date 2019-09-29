module PostsHelper
  def upvote_button(resource, path)
    is_upvoted = resource.upvoted?(user_id)
    options = html_options("upvote-button", is_upvoted, false)
    button_to("↑", path, options)
  end

  def downvote_button(resource, path)
    is_downvoted = resource.downvoted?(user_id)
    options = html_options("downvote-button", false, is_downvoted)
    button_to("↓", path, options)
  end

  private
  def html_options(classname, is_upvoted, is_downvoted)
    html_options = { params: { id: @post.id } }

    if is_upvoted && classname == "upvote-button"
      classname = "#{classname} upvoted"
    elsif is_downvoted && classname == "downvote-button"
      classname = "#{classname} downvoted"
    end

    html_options[:class] = classname
    html_options
  end

  def user_id
    session[:user_id]
  end
end
