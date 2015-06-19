require 'rails_helper'

RSpec.describe Homework, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:homework, title: 'Title', question: "this is a question")).to be_valid
  end
  it 'is invalid without a question' do
    expect(FactoryGirl.build(:homework, title: 'Title', question: nil)).to_not be_valid
  end
  it 'is invalid without a title' do
    expect(FactoryGirl.build(:homework, title: nil, question: 'this is a question')).to_not be_valid
  end
  it 'is invalid without a due date' do
    expect(FactoryGirl.build(:homework, title: 'Title', question: 'this is a question', due_date: nil)).to_not be_valid
  end
end
