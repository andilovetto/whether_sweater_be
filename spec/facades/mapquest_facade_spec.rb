require "rails_helper"

describe MapquestFacade do
  describe "class methods" do
    describe ".get_lat_lon" do
      it "returns latitude and longitude of given location", :vcr do
        lat_lon = MapquestFacade.get_lat_lon("denver, co")

        expect(lat_lon).to be_a Hash
        expect(lat_lon.count).to eq(2)
      end
    end
  end
end