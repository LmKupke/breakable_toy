class KoalaFake
  def initialize(token, secret)
    binding.pry
  end

  def get_connections(arg1, arg2)
   binding.pry
   end

  def get_object(arg1, arg2)
   binding.pry
  end
end


def friendfind?
  if current_user == event.organizer
    @friendfound = graph.friendlist_match
    if @friendfound
      sendInvite(@friendfound, event, current_user)



    def sendInvite(@friendfound, event, user)
      @existing = Invite.find_by(invitee: @friendfound, event: event )
      if @existing
        @alert = "It seems your friend has already been invited!"
        return false
      else
        invite = Invite.new(inviter: user, invitee: @friendfound, event:)
      end
    end

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
