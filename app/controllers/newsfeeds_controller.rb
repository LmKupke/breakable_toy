class NewsfeedsController < AuthenticateController
  def index
    @user = current_user
    @friends = graph.friendlist
    array = @friends.map { |user| user["id"]}
    fr = User.where(uid: array)
    @friendevents= fr.map(&:newsfeed_events).flatten.uniq
    @friendevents = @friendevents - current_user.events
    @friendevents = @friendevents.reject { |c| c.nil? }
  end

  private

  def graph
    @graph ||= Graph.new(current_user)
  end
end
