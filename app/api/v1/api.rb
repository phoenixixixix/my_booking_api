module V1
  class API < Grape::API
    version "v1", using: :path
    mount V1::Properties
  end
end
