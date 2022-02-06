//
//  WeatherDatabase.swift
//  NormalWeatherApp
//
//  Created by Тоха on 05.02.2022.
//

import Foundation

protocol WeatherService {
    func getWeather(from coord: Coordinates, completition: @escaping (WeatherData?, NetworkErrors?) -> ())
    func getWeather(from cityName: String, completition: @escaping (WeatherData?, NetworkErrors?) -> ())
}

struct WeatherServiceImpl: WeatherService {
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c8c3760b8e5d406a8a129e05c43e8d3f&units=metric"
    
    func getWeather(from coord: Coordinates, completition: @escaping (WeatherData?, NetworkErrors?) -> ()) {
        guard let lon = coord.lon, let lat = coord.lat else {
            completition(nil, .emptyCoordinates)
            return
        }
        
        let finalUrl = URL(string: weatherURL + "&lat=\(lat)" + "&lon=\(lon)")
        debugPrint("weather adding via coordinates")
        
        guard let finalUrl = finalUrl else {
            completition(nil, .failedUrl)
            return
        }
        performRequest(with: finalUrl) { weather, error in
            completition(weather, error)
        }
    }
    
    func getWeather(from cityName: String, completition: @escaping (WeatherData?, NetworkErrors?) -> ()) {
        let finalUrl = URL(string: weatherURL + "&q=\(cityName)")
        debugPrint("weather adding via city")
        guard let finalUrl = finalUrl else {
            completition(nil, .failedUrl)
            return
        }
        performRequest(with: finalUrl) { weather, error in
            completition(weather, error)
        }
    }
    
    private func performRequest(with url: URL, completition: @escaping (WeatherData?, NetworkErrors?) -> ()) {
        debugPrint("start session")
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30)
        URLSession.shared.dataTask(with: urlRequest) {
            data, urlResponse, error in
            let callbackMainThread: (WeatherData?, NetworkErrors?) -> () = { weather, error in
                DispatchQueue.main.async {
                    completition(weather, error)
                }
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                callbackMainThread(nil, .cantConvertResponse)
                return
            }
            
            switch httpResponse.statusCode {
            case 400:
                callbackMainThread(nil, .emptyCoordinates)
            case 404:
                callbackMainThread(nil, .emptyCity)
            case 200:
                guard let data = data else{
                    callbackMainThread(nil, .unsafeData)
                    return
                }
                callbackMainThread(WeatherData.parseJson(from: data), nil)
            default:
                guard let data = data, let networkError = NetworkError.parseJson(from: data) else {
                    callbackMainThread(nil, .unsafeData)
                    return
                }
                callbackMainThread(nil, .httpError(networkError))
            }
        }.resume()
        debugPrint("sessin resumed")
    }
}
