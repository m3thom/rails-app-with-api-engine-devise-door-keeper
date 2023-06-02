module Api
  class ApplicationController < ActionController::API
    before_action :doorkeeper_authorize!

    # Find the user that owns the access token
    def current_resource_owner
      @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    alias :current_user :current_resource_owner

  end
end
