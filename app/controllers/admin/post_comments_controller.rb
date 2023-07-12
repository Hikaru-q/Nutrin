class Admin::PostCommentsController < ApplicationController
  
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
