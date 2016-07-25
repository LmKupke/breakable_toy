class Api:NewsfeedsController < AuthenticateController
  def index

  end

  def notify(event)
    if event.organizer.phonenumber == nil && current_user.phonenumber == nil

    elsif event.organizer.phonenumber != nil && current_user.phonenumber == nil

    elsif event.organizer.phonenumber == nil && current_user.phonenumber != nil

    else
      client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      message = client.messages.create from: '+16172063319', to: event.organizer.phonenumber, body: "Your friend #{current_user.name} wants to join your Event, #{event.name} on NOMO-FOMO! Invite them to it!"
      render plain: message.status
    end
  end
end
