//
//  AlertsFabric.swift
//  NormalWeatherApp
//
//  Created by Тоха on 06.02.2022.
//

import UIKit

struct WeatherAlertsFabric {
    static func getWarningAlert(title: String, message: String) -> UIViewController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil)
        alertController.addAction(alertAction)
        return alertController
    }
}
