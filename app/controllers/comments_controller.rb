class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find(params[:comment][:post_id]) 
    @comment = @post.comments.build(comment_params) 
    @comment.user_id = current_user.id 
    if @comment.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    # else
    #   respond_to do |format|
    #     format.html { redirect_back(fallback_location: root_url) }
    #     format.js
    #   end
      # redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
