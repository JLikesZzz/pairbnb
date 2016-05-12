class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :user_id, presence: true
  validates :listing_id, presence: true
  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :pax, presence: true

  validate :uniqueness_of_data_range


  def uniqueness_of_data_range
    errors.add(:check_in_date, "is not available") unless listing.reservations.where("? >= check_in_date AND ? <= check_out_date", check_in_date, check_in_date).count == 0
    errors.add(:check_out_date, "is not available") unless listing.reservations.where("? >= check_in_date AND ? <= check_out_date", check_out_date, check_out_date).count == 0
  end


end
