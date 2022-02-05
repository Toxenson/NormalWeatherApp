//
//  Model.swift
//  NormalWeatherApp
//
//  Created by Тоха on 04.02.2022.
//

import Foundation

protocol WeatherModelProtocol {
    
}

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

struct Wind {
    let speed: Double
    let degrees: Int
}

struct Weather {
    let coords: Coordinates
    let city: String?
    let weatherType: String
    let weatherDescription: String
    let temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let temperatureFeelsLike: Double
    let pressurre: Double
    let wind: Wind
}

struct WeatherModel {
    var weatherList: [Weather]?
//    var delegate: WeatherModelProtocol?
    
    mutating func appendWeatherList(from jsonObject: Data){
        weatherList?.append(Weather(coords: Coordinates(latitude: 50, longitude: 50),
                                    city: "govno",
                                    weatherType: "cloudy",
                                    weatherDescription: "fuck",
                                    temperature: 10,
                                    temperatureMin: 9,
                                    temperatureMax: 11,
                                    temperatureFeelsLike: 10,
                                    pressurre: 40,
                                    wind: Wind(speed: 100, degrees: 0)))
    }
}
