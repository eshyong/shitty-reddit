class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)

    if !@comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to post_path(@post)
  end

  def show
  end

  private
  def comment_params
    params.require(:comment).permit(:user, :body)
  end
end
