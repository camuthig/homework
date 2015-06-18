class AnswersController < ApplicationController

  def new
    # We need a few things here:
    # 1. Make sure that the user is the one who owns the assignment
    # 2. Make sure that the due date for the homework is not passed
    # 3. Create a new Answer instance to populate
    # 4. Get the latest Answer for this assignment to prepopulate the answer with
    if !owns_assignment
      render :status => :forbidden, :text => "Forbidden fruit" and return
    end
    if Time.now > @assignment.homework.due_date
      render :status => :forbidden, :text => "Don't sleep on the homework" and return
    end
    @answer = Answer.new
    @latest_answer = Answer.where(assignment_id: params[:assignment_id]).last
  end

  def create
    if !owns_assignment
      render :status => :forbidden, :text => "Forbidden fruit" and return
    end
    if Time.now > @assignment.homework.due_date
      render :status => :forbidden, :text => "Don't sleep on the homework" and return
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
