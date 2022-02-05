//
//  Model.swift
//  NormalWeatherApp
//
//  Created by Тоха on 04.02.2022.
//

import Foundation

protocol WeatherModelProtocol {
    
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Main : Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
}

struct Wind: Codable {
    let speed: Double
    let degrees: Int
}

struct WeatherData: Codable {
    let coords: Coordinates
    let weather: [Weather]
    let city: String?
    let main: Main
    let wind: Wind
    let id: Int
}

struct WeatherModel {
    var weatherList: [WeatherData]?
//    var delegate: WeatherModelProtocol?
    
    mutating func appendWeatherList(from jsonObject: Data){
        weatherList?.append(WeatherData(coords: Coordinates(latitude: 50, longitude: 50),
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
