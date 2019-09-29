class CommentsController < ApplicationController
  before_action :require_login

  def create
    post = Post.find(post_id)
    comment = post.comments.create(comment_params)

    if !comment.save
      flash[:errors] = comment.errors.full_messages
    end
    redirect_to post_path(post)
  end

  private
  def post_id
    params[:post_id]
  end

  def comment_params
    permitted = params.require(:comment).permit(:body)
    permitted[:user] = session[:username]
    permitted
  end
end
