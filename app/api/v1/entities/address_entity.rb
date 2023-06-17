module V1
  module Entities
    class AddressEntity < Grape::Entity
      expose :country
      expose :city
      expose :street
      expose :phone_number
    end
  end
end