class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  # Validation for name
  validates :name, presence: true

  # Validation for post_counter
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_defaults

  def set_defaults
    self.post_counter ||= 0
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
