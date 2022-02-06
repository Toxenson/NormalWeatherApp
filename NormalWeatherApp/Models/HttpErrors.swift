//
//  WrongCityStruct.swift
//  NormalWeatherApp
//
//  Created by Тоха on 06.02.2022.
//

import Foundation
import UIKit

enum Errors: Error {
    case emptyCity
    case httpError(id: Int, message: String)
    case emptyCoordinates
    case failedUrl
    case cantConvertResponse
    case unsafeData
}

struct HttpErrors: Codable{
    let cod: Int
    let message: String
    
    static func parseJson(from json: Data) -> HttpErrors? {
        debugPrint("also parsing json")
        do {
            debugPrint("json parsed")
            return try JSONDecoder().decode(HttpErrors.self, from: json)
        } catch {
            return nil
        }
    }
}

