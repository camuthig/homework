class HomeworkController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  def index
    if current_user.teacher?
      @homeworks = Homework.all()
    else
      @homeworks = current_user.homeworks
    end
  end

end
