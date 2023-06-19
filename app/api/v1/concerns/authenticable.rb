module V1
  module Concerns
    module Authenticable
      extend ActiveSupport::Concern

      included do
        before { authenticate_user_using_x_auth_token }

        helpers do
          attr_reader :current_user

          def authenticate_user_using_x_auth_token
            user_email = request.headers["X-Auth-Email"].presence
            auth_token = request.headers["X-Auth-Token"].presence
            user = user_email && User.find_by!(email: user_email)
            is_valid_token = user && auth_token && ActiveSupport::SecurityUtils.secure_compare(user.authentication_tokens.valid.first.token, auth_token)

            if is_valid_token
              @current_user = user
            else
              error!("Not authorized", 401)
            end
          end
        end
      end
    end
  end
end
