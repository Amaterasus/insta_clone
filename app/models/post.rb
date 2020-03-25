class Post < ApplicationRecord
    belongs_to :user
    has_many :tags 
    has_many :likes
    validates :title, presence: true
    validates :image, presence: true

end
