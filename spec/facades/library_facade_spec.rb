require "rails_helper"

describe LibraryFacade do
  describe "class methods" do
    describe ".get_books" do
      it "returns books by location", :vcr do
        forecast = WeatherFacade.get_forecast(32.08091, -81.09119)
        books = LibraryFacade.get_books("savannah, ga", "5", forecast)
        expect(books).to be_a Library
      end
    end
  end
end