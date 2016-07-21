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
      @events = Event.past_events(@user).limit(5)
    end
  end


  private

  def sort_table(user,page)
    if params[:order]
      sort_value = params[:order].split(",").map do |field|
        "#{field} #{params[:sort_mode]}"
      end.join(",")
      return @events = Event.where(organizer: @user).order(sort_value).page(page)
    else
      return @events = Event.where(organizer: @user).page(page)
    end
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
end
