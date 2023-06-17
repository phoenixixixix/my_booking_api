module V1
  module Entities
    class BookingEntity < Grape::Entity
      expose :from_date
      expose :to_date
    end
  end
end