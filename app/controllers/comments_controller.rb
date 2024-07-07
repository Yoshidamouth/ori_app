class CommentsController < ApplicationController
  def create
    @request = Request.find(params[:request_id])
    @comment = @request.comments.build(comment_params)
    
    if @comment.save
      redirect_to request_path(@request)
    else
      render "requests/show", status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
