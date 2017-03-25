class Certificate < ApplicationRecord
  belongs_to :user
  validates :name,        presence: true
  validates :department,  presence: true
  validates :birthdate,   presence: true
  validates :graduation,  presence: true
  validates :copies,      presence: true
  validates :language,    presence: true
  validates :phone,       presence: true
end
