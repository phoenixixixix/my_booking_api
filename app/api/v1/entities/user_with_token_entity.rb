module V1
  module Entities
    class UserWithTokenEntity < V1::Entities::UserEntity
      expose :token do |user|
        user.authentication_tokens.valid.first.token
      end
    end
  end
end
