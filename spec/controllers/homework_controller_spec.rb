require 'rails_helper'

RSpec.describe HomeworkController, type: :controller do
  let(:student) {FactoryGirl.create(:student_with_homework, username: 'lousy_student')}
  let(:other_student) {FactoryGirl.create(:student_with_homework, username: 'other_student')}
  let(:teacher) {FactoryGirl.create(:teacher, username: 'teacher')}
  let(:homework) {FactoryGirl.create(:homework, title: 'Much Harder Homework', question: 'What is your favorite color?')}
  let(:assignment) {FactoryGirl.create(:assignment, user: student, homework: homework)}
  let(:other_assignment) {FactoryGirl.create(:assignment, user: other_student, homework: homework)}
  let(:last_answer) {FactoryGirl.create(:answer, assignment_id: assignment.id)}

  ###################
  # SHOW
  ###################
  describe 'GET show as teacher' do
    it 'renders template' do
      # TODO: having a better way of creating this link with Factory Girl would be great
      assignment.answers = [last_answer]
      get :show, {:id => homework.id}, {'user_id' => teacher.id}
      expect(response).to render_template('show')
      expect(assigns(:homework)).to eq homework
    end
  end

  describe 'GET show as student' do
    it 'redirects to root' do
      get :show, {:id => homework.id}, {'user_id' => other_student.id}
      expect(response).to redirect_to root_url
      expect(flash[:error]).to be_present
    end
  end

  describe 'GET show without session' do
    it 'redirects to login' do
      get :show, {:id => homework.id}
      expect(response).to redirect_to login_url
    end
  end

  ###################
  # INDEX
  ###################
  describe 'GET index as teacher' do
    it 'renders template' do
      # TODO: having a better way of creating this link with Factory Girl would be great
      assignment.answers = [last_answer]
      get :index, {}, {'user_id' => teacher.id}
      expect(response).to render_template('index')
      expect(assigns(:homeworks)).to eq Homework.all
    end
  end

  describe 'GET index as student' do
    it 'redirects to assignments' do
      get :index, {}, {'user_id' => other_student.id}
      expect(response).to redirect_to assignments_url
    end
  end

  describe 'GET index without session' do
    it 'redirects to login' do
      get :index, {}
      expect(response).to redirect_to login_url
    end
  end

end
