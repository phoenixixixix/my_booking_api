require "rails_helper"

RSpec.describe "Properties", type: :request do
  context "Listing" do
    describe "GET /properties" do
      let!(:property) { create(:property) }

      it "returns success code when listing properties" do
        get "/api/v1/properties"
        expect(response).to have_http_status(200)
      end

      it "should list properties" do
        properties = Property.all

        get "/api/v1/properties"

        expect(JSON.parse(response.body)).to eq(JSON.parse(properties.to_json))
      end
    end

    describe "GET /properties by assets" do
      let!(:in_scope_property) { create(:property) }

      it "returns list of Properties matched by asset" do
        asset = create(:asset, properties: [in_scope_property])
        in_scope_property.assets = [asset]

        get "/api/v1/properties?assets[]=#{asset.title}"

        expect(JSON.parse(response.body)).to include(JSON.parse(in_scope_property.to_json))
      end

      it "returns list of Properties matched by MULTIPLE assets" do
        asset1 = create(:asset, properties: [in_scope_property])
        asset2 = create(:asset, properties: [in_scope_property])
        out_of_scope = create(:property)

        get "/api/v1/properties", params: { assets: [asset1.title, asset2.title] }

        expect(JSON.parse(response.body)).to include(JSON.parse(in_scope_property.to_json))
        expect(JSON.parse(response.body)).to_not include(JSON.parse(out_of_scope.to_json))
      end

      it "shouldnt return Properties that are out of scope" do
        asset = create(:asset, properties: [in_scope_property])
        out_of_scope = create(:property)
        out_of_scope.assets.clear

        get "/api/v1/properties?assets[]=#{asset.title}"

        expect(JSON.parse(response.body)).to_not include(JSON.parse(out_of_scope.to_json))
      end
    end
  end

  describe "POST /properties" do
    let!(:params) { { title: "Property", placement_type: "hotel"}}

    it "creates a new property when params are valid" do
      post "/api/v1/properties", params: params

      expect(JSON.parse(response.body)["property"]["title"]).to eq(params[:title])
    end

    it "shouldnt create the property, but return validation error when params are invalid" do
      params[:title] = ""

      post "/api/v1/properties", params: params

      expect(JSON.parse(response.body)["error"]).to eq("title is empty")
    end
  end

  describe "PUT /properties/:id" do
    let!(:property_attrs) { attributes_for(:property) }
    let!(:property) { create(:property) }

    it "updates existing property record" do
      new_title = "Updated Title"
      property_attrs.merge!(title: new_title)

      put "/api/v1/properties/#{property.id}", params: property_attrs

      expect(property.reload.title).to eq(new_title)
    end

    it "shouldnt update the property, but return validation error when params are invalid" do
      invalid_title = ""
      property_attrs.merge!(title: invalid_title)

      put "/api/v1/properties/#{property.id}", params: property_attrs

      expect(property.reload.title).to_not eq(invalid_title)
      expect(JSON.parse(response.body)["error"]).to eq("title is empty")
    end
  end

  describe "DELETE /properties/:id" do
    let!(:property) { create(:property) }

    it "deletes the property" do
      delete "/api/v1/properties/#{property.id}"

      expect(JSON.parse(response.body)["message"]).to eq("Property deleted successfully")
    end
  end

  describe "Invalid ID" do
    it "returns exception error message" do
      delete "/api/v1/properties/123102391"

      expect(JSON.parse(response.body)["error"]).to eq("Record Not Found")
    end
  end
end
