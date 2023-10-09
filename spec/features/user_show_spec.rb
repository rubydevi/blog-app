require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let(:user) { User.create(name: 'Ruby', photo: 'https://avatars.githubusercontent.com/u/112550568?v=4', bio: 'C# Developer from India.', post_counter: 6) }

  before do
    @posts = [
      Post.create(author: user, title: 'I love coding', text: 'Text for post 1',
                  comments_counter: 0, likes_counter: 0),
      Post.create(author: user, title: 'Learning Rails', text: 'Text for post 2',
                  comments_counter: 0, likes_counter: 0),
      Post.create(author: user, title: 'Title for post 3', text: 'Text for post 3',
                  comments_counter: 0, likes_counter: 0),
      Post.create(author: user, title: 'Title for post 4', text: 'Text for post 4',
                  comments_counter: 0, likes_counter: 0)
    ]
    visit user_path(user)
  end

  it "can see the user's profile picture" do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it "can see the user's username" do
    expect(page).to have_content(user.name)
  end

  it 'can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.post_counter}")
  end

  it "can see the user's bio" do
    expect(page).to have_content(user.bio)
  end

  it "can see the user's first 3 posts" do
    user.recent_posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it "can see a button that lets me view all of a user's posts" do
    expect(page).to have_link('See All Posts', href: user_posts_path(user), class: 'btn center-btn')
  end

  it "When click a user's post, it redirects me to that post's show page" do
    post = user.recent_posts.first
    click_link("user_post_#{post.id}")
    expect(page).to have_current_path(user_post_path(user, post))
  end

  it "When click to see all posts, it redirects me to the user's post's index page" do
    click_link 'See All Posts'
    expect(current_path).to eq(user_posts_path(user))
  end
end