class Public::HomesController < ApplicationController

  def top
    @posts = Post.preload(:customer)
  end
  
  

end
