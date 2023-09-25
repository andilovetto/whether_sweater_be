require "rails_helper"

RSpec.describe "user request" do
  describe "user create action" do
    context "when successful" do
      it "creates a user with status 201" do
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        }
        body = JSON.generate(params)
    
        post '/api/v0/users', headers: headers, params: body 
    
        create_response = JSON.parse(response.body, symbolize_names: true)
    
        expect(response.status).to eq(201)
        expect(create_response).to be_a Hash
        expect(create_response).to have_key(:data)
        expect(create_response[:data]).to have_key(:type)
        expect(create_response[:data]).to have_key(:id)
        expect(create_response[:data][:type]).to eq("users")
        expect(create_response[:data]).to have_key(:attributes)
        expect(create_response[:data][:attributes]).to have_key(:email)
        expect(create_response[:data][:attributes]).to have_key(:api_key)
      end
    end

    context "when passwords don't match" do
      it "returns status 400" do
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
          "email": "whatever@example.com",
          "password": "passsword",
          "password_confirmation": "password"
        }
        body = JSON.generate(params)
    
        post '/api/v0/users', headers: headers, params: body 
    
        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:detail]).to eq("Validation failed: Password confirmation doesn't match Password")
      end
    end

    context "when email is invalid" do
      it "returns status 400" do
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
          "email": "notanemail@gmai",
          "password": "password",
          "password_confirmation": "password"
        }
        body = JSON.generate(params)
    
        post '/api/v0/users', headers: headers, params: body 
    
        error_response = JSON.parse(response.body, symbolize_names: true)
        

        expect(response.status).to eq(400)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:detail]).to eq("Validation failed: Email is invalid")
      end
    end

    context "when email is already taken" do
      it "returns status 400" do
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
          "email": "taken@gmail.com",
          "password": "password",
          "password_confirmation": "password"
        }
        body = JSON.generate(params)
    
        post '/api/v0/users', headers: headers, params: body

        post '/api/v0/users', headers: headers, params: body
    
        error_response = JSON.parse(response.body, symbolize_names: true)
        

        expect(response.status).to eq(400)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:detail]).to eq("Validation failed: Email has already been taken")
      end
    end
  end
end