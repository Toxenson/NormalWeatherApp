//
//  ViewController.swift
//  NormalWeatherApp
//
//  Created by Тоха on 04.02.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    
    var locationManager: CLLocationManager?
    var weatherManager: WeatherManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager = WeatherManager()
        locationManager?.delegate = self
        weatherManager?.delegate = self
        
        debugPrint("adding weather")
        weatherManager?.addWeather(for: "Moscow")
        debugPrint("weather added?")
        
    }
    
    @IBAction private func gg() {
//        didUpdateWeather(weatherManager!, weather: WeatherData(coord: Coordinates(lon: 70,
//                                                                                  lat: 70),
//                                                               weather: [Weather(id: 10,
//                                                                                 main: "cloudy",
//                                                                                 description: "fuck")],
//                                                               main: Main(temp: 60, feels_like: 69, temp_min: 95, temp_max: 69, pressure: 88), wind: Wind(speed: 55, deg: 4), id: 1, name: "Moscow"))
        weatherManager?.addWeather(for: "Saratov")
    }
}

extension ViewController: CLLocationManagerDelegate {
    
}

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData?) {
        temperatureLabel.text = String(format: "%.0f", weather?.main.temp ?? 0) + " °C"
        feelsLikeLabel.text = String(format: "%.0f", weather?.main.feels_like ?? 0) + " °C"
        maxTempLabel.text = String(format: "%.0f", weather?.main.temp_max ?? 0) + " °C"
        minTempLabel.text = String(format: "%.0f", weather?.main.temp_min ?? 0) + " °C"
        locationLabel.text = weather?.name
    }
    
    func didFailWithError(_ error: Error) {
        debugPrint(error)
    }
    
    
}
