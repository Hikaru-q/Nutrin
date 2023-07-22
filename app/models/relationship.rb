class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"
  
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

   private
   
  def create_notifications
    Notification.create(subject: self, customer: followed, action_type: :followed_me)
  end
  
end
