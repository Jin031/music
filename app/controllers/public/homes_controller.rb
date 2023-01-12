class Public::HomesController < ApplicationController
 def top
  @ranks = Post.find(Favorite.group(:id).order('count(post_id) desc').limit(4).pluck(:post_id))
 end
end
