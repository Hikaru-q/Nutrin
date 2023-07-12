class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @customer = @post.customer
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id]).destroy
    @post_comment.destroy
    @post = Post.find(params[:post_id])
  end
  
   private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
