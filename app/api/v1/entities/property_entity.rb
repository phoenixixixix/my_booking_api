module V1
  module Entities
    class PropertyEntity < Grape::Entity
      expose :title
      expose :placement_type
      expose :assets, using: V1::Entities::AssetEntity
      expose :address, using: V1::Entities::AddressEntity
      expose :bookings, using: V1::Entities::BookingEntity
    end
  end
end