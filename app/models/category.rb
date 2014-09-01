class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  
  before_save :generate_slug
  
  validates :name, presence: true, length: {minimum: 3}, uniqueness: true
  
  def generate_slug
    self.slug = self.name.gsub(' ', '-').downcase
  end
  
  def to_param
    self.slug
  end
  
end