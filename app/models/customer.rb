class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum is_deleted: { exist: false, withdraw: true }
  
  has_one_attached :profile_image
  
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following_customers, through: :followers, source: :followed
  has_many :follower_customers, through: :followeds, source: :follower

  validates :name, :email, presence: true
  validates :introduction, length: { maximum: 200 }
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.name = 'ゲストユーザー'
      customer.password = SecureRandom.urlsafe_base64
    end
  end
  
  def guest_user?
    email == 'guest@example.com'
  end
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # フォローしたときの処理
  def follow(customer_id)
    followers.create(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
    followers.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定
  def following?(customer)
    following_customers.include?(customer)
  end
  
  def self.ransackable_attributes(auth_object = nil)
    [ "name"]
  end
  
end
