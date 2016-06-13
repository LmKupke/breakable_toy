class EventsController < AuthenticateController

  def index
    @events = all_upcoming(current_user)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user
    @event.fix_datetime
    if @event.save
      redirect_to event_path(@event.id)
    else
      flash[:alert] = "Date can not be in the past. If event is today start time can not be in the past"
      redirect_to new_event_path
    end
  end

  def show
    @event = Event.find(params[:id])
    @venueselection = Venueselection.where(event: @event )
    if @venueselection.empty?
      @current_page = "event-show-no-venues"
    else
      @sectionpage = "eventsshow"
    end
  end

  def all_upcoming(user)
    events = []
    invites = []
    events = Event.where("organizer_id = ? AND date >= ?", user, Time.zone.now).order(date: :asc, start_time: :asc)
    invites = Invite.where(invitee: user, status: "Attending")

    invites = invites.select do |invite|
      invite.event.date >= Time.zone.now
    end

    invites = invites.map do |invite|
      invite.event
    end

    all_events = events + invites
    all_events.sort_by {|e| e.date }
  end

  def event_params
    params.require(:event).permit(:name, :date, :start_time)
  end
end
