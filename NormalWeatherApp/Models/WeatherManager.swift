//
//  WeatherManager.swift
//  NormalWeatherApp
//
//  Created by Тоха on 05.02.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData?)
    func didFailWithError(_ error: Error)
}

class WeatherManager {
    var delegate: WeatherManagerDelegate?
    var weatherList: [WeatherData?]?
    let weatherDatabase: WeatherService = WeatherServiceImpl()
    
    func addWeather(for place: Any) {
        switch place {
        case let someCity as String:
            weatherDatabase.getWeather(from: someCity) { [unowned self] weather in
                weatherList?.append(weather)
                delegate?.didUpdateWeather(self, weather: weather)
            }
            debugPrint("weather added via city")
        case let someCoords as Coordinates:
            weatherDatabase.getWeather(from: someCoords) { [unowned self] weather in
                weatherList?.append(weather)
                delegate?.didUpdateWeather(self, weather: weather)
            }
            debugPrint("weather added via coordinates")
        default:
            debugPrint("wrong place")
        }
    }
    func deleteWeather(id: Int) {
        
    }
}
