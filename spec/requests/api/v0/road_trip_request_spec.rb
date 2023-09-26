require "rails_helper"

RSpec.describe "road trip request" do
  describe "road trip create action" do
    it "returns road trip details", :vcr do
      user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
      headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
      params = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": user.api_key
      }
      body = JSON.generate(params)

      post '/api/v0/road_trip', headers: headers, params: body
      
      trip_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      expect(trip_response).to be_a Hash
      expect(trip_response).to have_key(:data)
      expect(trip_response[:data]).to have_key(:id)
      expect(trip_response[:data]).to have_key(:type)
      expect(trip_response[:data][:type]).to eq("road_trip")
      expect(trip_response[:data]).to have_key(:attributes)
      expect(trip_response[:data][:attributes]).to have_key(:start_city)
      expect(trip_response[:data][:attributes][:start_city]).to be_a String
      expect(trip_response[:data][:attributes]).to have_key(:end_city)
      expect(trip_response[:data][:attributes][:end_city]).to be_a String
      expect(trip_response[:data][:attributes]).to have_key(:travel_time)
      expect(trip_response[:data][:attributes][:travel_time]).to be_a String
      expect(trip_response[:data][:attributes]).to have_key(:weather_at_eta)
      expect(trip_response[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(trip_response[:data][:attributes][:weather_at_eta][:datetime]).to be_a String
      expect(trip_response[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(trip_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a Numeric
      expect(trip_response[:data][:attributes][:weather_at_eta]).to have_key(:condition)
      expect(trip_response[:data][:attributes][:weather_at_eta][:condition]).to be_a String      
    end
  end

  context "when distance cannot be traveled" do
    it "returns road trip details", :vcr do
      user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
      headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
      params = {
        "origin": "Denver,CO",
        "destination": "Paris,France",
        "api_key": user.api_key
      }
      body = JSON.generate(params)

      post '/api/v0/road_trip', headers: headers, params: body
      
      trip_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(401)

          
    end
  end
end