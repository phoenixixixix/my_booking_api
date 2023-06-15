require "rails_helper"

RSpec.describe "Login", type: :request do
  context "Member user" do
    describe "/api/v1/login" do
      let(:email) { member_user.email }
      let(:password) { member_user.password }
      let!(:member_user) { create(:user, :member) }
      let(:original_params) { { email: email, password: password } }
      let(:params) { original_params }

      context "missing params" do
        context "password" do
          let(:params) { original_params.except(:password) }

          it "returns 400 status code" do
            post "/api/v1/login", params: params
            expect(response.status).to eq(400)
          end

          it "returns errors message" do
            post "/api/v1/login", params: params
            expect(JSON.parse(response.body)["error"]).to eq("password is missing")
          end
        end

        context "email" do
          let(:params) { original_params.except(:email) }

          it "returns 400 status code" do
            post "/api/v1/login", params: params
            expect(response.status).to eq(400)
          end

          it "returns errors message" do
            post "/api/v1/login", params: params
            expect(JSON.parse(response.body)["error"]).to eq("email is missing")
          end
        end
      end

      context "invalid params" do
        context "incorrect password" do
          let(:params) { original_params.merge(password: "invalid") }

          it "returns 400 status code" do
            post "/api/v1/login", params: params
            expect(response.status).to eq(401)
          end

          it "returns errors message" do
            post "/api/v1/login", params: params
            expect(JSON.parse(response.body)["error"]).to eq("Bad Authentication Parameters")
          end
        end

        context "with a non-existent login" do
          let(:params) { original_params.merge(email: "invalid@mail.com") }

          it "returns 400 status code" do
            post "/api/v1/login", params: params
            expect(response.status).to eq(401)
          end

          it "returns errors message" do
            post "/api/v1/login", params: params
            expect(JSON.parse(response.body)["error"]).to eq("Bad Authentication Parameters")
          end
        end
      end

      context "valid params" do
        it "returns 200 status code" do
          post "/api/v1/login", params: params
          expect(response.status).to eq(201)
        end
      end

      context "Token handling" do
        it "creates token if missing" do
          member_user.authentication_tokens.clear
          expect(member_user.authentication_tokens.size).to eq 0

          post "/api/v1/login", params: params

          expect(member_user.reload.authentication_tokens.size).to eq 1
        end
      end
    end
  end
end