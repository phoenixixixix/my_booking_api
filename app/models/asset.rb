class Asset < ApplicationRecord
  has_and_belongs_to_many :properties

  validates :title, presence: true
end
