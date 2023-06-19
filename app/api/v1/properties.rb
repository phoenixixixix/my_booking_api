require_relative "concerns/token_requireable"

module V1
  class Properties < Grape::API
    include V1::Concerns::Authenticable
    include Grape::Kaminari

    resources :properties do
      desc "List properties"
      params do
        use :pagination, per_page: 10
        optional :assets, type: Array[String]
        optional :country, type: String
        optional :city, type: String
      end
      get do
        properties = policy_scope(Property).includes(:assets, :address, :bookings)
        properties = properties.with_specified_assets(params[:assets]) if params[:assets]
        if params[:country] || params[:city]
          properties = properties.with_location(country: params[:country], city: params[:city])
        end

        present :properties, paginate(properties), with: Entities::PropertyEntity
      end

      desc "Creates a property"
      params do
        requires :property, type: Hash do
          requires :title, type: String
          requires :placement_type, type: String
        end
        requires :address, type: Hash do
          requires :country, type: String
          requires :city, type: String
          requires :street, type: String
          requires :phone_number, type: String
        end
      end
      post do
        property = Property.new(params[:property])
        address = property.build_address(params[:address])
        authorize property, :create?

        if property.valid? && address.valid?
          property.save!
          address.save!

          { property: property, address: address, message: "Property created successfully" }
        end
      end

      desc "Update existing property"
      params do
        optional :title, type: String, allow_blank: false
        optional :placement_type, type: String, allow_blank: false
      end
      route_param :id, type: Integer do
        put do
          property = Property.find(params[:id])
          authorize property, :update?
          property.update(declared(params))

          { message: "Property updated successfully" }

        rescue ActiveRecord::RecordNotFound
          error!("Record Not Found", 404)
        end
      end

      desc "Deletes existing property"
      route_param :id, type: Integer do
        delete do
          property = Property.find(params[:id])
          authorize property, :destroy?
          property.destroy!

          { message: "Property deleted successfully" }

        rescue ActiveRecord::RecordNotFound
          error!("Record Not Found", 404)
        end
      end
    end
  end
end