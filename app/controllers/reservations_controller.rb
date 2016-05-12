class ReservationsController < ApplicationController
before_action :find_reservation, only: [:show, :edit, :update, :destroy]


def index
  @reservations = Reservation.all
  @reservations.each do |x|
    @reservation_listing = x.listing
  end
end

def show
  @reservation_listing = @reservation.listing
end

def new
end

def create
  @reservation = Reservation.new(reservation_params)
  @reservation.user_id = current_user.id
  abc = Listing.find(params[:reservation][:listing_id])

  @user_host = User.find(abc.user_id)
  if @reservation.save
    # Tell the UserMailer to send a reservation notice after save
        ReservationMailer.reservation_notice_email(@user_host.id, @reservation.id).deliver_now

        flash[:success] = 'bit bit bit Reservation Successful'


    redirect_to @reservation
  else
    flash[:danger] = 'Date has been picked'
    redirect_to(:back)
  end
end

def edit
end

def update
  if @reservation.update(reservation_params)
    redirect_to "/reservations/#{@reservation.id}"
  else
    flash[:danger] = 'mamamia'
    render :edit
  end
end

def destroy
  @reservation.destroy
  redirect_to @reservation
end

def find_reservation
  @reservation = Reservation.find(params[:id])
end


private

def reservation_params
  params.require(:reservation).permit(:listing_id, :check_in_date, :check_out_date, :pax, :comments)
end

end
