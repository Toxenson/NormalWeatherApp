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
}

extension ViewController: CLLocationManagerDelegate {
    
}

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData?) {
        temperatureLabel.text = String(describing: weather?.main.temp) + " °C"
        locationLabel.text = weather?.name
    }
    
    func didFailWithError(_ error: Error) {
        debugPrint(error)
    }
    
    
}
