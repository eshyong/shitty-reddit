class PostsController < ApplicationController
  include VoteableController
  before_action :require_login, except: [:index, :show]

  def index
    @posts = Post.all()
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params(:link))
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
    up(@post)
    redirect_to @post
  end

  def downvote
    @post = Post.find(post_id)
    down(@post)
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

  def post_params(_type)
    permitted = params.require(:post).permit(:title, :url)
    permitted[:_type] = _type
    permitted
  end
end
