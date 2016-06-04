class EventsController < AuthenticateController

  def index
    @events = Event.where(organizer: current_user).order(date: :asc, start_time: :asc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user

    if @event.save
      redirect_to event_path(@event.id)
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end


  def event_params
    params.require(:event).permit(:name, :date, :start_time)
  end
end
