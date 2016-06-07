class EventsController < AuthenticateController

  def index
    @events = Event.upcoming(current_user, Time.zone.now)
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
    @sectionpage = "eventsshow"
    @event = Event.find(params[:id])
    @venueselection = Venueselection.where(event: @event )
  end


  def event_params
    params.require(:event).permit(:name, :date, :start_time)
  end
end
