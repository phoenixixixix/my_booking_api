module V1
  module Concerns
    module APIExceptions
      extend ActiveSupport::Concern

      included do
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response({
            status: e.status,
            error: e.message,
          }.to_json, 400)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          rack_response({
            status: e.status,
            error: e.message,
          }.to_json, 422)
        end

        rescue_from Pundit::NotAuthorizedError do |e|
          rack_response({
            error: e.message,
          }.to_json, 405)
        end
      end
    end
  end
end
