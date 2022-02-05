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
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct WeatherData: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let id: Int
    let name: String
}

