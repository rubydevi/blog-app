require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Lana') }
  let(:post) { Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id) }

  it 'is invalid when comment text is blank' do
    comment = Comment.new(text: nil)
    expect(comment).not_to be_valid
  end

  it 'returns the comment text' do
    comment = Comment.new(text: 'testing testing')
    expect(comment.text).to eq('testing testing')
  end

  it 'is valid with valid attributes' do
    comment = Comment.new(user:, post:, text: 'A valid comment')
    expect(comment).to be_valid
  end

  it 'is invalid without a post' do
    post = Post.create(author: user, title: 'Second Post', text: 'This is my post')
    comment = Comment.new(user:, text: 'Test Comment', post:)
    expect(comment).to be_valid
  end
end
