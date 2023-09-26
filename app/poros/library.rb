class Library
  attr_reader :id,
              :destination,
              :forecast,
              :total_books_found,
              :books


  def initialize(books, num_books, location, forecast)
    @id = nil
    @destination = location
    @forecast = Library.forecast_hash(forecast)
    @total_books_found = num_books
    @books = Library.books_array(books)
  end

  def self.forecast_hash(forecast)
    forecast = {
      summary: forecast.current_weather[:current_condition],
      temperature: forecast.current_weather[:current_temperature]
    }
  end

  def self.books_array(books)
    books.map do |book|
      {
        isbn: book[:isbn],
        title: book[:title]
      }
    end
  end
end