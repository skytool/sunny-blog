class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: "댓글이 등록되었습니다."
    else
      redirect_to @post, alert: "댓글 등록에 실패했습니다."
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @post, notice: "댓글이 삭제되었습니다."
    else
      redirect_to @post, alert: "권한이 없습니다."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
