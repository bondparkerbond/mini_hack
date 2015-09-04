class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :name, :body)
  end
end
