class RequestsController < ApplicationController
  def index
    
  end

  def new
    @request =  Request.new
  end
end