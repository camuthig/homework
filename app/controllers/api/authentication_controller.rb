require_dependency 'json_web_token'

class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :set_current_user, :authenticate_request

  def new
  end

  def create
    # TODO: Add password checking here
    @user = User.where(username: params[:username]).first
    if @user
      # generate a JWT and refresh token and return it
      token = JsonWebToken.encode({user_id: @user.id}, 3.hours.from_now)
      render json: { auth_token:  token}
    else
      respond_bad_request('The username could not be found in the system.')
    end
  end

  def refresh
    # Verify the refresh token and the user
    # Create a new JWT and return it
  end

  def destroy
    # Deactivate the JWT token
  end
end
