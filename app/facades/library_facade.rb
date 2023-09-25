class LibraryFacade
  def self.get_books(location, quantity, forecast)
    books = LibraryService.find_books(location, quantity)
    book_data = books[:docs]
    Library.new(book_data, books[:numFound], location, forecast)
  end
end