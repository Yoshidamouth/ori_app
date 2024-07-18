class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_branch_user, only: [:edit, :new]
  before_action :set_request, only: [:show, :destroy, :update_status, :complete_status, :edit, :update]

  def index
    @requests = Request.order(created_at: :desc)
    @affiliations = Affiliation.where.not(name: '---')
    @articles = Article.all
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to requests_path, notice: '依頼が投稿されました。'
    else
      render "requests/new", status: :unprocessable_entity
    end
  end

  def show
    @comments = @request.comments.includes(:user).order(:created_at)
    @comment = @request.comments.build
  end

  def destroy
    @request.destroy
    redirect_to requests_path
  end

  def edit
    if current_user.id != @request.user_id
      redirect_to '/'
    end
  end

  def update
    if @request.update(request_params)
      redirect_to @request, notice: '依頼が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_status
    if @request.update(status: '対応中', response_user_id: current_user.id)
      redirect_to @request
    else
      redirect_to @request, status: :unprocessable_entity
    end
  end

  def complete_status
    @stock = Stock.find_by(article_id: @request.article_id)

    if @stock.nil?
      flash[:alert] = "在庫が見つかりません"
      redirect_to @request and return
    end

    if @stock.quantity >= @request.quantity
      @stock.update(quantity: @stock.quantity - @request.quantity)
      if @request.update(status: '対応済', response_time: Time.current)
        flash[:notice] = "対応が完了しました"
        redirect_to @request
      else
        redirect_to @request, status: :unprocessable_entity
      end
    else
      flash[:alert] = "在庫数が足りません"
      redirect_to @request, status: :unprocessable_entity
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:article_id, :quantity).merge(user_id: current_user.id, request_time: Time.current, status: "未対応", response_user_id: nil, response_time: nil)
  end

  def redirect_if_not_branch_user
    unless current_user.affiliation_id != 2
      redirect_to '/'
    end
  end
end
