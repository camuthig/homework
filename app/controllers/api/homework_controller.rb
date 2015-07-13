class Api::HomeworkController < Api::ApplicationController
  before_action :set_current_user, :student_not_allowed

  def index
    @homeworks = Homework.all()
  end

  def show
    @homework = Homework.find(params[:id])
    if !@homework
      raise ActionController::RoutingError.new('Not Found')
      return respond_not_found('Homework was not found.')
    end
  end

  def create
    @homework = Homework.create(homework_params)
    if !@homework.valid?
      respond_bad_request('Invalid parameters for creating homework') and return
    end
    if !@homework.save
      respond_internal()
    end
    render_created
  end

  def update
    @homework = Homework.find(params[:id])
    @homework.update(homework_params)
    if !@homework.valid?
      respond_bad_request('Invalid parameters for creating homework') and return
    end
    if !@homework.save
      respond_internal()
    end
  end

  def homework_params
    params.permit(:question, :title, :due_date)
  end

  def destroy
    Homework.find(params[:id]).destroy
    render_no_content
  end

  def assign
    @homework = Homework.find(params[:homework_id])
    creates = []
    params[:users].each do |user|
      creates << {homework_id: @homework.id, user_id: user}
    end
    Assignment.create(creates)
    @homework = Homework.includes(assignments: [:user, :answers]).find(params[:homework_id])
  end

  def assignments
    @homework = Homework.includes(assignments: [:user, :answers]).find(params[:homework_id])
    if !@homework
      return respond_not_found('Homework was not found.')
    end
  end

  protected

end
