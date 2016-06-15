class NewsfeedsController < AuthenticateController
  def index
    @user = current_user
    @graph = Koala::Facebook::API.new(current_user.token, ENV["FB_APP_SECRET"])
    @friends = @graph.get_connections("me", "friends")
    array = @friends.map { |user| user["id"]}
    fr = User.where(uid: array)
    @friendevents= fr.map(&:all_events).flatten.uniq
    @friendevents = @friendevents - current_user.events
    @friendevents = @friendevents.reject { |c| c.nil? }
  end
end
