class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates :comment, presence: true
  
  has_one :notification, as: :subject, dependent: :destroy
  
  after_create_commit :create_notifications
  
   private
   
  def create_notifications
    Notification.create(subject: self, customer: self.post.customer, action_type: :commented_to_own_post)
  end
  
end
