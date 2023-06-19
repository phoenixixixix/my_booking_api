require_relative "concerns/token_requireable"

module V1
  class Assets < Grape::API
    include V1::Concerns::Authenticable

    resources :assets do
      desc "Create Asset"
      params do
        requires :title, type: String
      end
      post do
        asset = Asset.new(declared(params))
        authorize asset, :create?
        asset.save!

        { asset: asset, message: "Asset created successfully"}
      end

      desc "Deletes existing Asset"
      route_param :id, type: Integer do
        delete do
          asset = Asset.find(params[:id])
          authorize asset, :destroy?
          asset.destroy!

          { message: "Asset deleted successfully" }

        rescue ActiveRecord::RecordNotFound
          error!("Record Not Found", 404)
        end
      end
    end
  end
end
