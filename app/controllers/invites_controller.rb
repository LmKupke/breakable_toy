class InvitesController < AuthenticateController

  def index
    @pending_invites = Invite.upcomingpend(current_user)
  end

  def create
    @friend = friend_search
    if @friend && already_invited?(@friend).nil?
      @invite = Invite.new(inviter: current_user, invitee: @friend, event: event)
      if @invite.save
        flash[:notice] = "You successfully added #{@friend.name}!"
      else
        flash[:alert] = @invite.errors.full_messages.join(", ")
      end
    else
      flash[:alert] = "Your friend, #{params[:search]} is either not on the app, or already invited."
    end
    redirect_to event_path(event)
  end

  def update
    @invite = Invite.find(invite_params["id"])
    @invite.update(status: invite_params["status"])
    if @invite.status == "Attending"
      flash[:notice] = "You are now attending the upcoming event."
    else
      flash[:notice] = "You declined the invitation to the event."
    end
    redirect_to invites_path
  end

  private

  def invite_params
    params.require(:invite).permit(:status, :id)
  end

  def search_string
    params["search"].downcase.strip
  end

  def graph
    @graph ||= Graph.new(current_user, event.organizer)
  end

  def event
    event ||= Event.find(params[:event_id])
  end

  def friend_search
    if current_user == event.organizer
      graph.friendlist_match(search_string)
    else
      graph.mutual_friendmatch(search_string)
    end
  end

  def already_invited?(friend)
    var = Invite.find_by(invitee: friend, event: event )
  end
end
