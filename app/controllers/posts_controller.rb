class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.vote = 0
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to root_path
    else
      redirect_to post_path(@post)
    end
  end

  def upvote
    @post = Post.find(params[:id])
    @post.vote += 1
    @post.save!
    redirect_to root_path
  end

  def downvote
    @post = Post.find(params[:id])
    @post.vote += -1
    @post.save!
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :description, :category, :vote)
  end
end
