require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  let(:student) {FactoryGirl.create(:student_with_homework, username: 'lousy_student')}
  let(:other_student) {FactoryGirl.create(:student_with_homework, username: 'other_student')}
  let(:teacher) {FactoryGirl.create(:student_with_homework, username: 'teacher')}
  let(:homework) {FactoryGirl.create(:homework, title: 'Much Harder Homework', question: 'What is your favorite color?')}
  let(:assignment) {FactoryGirl.create(:assignment, user: student, homework: homework)}
  let(:other_assignment) {FactoryGirl.create(:assignment, user: other_student, homework: homework)}
  let(:last_answer) {FactoryGirl.create(:answer, assignment_id: assignment.id)}

  ########################
  # SHOW
  ########################
  describe 'GET show' do
    it 'renders template' do
      assignment.answers = [last_answer]
      get :show, {:id => assignment.id}, {'user_id' => student.id}
      expect(response).to render_template('show')
      expect(assigns(:assignment)).to eq assignment
    end
  end

  describe 'GET show without session' do
    it 'redirects to login' do
      get :show, {:id => assignment.id}
      expect(response).to redirect_to login_url
    end
  end

  describe 'GET show another students assignment' do
    it 'renders template' do
      get :show, {:id => assignment.id}, {'user_id' => other_student.id}
      expect(response).to redirect_to root_url
      expect(flash[:error]).to be_present
    end
  end

  ########################
  # INDEX
  ########################

  # TODO: write tests for the assignments#index
  #   success for student (only student's assignments assigned)
  #   success for teacher (all assignments assigned)
  #   without session
  #   other student's assignment

  # describe 'GET index student' do
  #   it 'renders template' do
  #     get :index, {}, {'user_id' => teacher.id}
  #     expect(response).to render_template('index')
  #     expect(assigns(:assignments)).to match_array([other_assignment, assignment])
  #   end
  # end


  # TODO: write tests for the assignments@show
  #   success for student
  #   success for teacher
  #   without session
  #   other student's assignment
end
