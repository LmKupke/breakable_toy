class VenueselectionsController < AuthenticateController
  def create
    event = params["event"]
    venue = params["venue"]
    user = current_user
    @possiblepast = Venueselection.find_by(event_id: event, user_id: user)
    @duplicates = Venueselection.where(event_id: event, venue_id: venue)
    if @possiblepast.nil? == false
      flash[:alert] = "Sorry you can only make one selection! To change your selection just update."
    elsif @duplicates.empty? == false
      flash[:alert] = "Sorry one of your friends already selected that place!"
    else
    Venueselection.create(event_id: event, venue_id: venue, user: user)
    end
    redirect_to event_path(event)
  end
end
