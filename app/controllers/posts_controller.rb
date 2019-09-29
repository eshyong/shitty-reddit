class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @posts = Post.all()
  end

  def new
    @post = Post.new
  end

  def create
    post_h = post_params.to_h.update(_type: :link)
    @post = Post.new(post_h)
    @post.save
    redirect_to @post
  end

  def login
  end

  def show
    @post = Post.find(post_id)
    vote = find_vote_by_user(user_id)
    unless vote.nil?
      @upvoted = vote.upvoted
      @downvoted = vote.downvoted
    end
  end

  def upvote
    @post = Post.find(post_id)
    vote = find_vote_by_user(user_id)

    @post.with_lock do
      # check if user has voted before
      if vote.nil?
        vote = @post.votes.new(user_id: user_id)
      end

      @post.upvote(vote)
      vote.upvote

      @post.save!
      vote.save!
    end

    redirect_to @post
  end

  def downvote
    @post = Post.find(post_id)
    vote = find_vote_by_user(user_id)

    @post.with_lock do
      # check if user has voted before
      if vote.nil?
        vote = @post.votes.new(downvoted: true, user_id: user_id)
      end

      @post.downvote(vote)
      vote.downvote

      @post.save!
      vote.save!
    end

    redirect_to @post
  end

  private 
  def find_vote_by_user(user_id)
    if logged_in?
      @post.votes.find_by(user_id: user_id)
    end
  end

  def post_id
    params[:id]
  end

  def user_id
    return session[:user_id]
  end

  def post_params
    params.require(:post).permit(:title, :url)
  end
end
