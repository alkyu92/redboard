class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, length: {maximum: 140}

  self.per_page = 10
  
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "Image should be less than 5MB")
      end
    end
end
