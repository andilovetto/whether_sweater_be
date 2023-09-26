require "rails_helper"

RSpec.describe "session request" do
  describe "session create action" do
    context "when call is successful" do
      it "returns status 200" do
        user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
          "email": "whatever@example.com",
          "password": "password"
        }
        body = JSON.generate(params)
  
        post '/api/v0/sessions', headers: headers, params: body
  
        session_response = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(200)
        expect(session_response).to be_a Hash
        expect(session_response).to have_key(:data)
        expect(session_response[:data]).to have_key(:type)
        expect(session_response[:data]).to have_key(:id)
        expect(session_response[:data][:type]).to eq("users")
        expect(session_response[:data]).to have_key(:attributes)
        expect(session_response[:data][:attributes]).to have_key(:email)
        expect(session_response[:data][:attributes]).to have_key(:api_key)
      end
    end

    context "when email is not provided" do
      it "returns status 400" do
        user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
          "email": "",
          "password": "password"
        }
        body = JSON.generate(params)
  
        post '/api/v0/sessions', headers: headers, params: body
  
        error_response = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(400)
        expect(error_response[:error]).to eq("bad credentials")
      end
    end

    context "when password is not correct" do
      it "returns status 400" do
        user = User.create!(email: "whatever@example.com", password: "widespreadmfpanic", password_confirmation: "widespreadmfpanic")
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
          "email": "whatever@example.com",
          "password": "billystrings"
        }
        body = JSON.generate(params)
  
        post '/api/v0/sessions', headers: headers, params: body
        error_response = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(400)

        expect(error_response[:error]).to eq("bad credentials")
      end
    end

    context "when password is blank" do
      it "returns status 400" do
        user = User.create!(email: "whatever@example.com", password: "widespreadmfpanic", password_confirmation: "widespreadmfpanic")
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
          "email": "whatever@example.com",
          "password": ""
        }
        body = JSON.generate(params)
  
        post '/api/v0/sessions', headers: headers, params: body
        error_response = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(400)

        expect(error_response[:error]).to eq("bad credentials")
      end
    end
  end
end