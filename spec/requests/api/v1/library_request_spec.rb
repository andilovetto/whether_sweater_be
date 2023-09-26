require "rails_helper"

RSpec.describe "library request" do
  describe "library index action" do
    context "when location and quantity params are used" do
      it "it displays books by destination", :vcr do
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        
        get "/api/v1/book_search?location=savannah,ga&quantity=5", headers: headers
      
        books_response = JSON.parse(response.body, symbolize_names: true)
        
        expect(response.status).to eq(200)
        expect(books_response).to be_a Hash
        expect(books_response).to have_key(:data)
        expect(books_response[:data]).to have_key(:id)
        expect(books_response[:data]).to have_key(:type)
        expect(books_response[:data][:type]).to eq("books")
        expect(books_response[:data]).to have_key(:attributes)
        expect(books_response[:data][:attributes]).to have_key(:destination)
        expect(books_response[:data][:attributes]).to have_key(:forecast)
        expect(books_response[:data][:attributes][:forecast]).to have_key(:summary)
        expect(books_response[:data][:attributes][:forecast]).to have_key(:temperature)
        expect(books_response[:data][:attributes]).to have_key(:total_books_found)
        expect(books_response[:data][:attributes]).to have_key(:books)
        expect(books_response[:data][:attributes][:books]).to be_an Array
        books_response[:data][:attributes][:books].each do |book|
          expect(book).to have_key(:isbn)
          expect(book).to have_key(:title)
        end
      end
    end
  end
end