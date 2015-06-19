class AssignmentsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  # Get a list of all assignments. For a student, only their assignments will
  # appear. Teachers will see all assignments.
  #
  # *Assigns* :
  #   - assignments : The list of assignments
  def index
    if current_user.student?
      @assignments = Assignment.where(user_id: session[:user_id]).all()
    else
      @assignments = Assignment.all()
    end
    respond_to do |format|
      format.html
      format.json { render json: @assignments }
    end
  end

  # Get a single assignment. For a student, they will get a forbidden error if
  # they are not the owners of the assignment.
  #
  # *Assigns* :
  #   - assignment : The assignment
  def show
    @assignment = Assignment.find(params[:id])
    if current_user.student? and @assignment[:user_id] != session[:user_id]
      # A student can only interact with their own assignments
      respond_forbidden("You are not allowed to view the assignment.") and return
    end
    respond_to do |format|
      format.html
      format.json { render json: @assignment }
    end
  end
end
