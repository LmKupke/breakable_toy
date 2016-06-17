class EventsController < AuthenticateController
  def index
    @events = all_upcoming(current_user)
  end

  def new
    @event = Event.new
    @url = events_path
    @method = "post"
  end

  def create
    @eventparams = event_params
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
    # @venueselection = Venueselection.where(event: @event )
    @venueselection = Venueselection.where(event: @event).page(params[:page]).per(12)
    @selected = false
    @venueselection.each do |venue|
      if venue.user == current_user
        @selected = true
      end
    end
    if @venueselection.empty?
      @current_page = "event-show-no-venues"
    else
      @sectionpage = "eventsshow"
    end
  end

  def edit
    @event = Event.find(params["id"])
    if current_user != @event.organizer
      flash[:alert] = "Sorry you're not the event organizer"
      redirect_to newsfeeds_path
    end
    @method = "patch"
    @url = event_path
  end

  def update
    @event = Event.find(params["id"])
    @event.assign_attributes(event_params)
    @event.fix_datetime
    if @event.save
      flash[:notice] = "You updated your event"
      redirect_to event_path(@event)
    else
      flash[:alert] = "Please add values to each of the forms"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params["id"])
    if current_user != @event.organizer
      flash[:alert] = "Sorry you're not the event organizer"
      redirect_to newsfeeds_path
    else
      @event.destroy
      redirect_to events_path
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

  private

  def event_params
    params.require(:event).permit(:name, :date, :start_time, :id, :organizer_id)
  end
end
