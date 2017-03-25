class Blog < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}

  validates :blog_content,    presence: true
  validates :user_id,         presence: true
  validates :blog_title,      presence: true
  validates :blog_subtitle,   presence: true
end
