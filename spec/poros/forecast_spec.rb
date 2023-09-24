require "rails_helper"

RSpec.describe Forecast do
  it 'exists' do
    data = {
      current: {
        :last_updated=>"2023-09-23 18:45",
        :temp_f=>69.8,
        :feelslike_f=>69.8,
        :humidity=>13,
        :uv=>6.0,
        :vis_miles=>9.0,
        condition: {
          :text=>"Partly cloudy",
          :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"
        }
      },
      forecast: {
        forecastday: [
          {
            date: 'date',
            astro: {
              sunrise: "sunrise",
              sunset: "sunset"
            },
            day: {
              maxtemp_f: 100,
              mintemp_f: 0,
              condition: {
                text: "froggy",
                icon: "frog"
              }
            },
            hour: [
              {
                time: "16:00",
                temp_f: "69.0",
                condition: {
                  text: "ooh lala",
                  icon: "eggplant"
                }
              }
            ]
          }
        ]
      }
    }

    forecast = Forecast.new(data)
    expect(forecast).to be_a Forecast
    expect(forecast.current_weather).to eq(
      {
        :last_updated=>"2023-09-23 18:45",
        :current_temperature=>69.8,
        :feels_like=>69.8,
        :humidity=>13,
        :uv=>6.0,
        :visibility=>9.0,
        :current_condition=>"Partly cloudy",
        :current_icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"
      }
    )
    expect(forecast.daily_weather).to eq([
      {
        :date=>"date", 
        :sunrise=>"sunrise", 
        :sunset=>"sunset", 
        :max_temp=>100, 
        :min_temp=>0, 
        :daily_condition=>"froggy", 
        :daily_icon=>"frog"
      }
    ])
    expect(forecast.hourly_weather).to eq([
      {
        :time=>"16:00", 
        :hourly_temperature=>"69.0", 
        :hourly_conditions=>"ooh lala", 
        :hourly_icon=>"eggplant"
      }
    ])
  end
end