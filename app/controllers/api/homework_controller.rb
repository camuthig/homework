class Api::HomeworkController < Api::ApplicationController
  before_action :set_current_user

  def index
    if @current_user.student?
      respond_forbidden('Students are not allowed to view homework') and return
    end

    @homeworks = Homework.all()
  end

  def show
    if @current_user.student?
      respond_forbidden("Whoops! You were not allowed there.") and return
    end

    @homework = Homework.find(params[:id])
    if !@homework
      raise ActionController::RoutingError.new('Not Found')
      return respond_not_found('Homework was not found.')
    end
  end

  def assignments
    if @current_user.student?
      respond_forbidden("Whoops! You were not allowed there.") and return
    end

    @homework = Homework.find(params[:homework_id])
    if !@homework
      return respond_not_found('Homework was not found.')
    end
  end
end
