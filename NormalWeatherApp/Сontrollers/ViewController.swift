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
        locationManager?.delegate = self
        weatherManager?.delegate = self
    }
}

extension ViewController: CLLocationManagerDelegate {
    
}

extension ViewController: WeatherManagerDelegate {
    
}
