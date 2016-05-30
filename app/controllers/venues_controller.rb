class VenuesController < AuthenticateController
  def index
    @venues = Venue.all
  end

  def show

  end
end
