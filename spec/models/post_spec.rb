require 'rails_helper'
RSpec.describe Post, type: :model do
  it 'is invalid when title is blank' do
    post = Post.new(title: nil)
    expect(post).not_to be_valid
  end

  it 'is invalid when title exceeds 250 characters.' do
    post = Post.new(title: 'a' * 251)
    expect(post).not_to be_valid
  end

  it 'is invalid with a negative commentsCounter' do
    post = Post.new(title: 'Microverse', comments_counter: -1)
    expect(post).not_to be_valid
  end

  it 'is invalid with a negative likesCounter' do
    post = Post.new(title: 'Microverse', likes_counter: -1)
    expect(post).not_to be_valid
  end
end
