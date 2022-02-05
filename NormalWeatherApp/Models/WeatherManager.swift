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

struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    var weatherList: [WeatherData?]?
    let weatherDatabase: WeatherService = OpenWeatherMapApi()
    
    mutating func addWeather(for place: Any) {
        switch place {
        case let someCity as String:
            let weather = weatherDatabase.getWeather(from: someCity)
            weatherList?.append(weather)
            debugPrint("weather added via city")
        case let someCoords as Coordinates:
            let weather = weatherDatabase.getWeather(from: someCoords)
            weatherList?.append(weather)
            debugPrint("weather added via coordinates")
        default:
            debugPrint("wrong place")
        }
        delegate?.didUpdateWeather(self, weather: weatherList?[0])
    }
    mutating func deleteWeather(id: Int) {
        
    }
}
