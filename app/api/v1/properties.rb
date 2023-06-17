require_relative "token_requireable"

module V1
  class Properties < Grape::API
    include V1::TokenRequireable

    resources :properties do
      desc "List properties"
      params do
        optional :assets, type: Array[String]
        optional :country, type: String
        optional :city, type: String
      end
      get do
        properties = policy_scope(Property)
        properties = properties.with_specified_assets(params[:assets]) if params[:assets]
        if params[:country] || params[:city]
          properties = properties.with_location(country: params[:country], city: params[:city])
        end

        properties
      end

      desc "Creates a property"
      params do
        requires :title, type: String, allow_blank: false
        requires :placement_type, type: String, allow_blank: false
      end
      post do
        property = Property.new(declared(params))
        authorize property, :create?
        property.save!

        { property: property, message: "Property created successfully" }
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