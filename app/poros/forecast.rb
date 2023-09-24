class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = Forecast.current_weather(data)
    @daily_weather = Forecast.daily_weather(data)
    @hourly_weather = Forecast.hourly_weather(data)
  end

  def self.current_weather(data)
    if data[:current]
      {
        last_updated: data[:current][:last_updated],
        current_temperature: data[:current][:temp_f],
        feels_like: data[:current][:feelslike_f],
        humidity: data[:current][:humidity],
        uv: data[:current][:uv],
        visibility: data[:current][:vis_miles],
        current_condition: data[:current][:condition][:text],
        current_icon: data[:current][:condition][:icon]
      }
    else 
      { error: 'Bad request' }
    end
  end

  def self.daily_weather(data)
    if data[:forecast][:forecastday]
      data[:forecast][:forecastday].map do |day|
        {
          date: day[:date],
          sunrise: day[:astro][:sunrise],
          sunset: day[:astro][:sunset],
          max_temp: day[:day][:maxtemp_f],
          min_temp: day[:day][:mintemp_f],
          daily_condition: day[:day][:condition][:text],
          daily_icon: day[:day][:condition][:icon]
        }
      end
    else 
      { error: 'Bad request' }
    end
  end

  def self.hourly_weather(data)
    if data[:forecast][:forecastday][0][:hour]
      data[:forecast][:forecastday][0][:hour].map do |hour|
        {
          time: Forecast.hourly_time(hour[:time]),
          hourly_temperature: hour[:temp_f],
          hourly_conditions: hour[:condition][:text],
          hourly_icon: hour[:condition][:icon]
        }
      end
    else 
      { error: 'Bad request' }
    end
  end

  def self.hourly_time(date)
    Time.zone.parse(date).strftime("%H:%M")
  end
end