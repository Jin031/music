class Admin::CommentsController < ApplicationController
 before_action :authenticate_admin!
 def index

  ngword = ["キモイ","バカ"]

  @comments = []
  ngword.each do |keyword|  # 分割したキーワードごとに検索
    @comments += Comment.where('comment LIKE(?)', "%#{keyword}%") # 部分一致で検索
  end

 end

# def ng(text)

#   ngword.any?{|t|text.include?(t)}
# end

 def destroy

 end
end
