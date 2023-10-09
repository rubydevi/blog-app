require 'rails_helper'

RSpec.describe 'User Post Index Page', type: :feature do
  let(:user) { User.create(name: 'Ruby', photo: 'https://avatars.githubusercontent.com/u/112550568?v=4', bio: 'C# Developer from India.', post_counter: 6) }

  before do
    @posts = [
      Post.create(author: user, title: 'Post 1', text: 'Text for post 1', comments_counter: 2, likes_counter: 3),
      Post.create(author: user, title: 'Post 2', text: 'Text for post 2', comments_counter: 1, likes_counter: 5)
    ]
    visit user_posts_path(user_id: user.id)
  end

  context "Viewing user's profile information" do
    it "shows user's profile picture" do
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
    it "checks for user's username" do
      expect(page).to have_content(user.name)
    end
    it 'checks for post count' do
      expect(page).to have_content("Number of posts: #{user.post_counter}")
    end
  end

  context 'Viewing posts' do
    it "can see a post's title" do
      @posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it "can see some of the post's body" do
      @posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'can see how many comments a post has' do
      @posts.each do |post|
        expect(page).to have_content("Comments: #{post.comments_counter}")
      end
    end

    it 'can see how many likes a post has' do
      @posts.each do |post|
        expect(page).to have_content("Likes: #{post.likes_counter}")
      end
    end
  end

  context 'Viewing comments on posts' do
    it 'Check for comments section' do
      @posts.each do |post|
        if post.recent_comments.any?
          post.recent_comments.each do |comment|
            expect(page).to have_content(comment.body)
          end
        else
          expect(page).to have_content('No recent comments found.')
        end
      end
    end
  end

  context 'Pagination section' do
    it 'checks for pagination section' do
      expect(page).to have_css('.btn-container .btn.center-btn', text: 'Pagination')
    end
  end

  context 'Pagination links' do
    it 'redirects to the post show page when clicked on the post' do
      post = @posts.first
      click_link("user_post_#{post.id}")
      expect(page).to have_current_path(user_post_path(user, post))
    end
  end
end
