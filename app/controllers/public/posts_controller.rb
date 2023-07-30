class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def new
    @post = Post.new
  end
  
  def index
    @posts = Post.where(customer_id: [current_customer.id, *current_customer.following_customer_ids]).order(created_at: :desc)
  end
  
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = "投稿が完了しました"
    else
      flash[:alert] = "投稿できませんでした"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path
      flash[:notice] = "更新が完了しました"
    else
      flash[:alert] = "投稿内容を更新できませんでした"
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to customer_path(id: current_customer.id)
    flash[:notice] = "削除が完了しました"
  end

   private
  
  def post_params
    params.require(:post).permit(:post_name, :description, :material, :recipe, :nutrition, :image)
  end
  
  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
  
end
