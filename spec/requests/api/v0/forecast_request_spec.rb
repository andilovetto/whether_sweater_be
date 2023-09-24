require "rails_helper"

RSpec.describe "forecast request" do
  describe "forecast index action" do
    it "returns weather forecast for given city and state", :vcr do
      headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
      
      get "/api/v0/forecast", headers: headers, params: { location: "denver, co" }

      forecast_response = JSON.parse(response.body, symbolize_names: true) 
      expect(response.status).to eq(200)
      expect(forecast_response).to be_a Hash
      expect(forecast_response).to have_key(:data)
      expect(forecast_response[:data]).to have_key(:id)
      expect(forecast_response[:data]).to have_key(:type)
      expect(forecast_response[:data][:type]).to eq("forecast")
      expect(forecast_response[:data]).to have_key(:attributes)
      expect(forecast_response[:data][:attributes]).to have_key(:current_weather)
      expect(forecast_response[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(forecast_response[:data][:attributes][:current_weather][:last_updated]).to be_a String
      expect(forecast_response[:data][:attributes][:current_weather]).to have_key(:current_temperature)
      expect(forecast_response[:data][:attributes][:current_weather][:current_temperature]).to be_a Float
      expect(forecast_response[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(forecast_response[:data][:attributes][:current_weather][:feels_like]).to be_a Float
      expect(forecast_response[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(forecast_response[:data][:attributes][:current_weather]).to_not have_key(:cloud)
      expect(forecast_response[:data][:attributes][:current_weather][:humidity]).to be_a Numeric
      expect(forecast_response[:data][:attributes][:current_weather]).to have_key(:uv)
      expect(forecast_response[:data][:attributes][:current_weather]).to_not have_key(:vis_km)
      expect(forecast_response[:data][:attributes][:current_weather][:uv]).to be_a Numeric
      expect(forecast_response[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(forecast_response[:data][:attributes][:current_weather][:visibility]).to be_a Numeric
      expect(forecast_response[:data][:attributes][:current_weather]).to have_key(:current_condition)
      expect(forecast_response[:data][:attributes][:current_weather][:current_condition]).to be_a String
      expect(forecast_response[:data][:attributes][:current_weather]).to have_key(:current_icon)
      expect(forecast_response[:data][:attributes][:current_weather]).to_not have_key(:code)
      expect(forecast_response[:data][:attributes][:current_weather][:current_icon]).to be_a String
      expect(forecast_response[:data][:attributes]).to have_key(:daily_weather)
      expect(forecast_response[:data][:attributes][:daily_weather]).to be_an Array
      expect(forecast_response[:data][:attributes][:daily_weather].count).to eq(5)
      forecast_response[:data][:attributes][:daily_weather].each do |day|
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a String
        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a String
        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a String
        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a Numeric
        expect(day).to have_key(:min_temp)
        expect(day).to_not have_key(:mintemp_c)
        expect(day[:min_temp]).to be_a Numeric
        expect(day).to have_key(:daily_condition)
        expect(day).to_not have_key(:daily_will_it_snow)
        expect(day[:daily_condition]).to be_a String
        expect(day).to have_key(:daily_icon)
        expect(day[:daily_icon]).to be_a String
      end
      expect(forecast_response[:data][:attributes]).to have_key(:hourly_weather)
      expect(forecast_response[:data][:attributes][:hourly_weather]).to be_an Array
      forecast_response[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a String
        expect(hour).to have_key(:hourly_temperature)
        expect(hour[:hourly_temperature]).to be_a Numeric
        expect(hour).to have_key(:hourly_conditions)
        expect(hour[:hourly_conditions]).to be_a String
        expect(hour).to have_key(:hourly_icon)
        expect(hour).to_not have_key(:wind_kmp)
        expect(hour).to_not have_key(:humidity)
        expect(hour[:hourly_icon]).to be_a String
      end
    end

    it "returns status 404 and error message", :vcr do
      headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
      
      get "/api/v0/forecast", headers: headers, params: { }

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(error_response[:errors][0]).to have_key(:detail)
    end
  end
end