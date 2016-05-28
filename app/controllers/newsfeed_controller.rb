class NewsfeedController < AuthenticateController
  def index
    @user = current_user
  end
end
