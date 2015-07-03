class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      return JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      pieces = token.split(" ")
      # Only accept Bearer tokens
      if not pieces[0] == 'Bearer'
        return;
      end
      body = JWT.decode(pieces[1], Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    #rescue
      # we don't need to throw errors, just return nil if JWT is invalid or expired
      #nil
    end
  end
end