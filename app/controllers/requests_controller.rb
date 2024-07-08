class RequestsController < ApplicationController
  def index
    @requests =  Request.all
  end

  def new
    @request =  Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to requests_path
    else
      render "requests/new", status: :unprocessable_entity
    end
  end

  def show
    @request = Request.find(params[:id])
    @comments = @request.comments || []
    @comment = @request.comments.build
  end

  def request_params
    params.require(:request).permit(:article_id, :quantity).merge(user_id: current_user.id, request_time: Time.now, status: "未対応", response_user_id: nil, response_time: nil)
  end

end
