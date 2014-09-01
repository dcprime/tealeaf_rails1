class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :votes, as: :voteable
  
  validates :body, presence: true, length: {minimum: 3}
  
  def vote_display
    if self.total_votes == 1 || self.total_votes == -1
      return " vote"
    else
      return " votes"
    end
  end
  
  def total_votes
    up_votes - down_votes
  end
  
  def up_votes
    self.votes.where(vote: true).size
  end
  
  def down_votes
    self.votes.where(vote: false).size
  end
end