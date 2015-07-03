class Api::HomeworkController < Api::ApplicationController
  before_action :set_current_user

  def index
    if @current_user.teacher?
      @homeworks = Homework.all()
    else
      respond_forbidden('Students are not allowed to view homework') and return
    end

    render json: @homeworks
  end
end
