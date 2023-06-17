class AddressPolicy
  attr_reader :user, :address

  def initialize(user, address)
    @user = user
    @address = address
  end

  def update?
    user.admin?
  end
end
