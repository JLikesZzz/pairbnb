class User < ActiveRecord::Base
  include Clearance::User

  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :reservations
  validates :first_name, presence: true

  mount_uploader :avatar, AvatarUploader

  def self.create_with_auth_and_hash(authentication,auth_hash)
   create! do |u|
     u.first_name = auth_hash["info"]["first_name"]
     u.last_name = auth_hash["info"]["last_name"]
     u.email = auth_hash["extra"]["raw_info"]["email"]
     u.encrypted_password = SecureRandom.urlsafe_base64
     u.remember_token = SecureRandom.urlsafe_base64
     u.authentications<<(authentication)
   end
  end

  def fb_token
   x = self.authentications.where(:provider => :facebook).first
   return x.token unless x.nil?
  end

  def password_optional?
   true
  end


  # def get_reservations(reservation_id)
  #   Reservation.find(reservation_id)
  # end
  #
  # def reservation_total_price
  #   total_price = 0
  #   get_reservations.each { |reservation| total_price+= reservation.total_price }
  #   total_price
  # end
  #
  # def purchase_cart_reservations!
  #   get_reservations.each { |reservation| purchase(reservation) }
  # end
  #
  # def purchase(reservation)
  #   reservations << reservation
  # end



end
