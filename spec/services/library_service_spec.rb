require "rails_helper"

describe LibraryService do
  describe "class methods" do
    describe ".find_books" do
      it "returns top rated", :vcr do
        response = LibraryService.find_books("savannah, ga", "5")

        expect(response).to be_a Hash
        expect(response).to have_key(:docs)
        expect(response).to have_key(:numFound)
      end
    end
  end

end