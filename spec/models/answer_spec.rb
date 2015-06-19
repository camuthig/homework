require 'rails_helper'

RSpec.describe Answer, type: :model do

  before(:each) do
    @user = FactoryGirl.create(:student, username: 'student')
    @homework = FactoryGirl.create(:homework, title: 'Title', question: "this is a question")
    @assignment = FactoryGirl.create(:assignment, user: @user, homework: @homework)
  end

  it 'has a valid Factory' do
    expect(FactoryGirl.build(:answer, assignment: @assignment, answer: 'This is my answer')).to be_valid
  end

  it 'is invalid without an answer' do
    expect(FactoryGirl.build(:answer, assignment: @assignment, answer: nil)).to_not be_valid
  end

  it 'is invalid without an assignment' do
    expect(FactoryGirl.build(:answer, assignment: nil, answer: 'This is my answer')).to_not be_valid
  end
end
