//
//  WeatherManager.swift
//  NormalWeatherApp
//
//  Created by Тоха on 05.02.2022.
//

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
    
    private func errorHandler(_ error: NetworkErrors) {
        guard let delegate = delegate as? UIViewController else {
            return
        }
        
        switch error {
        case .emptyCity:
            WeatherAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "Wrong city",
                                                            message: "Ops, you typed nonexistent city")
        case .httpError(let networkError):
            WeatherAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "HTTP Error",
                                                            message: "Id: \(networkError.cod).\nMessage: \(networkError.message)")
        case .emptyCoordinates:
            WeatherAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "Wrong coordinates",
                                                            message: "Ops, you are on nonexistent coordinates")
        default:
            WeatherAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "Ops",
                                                            message: "Something goes wrong")
        }
    }
}
