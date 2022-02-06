//
//  WrongCityStruct.swift
//  NormalWeatherApp
//
//  Created by Тоха on 06.02.2022.
//

import UIKit

enum NetworkErrors: Error {
    case emptyCity
    case httpError(NetworkError)
    case emptyCoordinates
    case failedUrl
    case cantConvertResponse
    case unsafeData
}

struct NetworkError: Codable {
    let cod: Int
    let message: String
    
    static func parseJson(from json: Data) -> NetworkError? {
        debugPrint("also parsing json")
        do {
            debugPrint("json parsed")
            return try JSONDecoder().decode(NetworkError.self, from: json)
        } catch {
            return nil
        }
    }
}

