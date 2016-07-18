class Graph
  cattr_accessor :client_class
  self.client_class = Koala::Facebook::API

  attr_reader :user, :graph, :event_organizer, :search_string

  def initialize(user, event_organizer=nil)
    @event_organizer = event_organizer
    @user = user
    @graph = self.class.client_class.new(user.token, ENV["FB_APP_SECRET"])
  end

  def friendlist
    @friendlist ||= graph.get_connections("me","friends")
  end

  def friendlist_match(search_string)
    friendmatch(friendlist, search_string)
  end

  def mutual_friendlist
    @mutual_friendlist ||= graph.get_object("#{event_organizer.uid}", {fields: ["context"]})

    @mutual_friendlist["context"]["mutual_friends"]["data"]
  end

  def mutual_friendmatch(search_string)
    friendmatch(mutual_friendlist, search_string)
  end

  private

  def friendmatch(list, search_string)
    match = list.select { |u| u["name"].downcase.strip == search_string }
    if !match.empty?
      User.find_by(uid: match.first["id"])
    end
  end
end
