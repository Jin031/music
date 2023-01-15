class Public::PostsController < ApplicationController
 def new
  @post = Post.new
 end

 def index
  @posts = Post.all.page(params[:page]).per(4)
 end

 def create
  @post = current_customer.posts.build(post_params)

  if @post.save
    redirect_to posts_path, notice: "投稿しました"
  else
    flash.now[:alert] = "投稿に失敗しました"
    render :new
  end
 end

 def show
  @post = Post.find(params[:id])
  @comment = Comment.new
 end

 def destroy
  @post = Post.find(params[:id])
  @post.destroy
  redirect_to new_post_path
 end

 private

 def post_params
  params.require(:post).permit(:title, :text, :genre_id, images: [])
 end
end
