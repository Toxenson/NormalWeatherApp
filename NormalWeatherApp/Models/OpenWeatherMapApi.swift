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
    
    func getWeather(from coord: Coordinates) -> WeatherData?{
        let finalUrl = weatherURL + "&lat=\(coord.lat)" + "&lon=\(coord.lon)"
        return performRequest(with: finalUrl)
    }
    
    func getWeather(from cityName: String) -> WeatherData?{
        let finalUrl = weatherURL + "&q=\(cityName)"
        return performRequest(with: finalUrl)
    }
    
    private func performRequest(with urlString: String) -> WeatherData?{
        let urlRequest = URLRequest(url: URL(string: urlString)!,
                                    cachePolicy: .reloadIgnoringLocalCacheData,
                                    timeoutInterval: 0.5)
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) {
            data, urlResponse, error in
            let statusCode = (urlResponse as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let safeData = data!
                return parseJson(from: safeData)
            } else {
                return nil
            }
        }
    }
    
    private func parseJson(from json: Data) -> WeatherData?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: json)
            let coords = decodedData.coords
            let weatherId = decodedData.weather[0].id
            let weatherMain = decodedData.weather[0].main
            let weatherDescription = decodedData.weather[0].description
            let city = decodedData.city
            let mainTemp = decodedData.main.temp
            let mainTempFeelsLike = decodedData.main.feelsLike
            let mainTempMax = decodedData.main.tempMax
            let mainTempMin = decodedData.main.tempMin
            let mainPressure = decodedData.main.pressure
            let windSpeed = decodedData.wind.speed
            let windDeg = decodedData.wind.degrees
            let id = decodedData.id
            return WeatherData(coords: coords,
                               weather: [Weather(id: weatherId,
                                                 main: weatherMain,
                                                 description: weatherDescription)],
                               city: city,
                               main: Main(temp: mainTemp,
                                          feelsLike: mainTempFeelsLike,
                                          tempMin: mainTempMin,
                                          tempMax: mainTempMax,
                                          pressure: mainPressure),
                               wind: Wind(speed: windSpeed,
                                          degrees: windDeg),
                               id: id)
        } catch {
            return nil
        }
    }
}

