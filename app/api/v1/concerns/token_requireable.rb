module V1
  module Concerns
    module TokenRequireable
      extend ActiveSupport::Concern

      included do
        before { valid_token! }

        helpers do
          def valid_token!
            raise ActionController::BadRequest unless AuthenticationToken.valid?(params[:token])
          rescue ActionController::BadRequest
            error!("Not authorized", 401)
          end
        end
      end
    end
  end
end
