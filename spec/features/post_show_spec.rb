require 'rails_helper'

RSpec.describe 'User Post Show Page', type: :feature do
  let(:user) { User.create(name: 'Ruby', photo: 'https://avatars.githubusercontent.com/u/112550568?v=4', bio: 'C# Developer from India.', post_counter: 6) }

  before do
    @post = Post.create(author: user, title: 'Post 1', text: 'Text for post 1', comments_counter: 2, likes_counter: 3)
    visit user_post_path(user_id: user.id, id: @post.id)
  end

  it "I can see the post's title" do
    expect(page).to have_content(@post.title)
  end

  it 'I can see who wrote the post' do
    expect(page).to have_content("by #{user.name}")
  end

  it 'I can see how many comments it has' do
    expect(page).to have_content("Comments: #{@post.comments_counter}")
  end

  it 'I can see how many likes it has' do
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'I can see the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'I can see the username of each commentor' do
    @post.recent_comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'I can see the comment each commentor left' do
    @post.recent_comments.each do |comment|
      expect(page).to have_content(comment.body)
    end
  end
end
