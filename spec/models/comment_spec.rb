require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'Yuumi', photo: 'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Yuumi_0.jpg', bio: 'Kitty with claws and book', post_counter: 4) }
  before { user.save }

  let(:post) do
    Post.create(title: 'Support Built', text: 'Text for Yuumi support built', comments_counter: 2, likes_counter: 10,
                author_id: user.id)
  end
  before { post.save }

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

  it 'updates the comments_counter of the associated post after save' do
    # Create a comment associated with the post
    Comment.create(user_id: user.id, post_id: post.id, text: 'A valid comment')

    # Reload the associated post
    reloaded_post = Post.find(post.id)

    # Expectations
    expect(reloaded_post.comments_counter).to eq(1)
  end
end
