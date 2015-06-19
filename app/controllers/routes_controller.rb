class RoutesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  # Handle redirection for root. Students should redirect to assignments
  # while teachers will go to homeworks. This is explicit, rather than relying on
  # the redirect in homeworks index to avoid confusion and add flexibility.
  def root
    if current_user.student?
      redirect_to assignments_url
    else
      redirect_to homework_index_url
    end
  end
end