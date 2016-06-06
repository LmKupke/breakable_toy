class VenuesController < AuthenticateController
  def index
    @venues = Venue.all
    @event = params["event_id"]
    if params[:search]
      @venues = Venue.search(params[:search])
      if @venues.size == nil || @venues.size == 0
        flash[:notice] = "Seems like our database doesn't have that spot! Here are some results from Yelp."
        parameters = { term: params[:search], limit: 20, category_filter: 'danceclubs,bars,poolhalls,pianobars,beergardens' }
        @yelpvenues = Yelp.client.search('Boston', parameters)
        @yelpvenues = @yelpvenues.businesses
      end
    end
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def create
    @yelpvenue = JSON.parse(params["spot"])
    venuecategory = []
    @yelpvenue['categories'].each do |category|
      venuecategory << category[0]
    end

    @venue = Venue.find_or_create_by(yelp_id: @yelpvenue['id']) do |u|
      u.name = @yelpvenue['name']
      u.phone = @yelpvenue['display_phone']
      u.category = venuecategory
      u.address = @yelpvenue['location']['address'][0]
      u.city = @yelpvenue['location']['city']
      u.postal_code = @yelpvenue['location']['postal_code']
      u.state_code = @yelpvenue['location']['state_code']
      u.postal_code = @yelpvenue['location']['postal_code']
      u.rating = @yelpvenue['rating']
      u.photo = @yelpvenue['image_url']
      u.latitude = @yelpvenue['location']['coordinate']['latitude']
      u.longitude = @yelpvenue['location']['coordinate']['longitude']
      u.url = @yelpvenue['url']
    end

    if @venue.valid?
      @venue.save
      flash[:notice] = "Thanks for adding this bar to our database!"
      redirect_to venue_path(@venue)
    else
      flash[:alert] = "Sorry that bar or club already exists in the database please search that name instead"
      @venues = 0
      render 'index'
    end
  end
end
