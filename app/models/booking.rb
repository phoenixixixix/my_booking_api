class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :from_date, :to_date, presence: true
  validate :to_date_should_be_grater_than_from_date
  validate :dates_cannot_be_in_the_past

  private

  def to_date_should_be_grater_than_from_date
    if from_date.present? && to_date.present?
      errors.add(:base, "To date should be grater than From date") if from_date > to_date
    end
  end

  def dates_cannot_be_in_the_past
    if from_date.present? && from_date < Time.zone.today
      errors.add(:from_date, "From date can't be in past")
    end

    if to_date.present? && to_date < Time.zone.today
      errors.add(:to_date, "To date can't be in past")
    end
  end
end
