class Public::CommentsController < ApplicationController
 before_action :authenticate_customer!
 def create
 post = Post.find(params[:post_id])
 comment = current_customer.comments.new(comment_params)
 comment.post_id = post.id
 comment.save
 post.create_notification_comment!(current_customer)
 redirect_to post_path(post), notice: "コメントしました"
 end

 def destroy
  Comment.find(params[:id]).destroy
  redirect_to post_path(params[:post_id]), notice: "コメントを削除しました"
 end

 private

 def comment_params
  params.require(:comment).permit(:comment)
 end
end
