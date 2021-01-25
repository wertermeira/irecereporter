class HgWeatherService
  attr_accessor :city, :state 

  def initialize(city: 'Irecê', state: 'Ba')
    @city = city
    @state = state
  end

  def call
    get_weather.body if get_weather.body.present?
  end

  private

  def get_weather
    Typhoeus.get(endpoint)
  end

  def endpoint
    "#{Rails.application.config.hg_weather_endpoint}&city_name=#{city},#{state}"
  end
end