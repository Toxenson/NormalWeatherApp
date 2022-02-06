//
//  WeatherDatabase.swift
//  NormalWeatherApp
//
//  Created by Тоха on 05.02.2022.
//

import Foundation

protocol WeatherService {
    func getWeather(from coord: Coordinates, completition: @escaping (WeatherData?) -> ())
    func getWeather(from cityName: String, completition: @escaping (WeatherData?) -> ())
}

struct WeatherServiceImpl: WeatherService {
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c8c3760b8e5d406a8a129e05c43e8d3f&units=metric"
    private let defaultURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=c8c3760b8e5d406a8a129e05c43e8d3f&units=metric&q=Moscow")!
    
    func getWeather(from coord: Coordinates, completition: @escaping (WeatherData?) -> ()) {
        let finalUrl = URL(string: weatherURL + "&lat=\(coord.lat)" + "&lon=\(coord.lon)")
        debugPrint("weather adding via coordinates")
        performRequest(with: finalUrl ?? defaultURL) { weather in
            completition(weather)
        }
    }
    
    func getWeather(from cityName: String, completition: @escaping (WeatherData?) -> ()) {
        let finalUrl = URL(string: weatherURL + "&q=\(cityName)")
        debugPrint("weather adding via city")
        performRequest(with: finalUrl ?? defaultURL) { weather in
            completition(weather)
        }
    }
    
    private func performRequest(with url: URL, completition: @escaping (WeatherData?) -> ()) {
        debugPrint("start session")
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30)
        URLSession.shared.dataTask(with: urlRequest) {
            data, urlResponse, error in
            let callbackMainThread: (WeatherData?) -> () = { weather in
                DispatchQueue.main.async {
                    completition(weather)
                }
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                debugPrint("fuck")
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                debugPrint("parsing json")
                callbackMainThread(WeatherData.parseJson(from: data!))
            default:
                debugPrint("http error")
                break
            }
        }.resume()
        debugPrint("sessin resumed")
    }
    
    
}
