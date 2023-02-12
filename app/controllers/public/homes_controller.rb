class Public::HomesController < ApplicationController
  def top
    #@ranks = Post.find(Favorite.group(:id).order('count(post_id) desc').limit(4).pluck(:post_id))
    
    @ranks = Post.where(id: Favorite.group(:post_id).order('count(post_id) desc').select('post_id AS id'))
  end
end
