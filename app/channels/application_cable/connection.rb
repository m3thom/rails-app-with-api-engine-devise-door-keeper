module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      token = request.params[AnyCable.config.jwt_id_param]

      identifiers = AnyCable::Rails::JWT.decode(token)
      identifiers.each do |k, v|
        public_send("#{k}=", v)
      end
    rescue JWT::DecodeError
      reject_unauthorized_connection
    end

    private

    # Overload the +ActionCable::Connection::Base+ to handle JWT expiration
    # as rejected connection with a specific reason.
    # (in AnyCable this check is <also> done by the `anycable-go` server).
    def handle_open
      super
    rescue JWT::ExpiredSignature
      logger.error "An expired JWT token was rejected"
      close(reason: "token_expired", reconnect: false) if websocket.alive?
    end
  end
end
