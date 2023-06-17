module V1
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
    end
  end
end
