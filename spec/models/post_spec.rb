require 'rails_helper'
RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Yuumi', photo: 'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Yuumi_0.jpg', bio: 'Kitty with claws and book', post_counter: 0) }
  before { user.save }

  let(:post) do
    Post.create(title: 'Support Built', text: 'Text for Yuumi support built', comments_counter: 2, likes_counter: 10,
                author_id: user.id)
  end
  before { post.save }

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

  context '#Methods' do
    it 'it should return 5 recent comments' do
      7.times { Comment.create(text: 'comment 1', user_id: user.id, post_id: post.id) }
      latest_posts = post.recent_comments
      expect(latest_posts.count).to eq(5)
    end

    it 'updates the post_counter of the associated user after save' do
      user = User.find_by(name: 'Yuumi')

      Post.create(title: 'New Post', text: 'This is a new post', author_id: user.id)

      reloaded_user = User.find(user.id)

      expect(reloaded_user.post_counter).to eq(1)
    end

    it 'does not update post_counter if the post is not saved' do
      user = User.find_by(name: 'Yuumi')
      Post.find_by(title: 'Support Built')

      new_post = Post.new(title: 'New Post', text: 'This is a new post', author_id: user.id)

      expect { new_post.save }.not_to(change { user.reload.post_counter })
    end
  end
end
