module PostsHelper
  def upvote_button(resource, path)
    is_upvoted = resource.upvoted?(user_id)
    html_options = {
      params: { id: resource.id },
      class: button_classname("upvote-button", is_upvoted: is_upvoted)
    }
    button_to("↑", path, html_options)
  end

  def downvote_button(resource, path)
    is_downvoted = resource.downvoted?(user_id)
    html_options = {
      params: { id: resource.id },
      class: button_classname("downvote-button", is_downvoted: is_downvoted)
    }
    button_to("↓", path, html_options)
  end

  private
  def button_classname(classname, is_upvoted: false, is_downvoted: false)
    if is_upvoted && classname == "upvote-button"
      "#{classname} upvoted"
    elsif is_downvoted && classname == "downvote-button"
      "#{classname} downvoted"
    else
      classname
    end
  end

  def user_id
    session[:user_id]
  end
end
