class AuthenticationToken < ApplicationRecord
  EXPIRATION_TIME = 1.day.from_now

  belongs_to :user

  validates :token, presence: true

  scope :valid,  -> { where("expires_at IS NULL OR expires_at > ?", Time.zone.now) }

  def self.generate(user)
    token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.exists?(token: random_token)
    end

    self.create(token: token, user: user, expires_at: EXPIRATION_TIME)
  end

  def self.valid?(token)
    if record = self.find_by(token: token)
      record.expired? ? false : true
    else
      false
    end
  end

  def expired?
    expires_at < Time.zone.now
  end
end
