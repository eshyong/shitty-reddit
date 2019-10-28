class CommentsController < ApplicationController
  include VoteableController
  before_action :require_login

  def create
    post = Post.find(post_id)
    comment = post.comments.create(comment_params)
    unless comment.save
      flash[:errors] = comment.errors.full_messages
    end
    redirect_to(post_path(post))
  end

  def upvote
    post = Post.find(post_id)
    comment = post.comments.find(comment_id)
    up(comment)
    head :ok
  end

  def downvote
    post = Post.find(post_id)
    comment = post.comments.find(comment_id)
    down(comment)
    head :ok
  end

  private
  def post_id
    params[:post_id]
  end

  def comment_id
    params[:id]
  end

  def comment_params
    permitted = params.require(:comment).permit(:body, :parent_id)
    permitted[:parent_id] = nil if permitted[:parent_id].empty?
    permitted[:user] = session[:username]
    permitted
  end
end
