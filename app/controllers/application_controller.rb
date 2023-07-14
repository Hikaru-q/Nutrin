class ApplicationController < ActionController::Base
  before_action :search
  
  # 検索機能
  def search
    @q = params[:q]
    @post = Post.ransack(post_name_cont: @q).result
    @customer = Customer.ransack(name_cont: @q).result
  end
  
end
