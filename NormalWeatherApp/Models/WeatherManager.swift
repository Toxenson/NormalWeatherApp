//
//  WeatherManager.swift
//  NormalWeatherApp
//
//  Created by Тоха on 05.02.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    
}

struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    var weatherModel = WeatherModel()
//    private var completitionHandlerForResponse: (Data?, URLResponse?, Error?) -> Void = {
//        data, urlResponse, error in
//        let statusCode = (urlResponse as! HTTPURLResponse).statusCode
//        if statusCode == 200 {
//            let safeData = data!
//            weatherModel.appendWeatherList(from: safeData)
//        }
//    }
    
    
            }
        })
    }
    
}
