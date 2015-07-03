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
      refresh_token = RefreshToken.new({user: @user})
      refresh_token.save()
      render json: {auth_token:  token, refresh_token: refresh_token.token}
    else
      respond_bad_request('The username could not be found in the system.')
    end
  end

  def refresh
    refresh_token = RefreshToken.where(token: params[:refresh_token]).first
    if not refresh_token
      return respond_not_found('Token was not found')
    end
    user = User.find(refresh_token.user)
    token = JsonWebToken.encode({user_id: user.id}, 3.hours.from_now)
    render json: {auth_token: token}
  end

  def destroy
    # Deactivate the JWT token
    # Add the deactivate JWT to the inactive tokens cache
  end
end
