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
    @post = Post.find(params[:id])
  end

  private 
  def post_params
    params.require(:post).permit(:title, :url)
  end
end
