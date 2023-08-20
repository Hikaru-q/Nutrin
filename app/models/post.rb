class Post < ApplicationRecord
  has_one_attached :image
  
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  has_one :notification, as: :subject, dependent: :destroy
  
  validates :post_name, presence: true
  validates :description, presence: true
  validates :material, presence: true
  validates :recipe, presence: true
  validates :nutrition, presence: true
  validates :image, presence: true
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  
  def self.ransackable_attributes(auth_object = nil)
    [ "post_name"]
  end
  
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
  
end
