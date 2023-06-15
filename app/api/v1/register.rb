module V1
  class Register < Grape::API

    namespace :register do
      desc "Register using email and password"
      params do
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
      post do
        { message: "Registered successfully"} if User.create!(declared(params))

      rescue ActiveRecord::RecordInvalid => e
        error!(e.message, 422)
      end
    end
  end
end
