module V1
  class Properties < Grape::API
    resources :properties do
      desc "List properties"
      params do
        optional :assets, type: Array[String]
      end
      get do
        properties = Property.all
        properties = properties.with_specified_assets(params[:assets]) if params[:assets]

        properties
      end

      desc "Creates a property"
      params do
        requires :title, type: String, allow_blank: false
        requires :placement_type, type: String, allow_blank: false
      end
      post do
        property = Property.create!(declared(params))

        { property: property, message: "Property created successfully" }
      end

      desc "Update existing property"
      params do
        requires :title, type: String, allow_blank: false
        requires :placement_type, type: String, allow_blank: false
      end
      route_param :id, type: Integer do
        put do
          property = Property.find(params[:id])
          property.update(declared(params))

          { message: "Property updated successfully" }

        rescue ActiveRecord::RecordNotFound
          error!("Record Not Found", 404)
        end
      end

      desc "Deletes existing property"
      route_param :id, type: Integer do
        delete do
          Property.find(params[:id]).destroy!
          { message: "Property deleted successfully" }

        rescue ActiveRecord::RecordNotFound
          error!("Record Not Found", 404)
        end
      end
    end
  end
end