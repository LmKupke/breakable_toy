class NewsfeedsController < AuthenticateController
  def index
    @current_page = "newsfeed"
    @user = current_user
    @friends = graph.friendlist
    array = @friends.map { |user| user["id"]}
    fr = User.where(uid: array)
    @friendevents = fr.map(&:newsfeed_events).flatten.uniq
    @friendevents = @friendevents - current_user.events
    @friendevents = @friendevents.reject { |c| c.nil? }
    @notifications = @friendevents.map(&:notifications).flatten
    events = []
    @notifications.each do |notification|
      if notification.user == current_user
        events << notification.event
      end
    end
    @friendevents = @friendevents - events
  end

  private

  def graph
    @graph ||= Graph.new(current_user)
  end
end
