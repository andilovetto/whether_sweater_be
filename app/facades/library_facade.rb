class LibraryFacade
  def self.get_books(location, quantity, forecast)
    require 'pry'; binding.pry
    books = LibraryService.find_books(location, quantity)
  end
end