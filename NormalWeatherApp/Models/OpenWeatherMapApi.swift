//
//  WeatherDatabase.swift
//  NormalWeatherApp
//
//  Created by Тоха on 05.02.2022.
//

import Foundation

protocol WeatherService {
    func getWeather(from coord: Coordinates) -> WeatherData?
    func getWeather(from cityName: String) -> WeatherData?
}

struct OpenWeatherMapApi: WeatherService {
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c8c3760b8e5d406a8a129e05c43e8d3f&units=metric"
    
    func getWeather(from coord: Coordinates) -> WeatherData? {
        var weatherData: WeatherData?
        let finalUrl = weatherURL + "&lat=\(coord.lat)" + "&lon=\(coord.lon)"
        debugPrint("weather adding via coordinates")
        performRequest(with: finalUrl) { weather, error in
            if weather != nil {
                weatherData = weather
            } else {
                debugPrint(error ?? "fuck")
            }
        }
        return weatherData
    }
    
    func getWeather(from cityName: String) -> WeatherData? {
        var weatherData: WeatherData?
        let finalUrl = weatherURL + "&q=\(cityName)"
        debugPrint("weather adding via city")
        performRequest(with: finalUrl) { weather, error in
            if weather != nil {
                weatherData = weather
            } else {
                debugPrint(error ?? "fuck")
            }
        }
        return weatherData
    }
    
    private func performRequest(with urlString: String, completition: @escaping (WeatherData?, Error?) -> ()) -> WeatherData? {
        debugPrint("performing request")
        var weather: WeatherData?
        let urlRequest = URLRequest(url: URL(string: urlString)!,
                                    cachePolicy: .reloadIgnoringLocalCacheData,
                                    timeoutInterval: 30)
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) {
            data, urlResponse, error in
            let statusCode = (urlResponse as! HTTPURLResponse).statusCode
            switch statusCode {
            case 200:
                debugPrint("parsing json")
                weather = parseJson(from: data!)
                DispatchQueue.main.async() {
                    completition(weather, error)
                }
//                completition(weather, error)
            default:
                debugPrint("http error")
                break
            }
        }.resume()
        debugPrint("request performed")
        return weather
    }
    
    private func parseJson(from json: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        debugPrint("also parsing json")
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: json)
            let coords = decodedData.coord
            let weatherId = decodedData.weather[0].id
            let weatherMain = decodedData.weather[0].main
            let weatherDescription = decodedData.weather[0].description
            let city = decodedData.name
            let mainTemp = decodedData.main.temp
            let mainTempFeelsLike = decodedData.main.feels_like
            let mainTempMax = decodedData.main.temp_max
            let mainTempMin = decodedData.main.temp_min
            let mainPressure = decodedData.main.pressure
            let windSpeed = decodedData.wind.speed
            let windDeg = decodedData.wind.deg
            let id = decodedData.id
            debugPrint("json parsed")
            return WeatherData(coord: coords,
                               weather: [Weather(id: weatherId,
                                                 main: weatherMain,
                                                 description: weatherDescription)],
                               main: Main(temp: mainTemp,
                                          feels_like: mainTempFeelsLike,
                                          temp_min: mainTempMin,
                                          temp_max: mainTempMax,
                                          pressure: mainPressure),
                               wind: Wind(speed: windSpeed,
                                          deg: windDeg),
                               id: id,
                               name: city)
        } catch {
            debugPrint("wrong weather")
            return nil
        }
    }
}

