class Property < ApplicationRecord
  enum :placement_type, { apartment: "apartment", hotel: "hotel", hostel: "hostel" }

  has_and_belongs_to_many :assets

  validates :title, :placement_type, presence: true

  def self.with_specified_assets(*asset_titles)
    asset_titles.flatten!

    self.joins(:assets)
        .where(assets: { title: asset_titles })
        .group("properties.id")
        .having("COUNT(DISTINCT assets.title) = ?", asset_titles.size)
  end
end
