class Comment < ActiveRecord::Base
  include VoteableDarren
  
  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  
  validates :body, presence: true, length: {minimum: 3}
  
end