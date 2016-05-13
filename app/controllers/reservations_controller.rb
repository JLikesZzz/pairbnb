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
  @transaction=Transaction.new
end

def create


  abc = Listing.find(params[:reservation][:listing_id])


  date = params[:reservation][:datefilter]
   # split_date = date.scan(/\d{2}\D\d{2}\D\d{4}/)
   split_date = date.split(' - ')

   check_in = split_date[0]
   check_out = split_date[1]

   check_in_date = DateTime.parse(check_in).strftime("%d-%m-%Y")
   check_out_date = DateTime.parse(check_out).strftime("%d-%m-%Y")
   @reservation = Reservation.new(check_in_date: check_in_date, check_out_date: check_out_date, listing_id: params[:reservation][:listing_id], pax: params[:reservation][:pax], comments: params[:reservation][:comments])

   date_diff = (@reservation.check_out_date - @reservation.check_in_date).to_i

   @reservation.total_price = date_diff * @reservation.listing.price

   @reservation.user_id = current_user.id

  if @reservation.save
    @user_host = @reservation.listing.user

    # Tell the UserMailer to send a reservation notice after save
        # ReservationJob.perform_later(@user_host.id, @reservation.id)

        # flash[:success] = 'bit bit bit Reservation Successful'
        redirect_to new_reservation_transaction_path(@reservation)
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

  respond_to do |format|
    format.html { redirect_to @reservation }
    format.js
  end


end

def find_reservation
  @reservation = Reservation.find(params[:id])
end


private

def reservation_params
  params.require(:reservation).permit(:listing_id, :check_in_date, :check_out_date, :pax, :comments)
end

end
