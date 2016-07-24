class UsersController < AuthenticateController
  def show
    @user = User.find(params["id"])
    @page = params[:page]
    if current_user == friend
      friendsarray
      @ownprofile = true
      sort_table(@user,@page)
    else
      mutualsarray
      @ownprofile = false
      sort_table(@user,@page)
    end
  end


  private

  def sort_table(user,page)
    if current_user == friend
      if params[:order]
        sort_value = params[:order].split(",").map do |field|
        "#{field} #{params[:sort_mode]}"
        end.join(",")
        arrayallevents
        @events = Event.where(id:@arrayeventids).order(sort_value).page(page)
        return @events
      else
        arrayallevents
        @events = Event.where(id:@arrayeventids).page(page)
        return @events
      end
    else
      return @events = past_events(@user)
    end
  end

  def arrayallevents
    @eventorgs = Event.where(organizer: @user)
    @invites = Invite.where(invitee: @user, status: "Attending")
    arrayinviteevents = @invites.map(&:event) + @eventorgs
    @arrayeventids ||= arrayinviteevents.map(&:id)
  end

  def graph
    @graph ||= Graph.new(current_user, friend)
  end

  def friendgraph
    @graph ||= Graph.new(friend, current_user)
  end

  def friend
    @user ||= User.find(params["id"])
  end

  def friendsarray
    array = graph.friendlist.map { |user| user["id"] }
    @friendlist ||= User.where(uid: array)
  end

  def mutualsarray
    friendgraph
    friendsarray
    array = graph.mutual_friendlist.map { |user| user["id"] }
    @mutuallist = User.where(uid: array)
    @mutuallist ||= @mutuallist + current_user
  end

  def past_events(user)
    @a = Event.where("organizer_id = ? AND date <= ?", user, Time.zone.now ).order(date: :desc, start_time: :asc).limit(5)
    return @a
  end
end
