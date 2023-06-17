require_relative "concerns/token_requireable"

module V1
  class Bookings < Grape::API
    include V1::Concerns::TokenRequireable

    resource :bookings do
      desc "Creates a booking"
      params do
        optional :user_id, type: Integer
        requires :property_id, type: Integer
        requires :from_date, type: String
        requires :to_date, type: String
      end
      post do
        booking = Booking.new(declared(params))
        if current_user.admin? && params[:user_id]
          booking.user_id = params[:user_id]
        else
          booking.user_id = current_user.id
        end
        authorize booking, :create?
        booking.save!

        { booking: booking, message: "Property created successfully" }
      end
    end
  end
end
