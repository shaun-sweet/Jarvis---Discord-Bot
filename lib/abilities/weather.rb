class Weather

    attr_reader :description, :temperature, :max, :min
    def initialize(args = {})
        @uri = URI('http://api.openweathermap.org/data/2.5/weather')
        params = {q: args[:city], APPID: ENV["open_weather_key"], units: 'imperial'}
        @uri.query = URI.encode_www_form(params)
        weather_object = weather_query
        @description = weather_object['weather'][0]['description']
        @temperature = weather_object['main']['temp']
        @max = weather_object['main']['temp_max']
        @min = weather_object['main']['temp_min']
    end

    private

    def weather_query
        res = Net::HTTP.get_response(@uri)
        return JSON.parse res.body
    end

end