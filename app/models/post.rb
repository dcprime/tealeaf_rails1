class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable
  
  before_save :generate_slug
  
  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  
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
  
  def generate_slug
    self.slug = self.title.gsub(' ', '-').downcase
  end
  
  def to_param
    self.slug
  end
  
end