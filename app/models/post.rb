class Post < ApplicationRecord
  has_one_attached :image
  
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :post_name, presence: true
  validates :description, presence: true
  validates :material, presence: true
  validates :recipe, presence: true
  validates :nutrition, presence: true
  validates :image, presence: true
  
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
  
end
