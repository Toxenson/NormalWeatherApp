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
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c8c3760b8e5d406a8a129e05c43e8d3f&units=metric"
//    private var completitionHandlerForResponse: (Data?, URLResponse?, Error?) -> Void = {
//        data, urlResponse, error in
//        let statusCode = (urlResponse as! HTTPURLResponse).statusCode
//        if statusCode == 200 {
//            let safeData = data!
//            weatherModel.appendWeatherList(from: safeData)
//        }
//    }
    
    mutating func fetchWeather(city cityName: String) {
        let finalUrl = weatherURL + "&q=\(cityName)"
        performRequest(with: finalUrl)
    }
    
    private mutating func performRequest(with urlString: String) {
        let urlRequest = URLRequest(url: URL(string: urlString)!,
                                    cachePolicy: .reloadIgnoringLocalCacheData,
                                    timeoutInterval: 0.5)
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest,
                         completionHandler: {
            data, urlResponse, error in
            let statusCode = (urlResponse as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let safeData = data!
                weatherModel.appendWeatherList(from: safeData)
            }
        })
    }
    
}
