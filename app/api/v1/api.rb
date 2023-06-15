module V1
  class API < Grape::API
    version "v1", using: :path
    mount V1::Properties
    mount V1::Login
    mount V1::Register

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
