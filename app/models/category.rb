class Category < ActiveRecord::Base
  include Slugable
  
  has_many :post_categories
  has_many :posts, through: :post_categories
  
  validates :name, presence: true, length: {minimum: 3}, uniqueness: true
  
  sluggable_column :name  
  
end