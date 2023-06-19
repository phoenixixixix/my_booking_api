require_relative "concerns/api_exceptions"

module V1
  class API < Grape::API
    helpers Pundit::Authorization
    include V1::Concerns::APIExceptions

    version "v1", using: :path
    mount V1::Properties
    mount V1::Bookings
    mount V1::Assets
    mount V1::Addresses
    mount V1::Login
    mount V1::Register
  end
end
