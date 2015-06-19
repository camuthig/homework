require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:student) {FactoryGirl.create(:student_with_homework, username: 'lousy_student')}
  let(:other_student) {FactoryGirl.create(:student_with_homework, username: 'other_student')}
  let(:homework) {FactoryGirl.create(:homework, title: 'Much Harder Homework', question: 'What is your favorite color?')}
  let(:assignment) {FactoryGirl.create(:assignment, user: student, homework: homework)}
  let(:last_answer) {FactoryGirl.create(:answer, assignment_id: assignment.id)}

  ########################
  # NEW
  ########################
  describe 'GET new' do
    it 'renders template' do
      assignment.answers = [last_answer]
      get :new, {:assignment_id => assignment.id}, {'user_id' => student.id}
      expect(response).to render_template('new')
      expect(assigns(:latest_answer)).to eq last_answer
    end
  end

  describe 'GET new without session' do
    it 'redirects to login' do
      get :new, {:assignment_id => assignment.id}
      expect(response).to redirect_to login_url
    end
  end

  describe 'GET new on another students assignment' do
    it 'redirects to root' do
      get :new, {:assignment_id => assignment.id}, {'user_id' => other_student.id}
      expect(response).to redirect_to root_url
      expect(flash[:error]).to be_present
    end
  end

  describe 'GET new on past due assignment' do
    it 'redirects to root' do
      assignment.homework.due_date = 1.day.ago
      assignment.homework.save

      get :new, {:assignment_id => assignment.id}, {'user_id' => student.id}
      expect(response).to redirect_to root_url
      expect(flash[:error]).to be_present

      assignment.homework.due_date = 1.day.ago
      assignment.homework.save
    end
  end


  ########################
  # CREATE
  ########################
  describe 'POST create' do
    it 'renders template' do
      post :create, {:assignment_id => assignment.id, :answer => {'answer' => 'Answer text'}}, {'user_id' => student.id}
      expect(response).to redirect_to(assignment)
      expect(assigns(:answer).answer).to eq 'Answer text'
    end
  end

  describe 'POST create without session' do
    it 'redirects to login' do
      post :create, {:assignment_id => assignment.id}
      expect(response).to redirect_to login_url
    end
  end

  describe 'POST create on another students assignment' do
    it 'redirects to root' do
      post :create, {:assignment_id => assignment.id}, {'user_id' => other_student.id}
      expect(response).to redirect_to root_url
      expect(flash[:error]).to be_present
    end
  end

  describe 'POST create on past due assignment' do
    it 'redirects to root' do
      assignment.homework.due_date = 1.day.ago
      assignment.homework.save

      post :create, {:assignment_id => assignment.id}, {'user_id' => student.id}
      expect(response).to redirect_to root_url
      expect(flash[:error]).to be_present

      assignment.homework.due_date = 1.day.ago
      assignment.homework.save
    end
  end
end