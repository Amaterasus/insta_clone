class User < ApplicationRecord
    has_many :posts
    has_many :tags 
    has_many :likes
    
   #followers and followee relationship 
    has_many :active_follows, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
    has_many :followees, through: :active_follows, source: :followee
    has_many :passive_follows, class_name: "Follow", foreign_key: :followee_id, dependent: :destroy
    has_many :followers, through: :passive_follows, source: :follower

    validates :user_name, presence: true, uniqueness: true 
    validates :bio,   length: { maximum: 300 } #maximum characters 300


end
