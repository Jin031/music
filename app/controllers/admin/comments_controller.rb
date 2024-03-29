class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    ngword = ["キモイ","きもい","バカ","ばか","アホ","あほ"]
    @comments = []
      ngword.each do |keyword|  # 分割したキーワードごとに検索
        @comments += Comment.where('comment LIKE(?)', "%#{keyword}%") # 部分一致で検索
      end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:customer_id, :post_id, :comment)
  end
end

