class Article < ApplicationRecord
  has_one_attached :image
  has_rich_text :content
  has_many :articles_categories
  has_many :categories, through: :articles_categories
end
