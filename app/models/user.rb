class User < ApplicationRecord
  has_many :authentication_tokens

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
