require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'Yuumi', photo: 'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Yuumi_0.jpg', bio: 'Kitty with claws and book', post_counter: 4) }
  before { user.save }

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

  # recent posts instance method
  it 'returns the most recent posts' do
    5.times do
      Post.create(title: 'Support Built', text: 'Text for Yuumi support built', comments_counter: 2, likes_counter: 10,
                  author_id: user.id)
    end
    recent_posts = user.recent_posts

    # Expectations
    expect(recent_posts).to eq(user.posts.order(created_at: :desc).limit(3))
    expect(recent_posts.first.created_at).to be > recent_posts.last.created_at
  end

  it 'returns up to 3 posts when there are more than 3 posts' do
    5.times do
      Post.create(title: 'Support Built', text: 'Text for Yuumi support built', comments_counter: 2, likes_counter: 10,
                  author_id: user.id)
    end

    recent_posts = user.recent_posts

    # Expectations
    expect(recent_posts.count).to eq(3)
  end

  it 'returns an empty array when the user has no posts' do
    # No need to create any posts in this test; user already has no posts
    recent_posts = user.recent_posts
    expect(recent_posts).to be_empty
  end
end
