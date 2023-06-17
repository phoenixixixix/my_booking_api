class AssetPolicy
  attr_reader :user, :asset

  def initialize(user, asset)
    @user = user
    @asset = asset
  end

  def create?
    user.admin?
  end

  def destroy?
    create?
  end
end
