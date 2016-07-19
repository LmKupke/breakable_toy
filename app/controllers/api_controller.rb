class ApiController < AuthenticateController
  protect_from_forgery with: :exception
end
