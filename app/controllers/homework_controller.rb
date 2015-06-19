class HomeworkController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  # Get a list of all homework. For a student, they will be redirected to the
  # assignments index. Teachers will see all homework in the system.
  #
  # *Assigns* :
  #   - homeworks : The list of homework
  def index
    if current_user.teacher?
      @homeworks = Homework.all()
    else
      redirect_to assignments_url() and return
    end

    respond_to do |format|
      format.html
      format.json { render json: @homeworks }
    end
  end

  # Get details for a specific assignemtn. For a student, they will receive a
  # forbidden error and redirect to root. Teachers will see the details of the homework.
  #
  # *Assigns* :
  #   - homework : The homework
  def show
    if current_user.student?
      respond_forbidden("Whoops! You were not allowed there.") and return
    end

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
