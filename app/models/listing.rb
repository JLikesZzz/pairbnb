class Listing < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :room_type, presence: true
  validates :home_type, presence: true
  validates :address, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :accommodates, presence: true
  validates :min_stay, presence: true


end