class Address < ApplicationRecord
  PHONE_NUMBER_FORMAT = /\A[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}\z/

  belongs_to :property

  validates :country, :city, :street, :phone_number, presence: true
  validates :phone_number, format: { with: PHONE_NUMBER_FORMAT }
end
