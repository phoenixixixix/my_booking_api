class PropertyPolicy
  attr_reader :user, :property

  def initialize(user, property)
    @user = user
    @property = property
  end

  def create?
    user.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
