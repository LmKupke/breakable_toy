class UsersController < AuthenticateController
  def show
    @user = User.find(params["id"])
  end
end
