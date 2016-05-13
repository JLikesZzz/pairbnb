class ReservationMailer < ApplicationMailer

  def reservation_notice_email(user_id, reservation_id)
    
    @user = User.find(user_id)

    @reservation = Reservation.find(reservation_id)
    @url = 'http://localhost:3000/listingreservations'

    mail(to: @user.email, subject: 'A reservation is made!')
  end
end
