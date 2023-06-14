require "rails_helper"

RSpec.describe Address, type: :model do
  context "Phone number" do
    describe "format handling" do
      let!(:address) { build(:address) }
      let(:valid_number_format) { "+8921341555" }

      it "creates Address with valid phone number format" do
        address.phone_number = valid_number_format

        expect { address.save! }.to change { Address.count }.by 1
      end

      it "should create Address with invalid number format" do
        invalid_formats = %w(12345678910122 12341 892.134155-5)

        invalid_formats.each do |format|
          address.phone_number = format
          expect { address.save }.to change { Address.count }.by 0
        end
      end
    end
  end
end
