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
        Member.create!(declared(params))
        { message: "Registered successfully"}

      rescue ActiveRecord::RecordInvalid => e
        error!(e.message, 422)
      end
    end
  end
end
