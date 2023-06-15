module V1
  module Entities
    class UserEntity < Grape::Entity
      expose :email
    end
  end
end
