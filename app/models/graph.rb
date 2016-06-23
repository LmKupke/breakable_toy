class Graph
  attr_reader :user, :graph, :event_organizer, :search_string

  def initialize(user, event_organizer, search_string="")
    @user = user
    @graph = Koala::Facebook::API.new(user.token, ENV["FB_APP_SECRET"])
    @event_organizer = event_organizer
    @search_string = search_string
  end

  def friendlist
    @friendlist ||= graph.get_connections("me","friends")
  end

  def friendlist_match
    friendmatch(friendlist)
  end

  def mutual_friendlist
    @mutual_friendlist ||= graph.get_object("#{event_organizer.uid}", {fields: ["context"]})
    @mutual_friendlist["context"]["mutual_friends"]["data"]
  end

  def mutual_friendmatch
    friendmatch(mutual_friendlist)
  end

  def friendmatch(list)
    match = list.select { |u| u["name"].downcase.strip == search_string }
    if !match.empty?
      User.find_by(uid: match.first["id"])
    end
  end
end
