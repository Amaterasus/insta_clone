class Post < ApplicationRecord
  belongs_to :user
  has_many :tags
  has_many :likes
  has_many :comments
  validates :title, presence: true
  validates :image, presence: true

  def self.explore_posts
    Post.order(Arel.sql("RANDOM()")).limit(24)
  end
end
