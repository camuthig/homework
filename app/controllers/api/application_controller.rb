require_dependency 'json_web_token'

class Api::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_current_user, :authenticate_request

  protected

  def authenticate_request
    if not set_current_user
      respond_unauthorized('Invalid or expired token')
    end
  end

  def set_current_user
    # TODO: Make sure the token is not in the invalid cache
    if request.headers['Authorization']
      body = JsonWebToken.decode(request.headers['Authorization'])
      if body
        @current_user = User.find(body['user_id'])
      else
        return
      end
    end
  end

  def respond_error(code, message, status)
    render json: {errorCode: code, errorMessage: message}, :status => status
  end

  # Private: Common ability to handle 403 errors
  def respond_forbidden(message)
    respond_error('forbidden', message, :forbidden)
  end

  def respond_bad_request(message)
    respond_error('bad_request', message, :bad_request)
  end

  def respond_unauthorized(message)
    respond_error('unauthorized', message, :unauthorized)
  end

  def respond_not_found(message)
    respond_error('not_found', message, :not_found)
  end

end
