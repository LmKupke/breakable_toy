class VenueselectionsController < AuthenticateController
  def create
    event = params["event"]
    venue = params["venue"]
    user = current_user
    Venueselection.create(event_id: event, venue_id: venue, user: user)
    redirect_to event_path(event)
  end
end
