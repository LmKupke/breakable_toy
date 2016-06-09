class InvitesController < AuthenticateController
  def create
    if friendfind? == false
      flash[:alert] = @alert
    else
      flash[:notice] = @success
    end
    redirect_to event_path(@event)
  end


  def friendfind?
    @graph = Koala::Facebook::API.new(current_user.token)
    event_id = params["event_id"]
    @event = Event.find(event_id)
    @friendsearch = params["search"]
    if current_user == @event.organizer
      friendlist = @graph.get_connections("me","friends")
      friendlist.each do |friend|
        if friend["name"] == @friendsearch
          @friendfound = User.find_by(uid: friend["id"])
          invite = Invite.new(inviter: current_user, invitee: @friendfound, event: @event)
          if invite.valid?
            invite.save
            @success = "You have successfully invited your friend, #{@friendfound.name}!"
            return true
          else
            @alert = "It seems your friend has already been invited!"
            return false
          end
        end
      end
      @alert = "Either your friend, #{@friendsearch}, isn't using the app yet or you spelled their name wrong! Please write their full Facebook name!"
      return false
    else
      @mutualfriends = @graph.get_connections("me","mutualfriends/#{@event.organizer.uid}")
      @mutualfriends.each do |mutual|
        if mutual["name"] == @friendsearch
          @mutualfound = User.find_by(uid: mutual["id"])
          invite = Invite.new(inviter: current_user, invitee: @mutualfound, event: @event)
          if invite.valid?
            invite.save
            @success = "You have successfully invited your shared friend, #{@friendfound.name}!"
            return true
          else
            @alert = "It seems your friend has already been invited!"
            return false
          end
        end
      end
      @alert = "Either your mutual friend, #{@friendsearch}, with #{@event.organizer.name} is not on the app or you spelled their name wrong! Please write their full Facebook name!"
      return false
    end
  end


end
