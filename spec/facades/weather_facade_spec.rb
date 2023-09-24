require "rails_helper"

describe WeatherFacade do
  describe "class methods" do
    describe ".get_forecast" do
      it "returns array of forecast data", :vcr do
        forecast = WeatherFacade.get_forecast("39.74001", "-104.99202")

        expect(forecast).to be_a Forecast
      end
    end
  end
end