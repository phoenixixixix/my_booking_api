class Property < ApplicationRecord
  enum :placement_type, { apartment: "apartment", hotel: "hotel", hostel: "hostel" }

  has_one :address, dependent: :delete
  has_and_belongs_to_many :assets

  validates :title, :placement_type, presence: true

  def self.with_specified_assets(*asset_titles)
    asset_titles.flatten!

    self.joins(:assets)
        .where(assets: { title: asset_titles })
        .group("properties.id")
        .having("COUNT(DISTINCT assets.title) = ?", asset_titles.size)
  end

  def self.with_location(country:, city:)
    query = self.joins(:address)
    query = query.where(address: { country: country }) if country.present?
    query = query.where(address: { city: city }) if city.present?

    query
  end
end
