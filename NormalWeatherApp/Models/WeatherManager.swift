//
//  WeatherManager.swift
//  NormalWeatherApp
//
//  Created by Тоха on 05.02.2022.
//

import Foundation
import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData?)
    func didFailWithError(_ error: UIViewController)
}

class WeatherManager {
    var delegate: WeatherManagerDelegate?
    var weatherList: [WeatherData] = []
    let weatherDatabase: WeatherService = WeatherServiceImpl()
    
    func addWeather(for place: Any) {
        switch place {
        case let someCity as String:
            weatherDatabase.getWeather(from: someCity) { [unowned self] weather, error in
                if let safeWeather = weather {
                    weatherList.append(safeWeather)
                    delegate?.didUpdateWeather(self, weather: safeWeather)
                }
                if let safeError = error {
                    errorHandler(safeError)
                }
            }
            debugPrint("weather added via city")
        case let someCoords as Coordinates:
            weatherDatabase.getWeather(from: someCoords) { [unowned self] weather, error in
                debugPrint(String(describing: weather?.weather[0].main))
                if let safeWeather = weather {
                    weatherList.append(safeWeather)
                    delegate?.didUpdateWeather(self, weather: safeWeather)
                }
                if let safeError = error {
                    errorHandler(safeError)
                }
            }
            debugPrint("weather added via coordinates")
        default:
            debugPrint("wrong place")
        }
    }
    
    func deleteWeather(id: Int) {
        
    }
    
    private func errorHandler(_ error: Errors) {
        switch error {
        case .emptyCity:
            delegate?.didFailWithError(AlertsFabric.getWarningAlert(title: "Wrong city",
                                                                    message: "Ops, you typed nonexistent city"))
        case .httpError(let id, let message):
            delegate?.didFailWithError(AlertsFabric.getWarningAlert(title: "HTTP Error",
                                                                    message: "Id: \(id).\nMessage: \(message)"))
        case .emptyCoordinates:
            delegate?.didFailWithError(AlertsFabric.getWarningAlert(title: "Wrong coordinates",
                                                                    message: "Ops, you are on nonexistent coordinates"))
        default:
            delegate?.didFailWithError(AlertsFabric.getWarningAlert(title: "Ops",
                                                                    message: "Something goes wrong"))
        }
    }
}
