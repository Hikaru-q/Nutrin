class Admin::PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
  end
  
  def index
    @posts = Post.preload(:customer)
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path
      flash[:notice] = "更新が完了しました"
    else
      flash[:alert] = "投稿内容を更新できませんでした"
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
    flash[:notice] = "削除が完了しました"
  end

   private
  
  def post_params
    params.require(:post).permit(:post_name, :description, :material, :recipe, :nutrition, :image)
  end
  
end
