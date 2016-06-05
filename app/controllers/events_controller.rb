class EventsController < AuthenticateController

  def index
    # @events = Event.where(organizer: current_user).order(date: :asc, start_time: :asc)
    @events = Event.upcoming(current_user, Time.now.utc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user
    binding.pry
    @event.fix_datetime(params["event"]['date'],params["event"]['start_time'])
    if @event.save
      redirect_to event_path(@event.id)
    else
      flash[:alert] = "Date can not be in the past. If event is today start time can not be in the past"
      redirect_to new_event_path
    end
  end

  def show
    @event = Event.find(params[:id])
  end


  def event_params
    params.require(:event).permit(:name, :date, :start_time)
  end
end
