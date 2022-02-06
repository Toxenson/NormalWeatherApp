//
//  ViewController.swift
//  NormalWeatherApp
//
//  Created by Тоха on 04.02.2022.
//

import UIKit
import CoreLocation
import CoreLocationUI



class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var locationTextField: UITextField!
    @IBOutlet private weak var locationButton: UIImageView!
    
    var locationManager: CLLocationManager?
    var weatherManager: WeatherManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager = WeatherManager()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        weatherManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
//        weatherManager?.addWeather(for: "Gilgit-Baltistan")
        
    }
    
    //MARK: - LifeCycle
    @IBAction private func gg() {
        weatherManager?.addWeather(for: Coordinates(
            lon: CLLocationDegrees(exactly: Float.random(in: 10...100)),
            lat: CLLocationDegrees(exactly: Float.random(in: 10...100))))

//        present(AlertsFabric.getWarningAlert(
//            title: "Error",
//            message: "You typed wrong city"),
//                animated: true,
//                completion: nil)
    }
    
    @IBAction private func onLocationPressed() {
        locationTextField.endEditing(true)
        if let cityName = locationTextField.text {
            weatherManager?.addWeather(for: cityName)
        }
        locationTextField.text = ""
    }
    
}

//MARK: - Delegates
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        debugPrint("method called")
            if let location = locations.last {
                debugPrint("location exist")
                locationManager?.stopUpdatingLocation()
                let coords = Coordinates(
                    lon: location.coordinate.longitude,
                    lat: location.coordinate.latitude)
                weatherManager?.addWeather(for: coords)
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            debugPrint(error)
        }
}

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData?) {
        temperatureLabel.text = String(format: "%.0f", weather?.main.temp ?? 0) + " °C"
        feelsLikeLabel.text = String(format: "%.0f", weather?.main.feels_like ?? 0) + " °C"
        maxTempLabel.text = String(format: "%.0f", weather?.main.temp_max ?? 0) + " °C"
        minTempLabel.text = String(format: "%.0f", weather?.main.temp_min ?? 0) + " °C"
        if weather?.name != "" {
            locationLabel.text = weather?.name
        } else {
            locationLabel.text = "No city here"
        }
        var iconName = ""
        switch weather?.weather[0].main {
        case "Clear":
            iconName = "sun"
        case "Clouds":
            iconName = "clouds"
        case "Snow":
            iconName = "snowy"
        case "Rain":
            iconName = "rain"
        default:
            iconName = "cloudy"
        }
        weatherImage.image = UIImage(named: iconName)
    }
    
    func didFailWithError(_ error: UIViewController) {
        present(error,
                animated: true,
                completion: nil)
    }
    
    
}
