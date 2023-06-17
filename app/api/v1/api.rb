require_relative "api_exceptions"

module V1
  class API < Grape::API
    include V1::APIExceptions

    version "v1", using: :path
    mount V1::Properties
    mount V1::Login
    mount V1::Register
  end
end
