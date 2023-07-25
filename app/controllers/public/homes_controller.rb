class Public::HomesController < ApplicationController

  def top
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    else
      to  = Time.current.at_end_of_day
      from  = (to - 6.day).at_beginning_of_day
      @posts = Post.preload(:favorites).sort_by {|x| x.favorites.where(created_at: from...to).size}.reverse
    end
  end
  
  

end
