require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and a non-negative post_counter' do
    user = User.new(name: 'Layla', post_counter: 0)
    expect(user).to be_valid
  end

  it 'is invalid if it is not an integer' do
    user = User.new(post_counter: '0')
    expect(user).to_not be_valid
  end

  it 'is invalid without a name' do
    user = User.new(post_counter: 0)
    expect(user).to_not be_valid
  end

  it 'is invalid with a negative post_counter' do
    user = User.new(name: 'Layla', post_counter: -1)
    expect(user).to_not be_valid
  end

  it 'has many posts' do
    user = User.reflect_on_association(:posts)
    expect(user.macro).to eq(:has_many)
  end

  it 'has many comments' do
    user = User.reflect_on_association(:comments)
    expect(user.macro).to eq(:has_many)
  end

  it 'has many likes' do
    user = User.reflect_on_association(:likes)
    expect(user.macro).to eq(:has_many)
  end
end
