class Api::NewsfeedsController < AuthenticateController
  # before_action :find_event
  def index

  end

  def notify
    event = Event.find(params["format"])
    if event.organizer.phonenumber == nil && current_user.phonenumber == nil
      flash[:alert] = "Your phonenumber and #{event.organizer.name}'s number is not saved!"
    elsif event.organizer.phonenumber != nil && current_user.phonenumber == nil
      flash[:alert] =  "Your phonenumber is not saved! Please add your number so you can ping the #{event.organizer.name}. To add your phonenumber go to your profile!"
    elsif event.organizer.phonenumber == nil && current_user.phonenumber != nil
      flash[:alert] = "Seems like #{event.organizer.name} doesn't have their number on NOMO-FOMO. Text them and let them know to added it."
    else
      client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      message = client.messages.create from: '+16172063319', to: "+1#{event.organizer.phonenumber}", body: "Your friend #{current_user.name} wants to join your Event, #{event.name} on NOMO-FOMO! Invite them to it!"
      # render plain: message.status
      Notification.create(user: current_user, event: event)
    end
    redirect_to newsfeeds_path
  end
end
