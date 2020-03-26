class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :tags
  has_many :likes
  has_many :comments

  #followers and followee relationship
  has_many :active_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :active_follows, source: :followee
  has_many :passive_follows, class_name: "Follow", foreign_key: :followee_id, dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  validates :user_name, presence: true, uniqueness: true
  validates :bio, length: { maximum: 300 } #maximum characters 300

  def followee_recent_posts
    users = (Follow.select { |f| f.follower == self }).map { |f| User.find(f.followee_id) }
    users.map { |u| u.posts }.flatten.sort_by { |post| post.created_at }.reverse
  end
end
