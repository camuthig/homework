require 'rails_helper'

RSpec.describe Assignment, type: :model do

  before(:each) do
    @user = FactoryGirl.create(:student, username: 'student')
    @homework = FactoryGirl.create(:homework, title: 'Title', question: "this is a question")
  end

  it 'has a valid factory' do
    expect(FactoryGirl.build(:assignment, user: @user, homework: @homework)).to be_valid
  end

  it 'is invalid without a user' do
    expect(FactoryGirl.build(:assignment, user: nil, homework: @homework)).to_not be_valid
  end

  it 'is invalid without a homework' do
    expect(FactoryGirl.build(:assignment, user: @user, homework: nil)).to_not be_valid
  end
end
