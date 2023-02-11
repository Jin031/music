class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, except: [:show, :index]
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.page(params[:page]).per(4)
      if params[:genre_id]
        @posts = @posts.where(genre_id: params[:genre_id])
      end
      if params[:keyword]
        @posts = @posts.where("title LIKE ?", "%#{params[:keyword]}%")
      end
  end

  def create
    @post = current_customer.posts.build(post_params)
    byebug
      if @post.save
        redirect_to posts_path, notice: "投稿しました"
      else
        render :new
      end
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.comments.page(params[:page]).per(3)
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to new_post_path, notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :customer_id, :genre, images: [])
  end
end
