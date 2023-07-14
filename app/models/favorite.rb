class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates_uniqueness_of :post_id, scope: :customer_id
  
  has_one :notification, as: :subject, dependent: :destroy
  
  after_create_commit :create_notifications
  
   private
   
  def create_notifications
    Notification.create(subject: self, customer: self.post.customer, action_type: :liked_to_own_post)
  end
  
end
