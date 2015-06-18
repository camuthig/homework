class RoutesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  def root
    if current_user.student?
      redirect_to assignments_url
    else
      redirect_to homework_index_url
    end
  end
end