require 'rails_helper'
RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Martin', photo: 'profile photo', bio: 'Writer', post_counter: 6) }
  let(:post) { Post.create(title: 'Hello', text: 'This is my first post', comments_counter: 1, likes_counter: 1) }

  it 'is not valid without a user_id' do
    like = Like.new(post_id: post.id)
    expect(like).to_not be_valid
  end

  it 'is not valid without a post_id' do
    like = Like.new(user_id: user.id)
    expect(like).to_not be_valid
  end

  it 'belongs to a user' do
    like = Like.reflect_on_association(:user)
    expect(like.macro).to eq(:belongs_to)
  end

  it 'belongs to a post' do
    like = Like.reflect_on_association(:post)
    expect(like.macro).to eq(:belongs_to)
  end

  it 'is associated with the correct user' do
    like = Like.new(user_id: user.id, post_id: post.id)
    expect(like.user).to eq(user)
  end
end
