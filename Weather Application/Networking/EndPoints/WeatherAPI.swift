//
//  WeatherAPI.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

enum WeatherAPI {
    case getForecast(cityID: String)
    case getIcon(iconPath: String)
}

extension WeatherAPI: EndPointType {
    var baseURLString: String {
        switch  self {
        case .getIcon:
            return "https://openweathermap.org/img/wn/"
        case .getForecast:
            return "https://api.openweathermap.org/data/2.5/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: baseURLString) else {fatalError("Invalid Base URL.")}
           return url
    }

    var path: String {
         switch  self {
         case .getForecast:
             return "forecast"
         case .getIcon(let iconPath):
            return "\(iconPath)@2x.png"
         }
     }

    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        var params : HTTPParameters? = nil
        switch self {
        case .getForecast(let cityID):
            params  = ["appid": APIKey.key, "id": cityID]
        case .getIcon:
            params = nil
        }

        return .request(urlParams: params)
    }

    /// Computed property to provide request with cache  policy
    var cachingPolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
}
