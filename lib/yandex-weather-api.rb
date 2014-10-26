require 'nokogiri'
require 'yandex-weather-api/forecast'

module YandexWeather
  class << self
    CITIES_URL = 'http://weather.yandex.ru/static/cities.xml'
    FORECAST_URL = 'http://export.yandex.ru/weather-ng/forecasts/'

    def get_city_id(name)
      city = self.cities.select { |o| o[:name] == name }[0]
      city.nil? ? nil : city[:id]
    end

    def get_forecasts(city_id)
      response = get_response(FORECAST_URL + "#{city_id}.xml")

      doc = Nokogiri::XML(response)

      YandexForecasts.new doc
    end

    protected
      def get_response(url)
        begin
          response = Net::HTTP.get_response(URI.parse url)
        rescue => e
          raise "Failed to get cities [url=#{url}, e=#{e}]."
        end

        response.body.to_s
      end

      def cities
        @cities ||= Proc.new do
          response = get_response(CITIES_URL)

          doc = Nokogiri::XML(response)
          doc.xpath("//city").map { |xml| {id: xml['id'], country: xml['country'], name: xml.text} }
        end.call
      end
  end
end