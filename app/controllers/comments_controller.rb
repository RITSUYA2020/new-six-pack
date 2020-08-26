class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @work_out = WorkOut.find(params[:work_out_id])
    @comment = @work_out.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment_work_out = @comment.work_out
    if @comment.save
      # 通知の作成
      @comment_work_out.create_notification_comment!(current_user, @comment.id)
    else
      flash[:error] = 'コメントを入力してください。'
      redirect_to request.referer
    end
  end

  def destroy
    @comment = Comment.find(params[:work_out_id])
    @work_out = @comment.work_out
    redirect_to request.referer if @comment.user != current_user
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
