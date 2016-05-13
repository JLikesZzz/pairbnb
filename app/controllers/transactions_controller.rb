class TransactionsController < ApplicationController

  def new
      @client_token = Braintree::ClientToken.generate
      @transaction = Transaction.new
      @reservation = Reservation.find(params[:reservation_id])
  end

    def create

      @reservation = Reservation.find(params[:reservation_id])
      @user = @reservation.listing
      @user_host = @user.user
      nonce = params[:payment_method_nonce]
      render action: :new and return unless nonce
      result = Braintree::Transaction.sale(
        amount: "#{@reservation.total_price}",
        payment_method_nonce: params[:payment_method_nonce]
      )
      if result.success?
        @reservation.update(payment_made: true)
        ReservationJob.perform_later(@user_host.id, @reservation.id)
        flash[:success] = "Congraulations! Your transaction has been successful!"
        redirect_to reservations_path
      else
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        gon.client_token = generate_client_token
        render :new
      end
    end


    def reservation_params
      params.require(:transaction).permit(:reservation_id)
    end


end
