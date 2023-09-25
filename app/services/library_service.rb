class LibraryService
  def self.find_books(location, quantity)
    response = conn.get do |f|
      f.params["place"] = location
      f.params["limit"] = quantity
    end
    require 'pry'; binding.pry
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.conn
    url = "https://openlibrary.org/search.json"
    Faraday.new(url: url)
  end
end