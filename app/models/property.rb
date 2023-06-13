class Property < ApplicationRecord
  enum :placement_type, { apartment: "apartment", hotel: "hotel", hostel: "hostel" }

  validates :title, :placement_type, presence: true
end
