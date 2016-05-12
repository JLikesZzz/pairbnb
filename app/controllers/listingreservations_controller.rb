
class ListingreservationsController < ApplicationController

def index
  @all_listing = current_user.listings
end

end
