class Map < ApplicationRecord
  has_many :mapguides, dependent: :destroy
  has_many :articles, through: :mapguides
end
