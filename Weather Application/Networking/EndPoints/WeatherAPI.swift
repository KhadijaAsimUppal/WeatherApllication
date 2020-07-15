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
}

extension WeatherAPI: EndPointType {
    var baseURLString: String {
        return "api.openweathermap.org/data/2.5/forecast"
    }

    var baseURL: URL {
        guard let url = URL(string: baseURLString) else {fatalError("Invalid Base URL.")}
           return url
    }

    var path: String {
         switch  self {
         case .getForecast:
             return " "
         }
     }

    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        var params : HTTPParameters? = nil
        switch self {
        case .getForecast(let cityID):
            params  = ["APIId": APIKey.key, "CityId": cityID]
        }
        return .request(urlParams: params)
    }

    /// Computed property to provide request with cache  policy
    var cachingPolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
}
