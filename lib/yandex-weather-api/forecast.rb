module YandexWeather
  class Forecast
    attr_accessor :temperature_avg, :condition, :temperature_min, :temperature_max
  end

  # Abstract class for forecasts per day
  class DaylyForecasts
    attr_accessor :morning, :day, :evening, :night
  end

  # Abstract class for all weather forecasts from service
  class Forecasts
    attr_reader :now

    def day(date)
      raise "Not Implemented"
    end
  end

  class YandexForecasts < Forecasts
    def initialize(node)
      @now= YandexNowForecast.new(node.at_xpath('//xmlns:fact'))

      @dayly = {}

      node.xpath('//xmlns:day').each do |day|
        @dayly[day['date']] = YandexDaylyForecasts.new day
      end
    end

    def day(date)
      @dayly[date]
    end
  end

  class YandexDaylyForecasts < DaylyForecasts
    def initialize(node)
      %w{morning day evening night}.each do |part|
        forecast = YandexDaylyPartForecast.new(node.at_xpath("//xmlns:day_part[@type='#{part}']"))
        send "#{part}=", forecast
      end
    end
  end

  class YandexNowForecast < Forecast
    def initialize(node)
      @condition = node.xpath('//xmlns:weather_condition').first['code']
      @temperature_avg = node.xpath('//xmlns:temperature').first.text
    end
  end

  class YandexDaylyPartForecast < Forecast
    def initialize(node)
      @condition = node.xpath('//xmlns:weather_condition').first['code']
      @temperature_min = node.xpath('//xmlns:temperature-data/xmlns:from').first.text
      @temperature_max = node.xpath('//xmlns:temperature-data/xmlns:to').first.text
      @temperature_avg = node.xpath('//xmlns:temperature-data/xmlns:avg').first.text
    end
  end
end