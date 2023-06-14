require "rails_helper"

RSpec.describe Property, type: :model do
  context "Search by associated Assets" do
    describe "using :property_with_specified_assets class method" do
      let!(:property) { create(:property) }

      it "includes Property with specified Assets" do
        asset1 = create(:asset)
        asset2 = create(:asset)
        property.asset_ids = [asset1.id, asset2.id]
        property.reload

        search_res = Property.property_with_specified_assets(asset1.title, asset2.title)

        expect(search_res).to include(property)
      end

      it "shouldnt include Property with no specified Assets" do
        asset = create(:asset, title: "NoMatch")
        property.assets.clear

        search_res = Property.property_with_specified_assets(asset.title)

        expect(property.assets.exists?(asset.id)).to be_falsey
        expect(search_res).to_not include(property)
      end
    end
  end
end
