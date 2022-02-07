//
//  Model.swift
//  NormalWeatherApp
//
//  Created by Тоха on 04.02.2022.
//

import CoreLocation

protocol WeatherModelProtocol {
    
}

struct Coordinates: Codable {
    let lon: CLLocationDegrees?
    let lat: CLLocationDegrees?
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
    }
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
    
    static func parseJson(from json: Data) -> WeatherData? {
        debugPrint("also parsing json")
        do {
            debugPrint("json parsed")
            return try JSONDecoder().decode(WeatherData.self, from: json)
        } catch {
            debugPrint("wrong weather")
            return nil
        }
    }
}
