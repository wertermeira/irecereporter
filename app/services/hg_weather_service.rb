class HgWeatherService
  attr_accessor :city, :state

  def initialize(city: 'Irecê', state: 'Ba')
    @city = city
    @state = state
  end

  def call
    weather_json.body if weather_json.body.present?
  end

  private

  def weather_json
    Typhoeus.get(endpoint)
  end

  def endpoint
    "#{Rails.application.config.hg_weather_endpoint}&city_name=#{city},#{state}"
  end
end
