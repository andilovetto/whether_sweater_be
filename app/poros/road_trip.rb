class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta,
              :id

  
  def initialize(origin, destination, directions, forecast)
    @start_city = origin
    @end_city = destination
    @travel_time = RoadTrip.seconds_to_hms(directions)
    @weather_at_eta = RoadTrip.weather_at_eta(forecast, @travel_time, directions) 
    @id = nil
  end
  
  private 
  
  def self.weather_at_eta(forecast, travel_time, directions)
    return {} if !valid_trip?(directions)
    time_to_destination = round_time(travel_time)
    time = round_time(Time.now.strftime('%H:%M'))
    time_of_arrival = time_to_destination + time
    if time_of_arrival >= 24 
      eta = "#{time_of_arrival - 24}:00"
      weather = forecast.daily_weather[1]
      date_time = forecast.daily_weather[1][:date] + ' ' + "#{eta}"
      {
        datetime: date_time,
        temperature: weather[:max_temp],
        condition: weather[:daily_condition]
      }
    else 
      eta = "#{time_of_arrival}:00"
      weather = forecast.hourly_weather.find do |hour|
        hour if hour[:time] == eta
      end
      date_time = Time.now.strftime("%Y-%d-%m") + ' ' + "#{eta}"
      {
        datetime: date_time,
        temperature: weather[:hourly_temperature],
        condition: weather[:hourly_conditions]
      }
    end
  end

  def self.seconds_to_hms(directions)
    return "trip impossible!" if !valid_trip?(directions)
    sec = directions[:route][:time]
    "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
  end

  def self.round_time(time)
    rounded_time = 0
    hours = time.slice(0..1).to_i
    minutes = time.slice(3..4).to_i
    if minutes > 30
      rounded_time = hours + 1
    else 
      rounded_time = hours
    end
    rounded_time
  end

  def self.valid_trip?(directions)
    directions[:info][:statuscode] != 402
  end
end
