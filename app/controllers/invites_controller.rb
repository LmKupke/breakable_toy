class InvitesController < AuthenticateController

  def index
    @pending_invites = Invite.upcomingpend(current_user)
  end

  def create
    if friendfind? == false
      flash[:alert] = @alert
    else
      flash[:notice] = @success
    end
    redirect_to event_path(event)
  end

  def friendfind?
    if current_user == event.organizer
      @friendfound = graph.friendlist_match
      if @friendfound
        @existinginvite = Invite.find_by(invitee: @friendfound, event: event)
        if @existinginvite
          @alert = "It seems your friend has already been invited!"
          return false
        else
          invite = Invite.new(inviter: current_user, invitee: @friendfound, event: event)
          if invite.save
            @success = "You have successfully invited your friend, #{@friendfound.name}!"
          else
            @alert = "Hmm something went wrong along the way."
            return false
          end
        end
      else
        @alert = "Either your friend, #{params["search"]}, isn't using the app yet or you spelled their name wrong! Please write their full Facebook name!"
        return false
      end
    else
      @mutual_friend = graph.mutual_friendmatch
      if @mutual_friend.nil?
        @alert = "The #{event.organizer.name} and you have no mutual friends on the app! Let them know about NOMO-FOMO!"
        return false
      else
        invite = Invite.new(inviter: current_user, invitee: @mutual_friend, event: event)
        if invite.save
          @success = "You have successfully invited your shared friend, #{@mutual_friend.name}!"
        else
          @alert = "It seems your friend has already been invited!"
          return false
        end
      end
    end
    @alert = "Either your friend, #{params["search"]}, is not friends with #{event.organizer.name} on Facebook,is not on the app, or you spelled their name wrong! Please write their full Facebook name!"
    return false
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
    @graph ||= Graph.new(current_user, event.organizer, search_string)
  end

  def event
    event ||= Event.find(params[:event_id])
  end
end
