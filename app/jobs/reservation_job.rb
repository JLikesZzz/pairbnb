class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, reservation_id)
    # Do something later

    ReservationMailer.reservation_notice_email(user_id, reservation_id).deliver_now
  end
end
