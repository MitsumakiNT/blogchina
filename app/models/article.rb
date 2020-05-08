class Article < ApplicationRecord
  has_one_attached :image
  has_rich_text :content
  has_many :mapguides, dependent: :destroy
  has_many :maps, through: :mapguides




  def save_articles(maps)
    current_maps = self.maps.pluck(:tag_name) unless self.maps.nil?
    old_maps = current_maps - maps
    new_maps = maps - current_maps

    # Destroy
    old_maps.each do |old_name|
      self.maps.delete Map.find_by(tag_name:old_name)
    end

    # Create
    new_maps.each do |new_name|
      blog_map = Map.find_or_create_by(tag_name:new_name)
      self.maps << blog_map
    end
  end
end
