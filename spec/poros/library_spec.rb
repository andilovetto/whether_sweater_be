require "rails_helper"

RSpec.describe Library do
  it "exists", :vcr do
    forecast = WeatherFacade.get_forecast(32.08091, -81.09119)
    books = LibraryService.find_books("savannah, ga", "5")
    library = Library.new(books[:docs], 6, "savannah, ga", forecast)
    expect(library).to be_a Library
    expect(library.id).to eq(nil)
    expect(library.destination).to eq("savannah, ga")
    expect(library.forecast).to eq({:summary=>"Partly cloudy", :temperature=>87.8})
    expect(library.total_books_found).to eq(6)
    response = [{:isbn=>nil, :title=>"Housing"},
      {:isbn=>
        ["9780676546811",
         "0679429220",
         "9780676538052",
         "9780679462262",
         "9780676593495",
         "0307538370",
         "0676546811",
         "2266075187",
         "9780679462279",
         "0679762833",
         "9780099576112",
         "9780679449447",
         "9780613193979",
         "0788704397",
         "9780679429227",
         "0739321501",
         "9780679762836",
         "0701168293",
         "0701162430",
         "9780788704390",
         "9785802600214",
         "0099276852",
         "0679462260",
         "9780679751526",
         "9787506311847",
         "0676538053",
         "9780701162436",
         "9780701168292",
         "0099576112",
         "0613193970",
         "9780679643418",
         "9780307538376",
         "9782266075183",
         "7506311844",
         "0676593496",
         "0788751875",
         "9780739321508",
         "5802600217",
         "0679643419",
         "9780099276852",
         "0099521016",
         "0679462279",
         "0679751521",
         "9780788751875",
         "0679449442",
         "9780099521013"],
       :title=>"Midnight in the Garden of Good and Evil"},
      {:isbn=>
        ["9780340923597",
         "8490701288",
         "9780743561815",
         "0743576209",
         "9781416523321",
         "9780739471654",
         "9780786287017",
         "8466634355",
         "1416523324",
         "0340923571",
         "9783442372065",
         "9780743554251",
         "0743554248",
         "1416528520",
         "9780743293907",
         "5699209158",
         "0743293908",
         "0743554256",
         "0340923598",
         "0743289331",
         "9780743576208",
         "0786287012",
         "1416532358",
         "0743561813",
         "9780340923573",
         "1594131740",
         "9785699209156",
         "0739471651",
         "9781416528524",
         "9780743554244",
         "9781416532354",
         "3442372062",
         "9781594131745",
         "9780743289337",
         "9788490701287",
         "9788466634359"],
       :title=>"Ricochet"},
      {:isbn=>nil, :title=>"Water resources appraisals for hydroelectric licensing"},
      {:isbn=>
        ["9780061827389",
         "9781423323297",
         "0060761040",
         "006019958X",
         "9780060761042",
         "1423323297",
         "1423323300",
         "0061031356",
         "9781423323310",
         "0060761032",
         "006182738X",
         "9780060761035",
         "9780060199586",
         "9781423323303",
         "1423323319",
         "1587887924",
         "9780061031359",
         "0060519134",
         "9781423323327",
         "1423323327",
         "9780060519131",
         "9781587887925"],
       :title=>"Savannah Blues"}]
    expect(library.books).to eq(response)
  end
end