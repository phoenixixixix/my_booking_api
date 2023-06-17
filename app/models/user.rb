class User < ApplicationRecord
  has_many :authentication_tokens

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :find_by_token, ->(token) { joins(:authentication_tokens).where(authentication_tokens: { token: token }).first }

  def admin?
    self.type == "Admin"
  end
end
