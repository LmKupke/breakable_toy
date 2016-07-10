class UsersController < AuthenticateController
  def show
    @user = User.find(params["id"])
    @page = params[:page]
    if current_user == @user
      @ownprofile = true
      sort_table(@user,@page)
    else
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
end
