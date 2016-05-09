class ListingsController < ApplicationController
before_action :find_listing, only: [:show, :edit, :update, :destroy]


  #all the listings that belongs to current_user
  def index
    if params[:tag]
        @listings = current_user.listings.tagged_with(params[:tag])
    else
        @listings = current_user.listings.all
    end
  end

  #just one specific listing
  def show
  end

  #get the page that lets you create a new post
  def new
    @listing = Listing.new
  end

  #post the data
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    if @listing.save
      redirect_to "/listings/#{@listing.id}"
    else
      render :new
    end
  end

  #get the page that lets you edit an existing post
  def edit
  end

  #put the data you just filled out to edit the post back to the serber so it can perform the updated
  def update

    if @listing.update(listing_params)
      redirect_to "/listings/#{@listing.id}"
    else
      flash[:warning] = 'Y U DO THIS'
      render :edit
    end
  end

  #delete one specific post by sending a delete request to the server
  def destroy
    @listing.destroy
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :tag_list, :price, :description, :room_type, :home_type, :address, :country, :state, :zip_code, :accommodates, :min_stay)
  end


end
