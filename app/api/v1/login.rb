module V1
  class Login < Grape::API

    namespace :login do
      desc "Login via email and password"
      params do
        requires :email, type: String, desc: "email"
        requires :password, type: String, desc: "password"
      end
      post do
        user = User.find_by_email(params[:email])
        if user.present? && user.valid_password?(params[:password])
          token = user.authentication_tokens.valid.first || AuthenticationToken.generate(user)
          present token.user, with: Entities::UserWithTokenEntity
        else
          error!("Bad Authentication Parameters", 401)
        end
      end
    end
  end
end
