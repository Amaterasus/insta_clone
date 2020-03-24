class Post < ApplicationRecord
    belongs_to :user
    has_many :tags 
    has_many :likes

end
