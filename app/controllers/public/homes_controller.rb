class Public::HomesController < ApplicationController
  def top
    #@ranks = Post.find(Favorite.group(:id).order('count(post_id) desc').limit(4).pluck(:post_id))

    #@ranks = Post.where(id: Favorite.group(:post_id).order('count(post_id) desc').select('post_id AS id'))
    # 外部結合を活用している
    # postの取得に合わせてfavoritesも取得している
    # 取得して気がfavoritesをcountで集計して order で 並び替えている
    @ranks =  Post.select("posts.*, COUNT(*) AS favo_count").left_joins(:favorites).group("posts.id").order(:favo_count => "desc").limit(4)
  end
end
