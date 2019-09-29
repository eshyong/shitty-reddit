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

  def upvote
    post = Post.find(post_id)
    comment = post.comments.find(comment_id)
    vote = comment.votes.find_by(user_id: user_id)

    comment.with_lock do
      if vote.nil?
        vote = comment.votes.new(upvoted: true, user_id: user_id)
      end

      comment.upvote(vote)
      vote.upvote
      comment.save!
      vote.save!
    end

    redirect_to post
  end

  def downvote
    post = Post.find(post_id)
    comment = post.comments.find(comment_id)
    vote = comment.votes.find_by(user_id: user_id)

    comment.with_lock do
      if vote.nil?
        vote = comment.votes.new(downvoted: true, user_id: user_id)
      end

      comment.downvote(vote)
      vote.downvote
      comment.save!
      vote.save!
    end

    redirect_to post
  end

  private
  def post_id
    params[:post_id]
  end

  def comment_id
    params[:id]
  end

  def user_id
    session[:user_id]
  end

  def comment_params
    permitted = params.require(:comment).permit(:body)
    permitted[:user] = session[:username]
    permitted
  end
end
