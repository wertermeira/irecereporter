module Services
  class WeatherController < ActionController::Base
    def index
      weather_json = HgWeatherService.new.call
      render json: weather_json
    end
  end
end
