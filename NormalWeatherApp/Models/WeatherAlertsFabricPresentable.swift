//
//  WeatherAlertFabricPresentable.swift
//  NormalWeatherApp
//
//  Created by Тоха on 07.02.2022.
//

import UIKit

struct WeatherAlertsFabricPresentable {
    
    private static func getWarningAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil)
        alertController.addAction(alertAction)
        return alertController
    }
    
    static func showWarningAlert(in vc: UIViewController, title: String, message: String) {
        vc.present(getWarningAlert(title: title,
                                   message: message),
                   animated: true,
                   completion: nil)
    }
}
