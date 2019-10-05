class CommentsController < ApplicationController
  include VoteableController
  before_action :require_login

  def create
    post = Post.find(post_id)
    comment = post.comments.create(comment_params)

    if !comment.save
      flash[:errors] = comment.errors.full_messages
    end
    redirect_to post_path(post)
  end

  def upvote
    post = Post.find(post_id)
    comment = post.comments.find(comment_id)
    up(comment)
    redirect_to post
  end

  def downvote
    post = Post.find(post_id)
    comment = post.comments.find(comment_id)
    down(comment)
    redirect_to post
  end

  private
  def post_id
    params[:post_id]
  end

  def comment_id
    params[:id]
  end

  def comment_params
    permitted = params.require(:comment).permit(:body)
    permitted[:user] = session[:username]
    permitted
  end
end
