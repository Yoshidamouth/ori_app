class CommentsController < ApplicationController

  def create
    @request = Request.find(params[:request_id])
    @comment = @request.comments.build(comment_params)
  
    if @comment.save
      redirect_to request_path(@request)
    else
      @comments = @request.comments.order(created_at: :desc)
      render "requests/show", status: :unprocessable_entity
    end
  end

  def destroy
    @request = Request.find(params[:request_id])
    @comment = @request.comments.find(params[:id])
    @comment.destroy
    redirect_to request_path(@request)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, comment_time: Time.now)
  end
end
