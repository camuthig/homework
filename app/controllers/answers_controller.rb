class AnswersController < ApplicationController

  # Retrieves the necessary data for creating a new answer to an assignment. This
  # method will accomplish a number of tasks, including:
  # * Make sure that the user is the one who owns the assignment
  # * Make sure that the due date for the homework is not passed
  # * Create a new Answer instance to populate
  # * Get the latest Answer for this assignment to prepopulate the answer with
  def new
    if !is_valid
      return
    end
    @answer = Answer.new
    @latest_answer = Answer.where(assignment_id: params[:assignment_id]).last
  end

  # Saves the provided answer, using the URL provided assignment_id. Tasks
  # completed will be:
  # * Make sure that the user is the one who owns the assignment
  # * Make sure that the due date for the homework is not passed
  # * Save the answer, linking it to the URL assignment_id
  def create
    if !is_valid
      return
    end
    @answer = Answer.create(answer_params)
    @answer.assignment_id = params[:assignment_id]
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @assignment }
      else
        format.html { render action: "new" }
      end
    end
  end


  private
    # Ensure that the user owns the assignment, and the assignment is not past due
    # * *Returns* :
    #   - Boolean : True when the session's user owns the assignment and the assignment is not past due
    def is_valid
      if !owns_assignment
        respond_forbidden("You are not allowed to answer that assignment.") and return false
      end
      if Time.now > @assignment.homework.due_date
        respond_forbidden("That assignment is past due!") and return false
      end

      return true
    end

    # Determine if the session's user has ownership, and therefore rights to alter,
    # over the assignment. This will also create an instance variable *assignment*.
    # * *Returns* :
    #   - Boolean : true when the session's user owns the assignment
    def owns_assignment
      @assignment = Assignment.find(params[:assignment_id])
      if @assignment.user_id != session[:user_id]
        return false
      end
      return true
    end

    def answer_params
      params.require(:answer).permit(:answer, :assignment_id)
    end
end
