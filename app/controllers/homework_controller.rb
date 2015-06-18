class HomeworkController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  def index
    if current_user.teacher?
      @homeworks = Homework.all()
    else
      redirect_to assignments_url() and return
      #@homeworks = current_user.homeworks
    end

    respond_to do |format|
      format.html
      format.json { render json: @homeworks }
    end
  end

  def show
    @homework = Homework.find(params[:id])
    if !@homework
      raise ActionController::RoutingError.new('Not Found')
    end
    respond_to do |format|
      format.html
      format.json { render json: @homework }
    end
  end

end
