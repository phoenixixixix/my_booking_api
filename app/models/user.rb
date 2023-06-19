class User < ApplicationRecord
  has_many :authentication_tokens
  has_many :bookings, dependent: :delete_all

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    self.type == "Admin"
  end
end
