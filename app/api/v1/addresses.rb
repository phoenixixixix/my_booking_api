require_relative "token_requireable"

module V1
  class Addresses < Grape::API
    include V1::TokenRequireable

    resource :addresses do
      desc "Update address"
      params do
        optional :country, type: String
        optional :city, type: String
        optional :street, type: String
        optional :phone_number, type: String
      end
      route_param :id, type: Integer do
        put do
          address = Address.find(params[:id])
          authorize address, :update?
          address.update(declared(params))

          { message: "Address updated successfully" }

        rescue ActiveRecord::RecordNotFound
          error!("Record Not Found", 404)
        end
      end
    end
  end
end
