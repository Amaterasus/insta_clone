class Like < ApplicationRecord
    belongs_to :user 
    belongs_to :post 
    #need to validate current_user is not the creator of posts
end
