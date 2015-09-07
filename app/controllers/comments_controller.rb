class CommentsController < ApplicationController

  # def index
  #   @ = Post.all.sort_by{|post| post.vote}.reverse
  # end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    # @comment = Comment.new(params[:id]) bad param
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @comment = Comment.find(params[:post_id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  # def destroy
  #   #@post = Post.find(params[:post_id])
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy
  #     redirect_to post_path(@comment.post_id)
  #   # else
  #   #   redirect_to post_path(@post)
  #   # end
  # end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :name, :body)
  end
end
