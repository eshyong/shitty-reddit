class PostsController < ApplicationController
  def index
    @posts = Post.all()
  end

  def new
    @post = Post.new
  end

  def create
    post_h = post_params.to_h.update(_type: :link, upvotes: 0, downvotes: 0)
    @post = Post.new(post_h)
    @post.save
    redirect_to @post
  end

  def login
  end

  def show
    @post = Post.find(post_id)
    vote = find_vote_by_user(user_id)
    return if vote.nil?
    @upvoted = vote.upvoted
    @downvoted = vote.downvoted
  end

  def upvote
    @post = Post.find(post_id)
    vote = find_vote_by_user(user_id)

    @post.with_lock do
      # check if user has voted before
      if vote.nil?
        vote = @post.votes.new(upvoted: true, user_id: user_id)
      else
        vote.upvoted = vote.upvoted ? false : true
        vote.downvoted = false
      end

      # if a user upvotes an already upvoted post, it is negated.
      if vote.upvoted
        @post.upvotes += 1
      else
        @post.upvotes -= 1
      end

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
      else
        vote.downvoted = vote.downvoted ? false : true
        vote.upvoted = false
      end

      # if a user downvotes an already downvoted post, it is negated.
      if vote.downvoted
        @post.downvotes += 1
      else
        @post.downvotes -= 1
      end

      @post.save!
      vote.save!
    end

    redirect_to @post
  end

  private 
  def find_vote_by_user(user_id)
    if !user_id.nil?
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
