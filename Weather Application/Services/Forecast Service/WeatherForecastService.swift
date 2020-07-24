//
//  WeatherForecastService.swift
//  Weather Application
//
//  Created by Khadija Asim on 24/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

protocol WeatherForecastService {
    func fetchForecast(_ cityID: String?, completion: @escaping ForecastRequestCompletion)
}

extension WeatherForecastService {
    func fetchForecast(_ cityID: String?, completion: @escaping ForecastRequestCompletion) {
        if let service = self as? LiveWeatherForecastService {
            guard let id = cityID else {return}
            service.fetchWeatherForecast(id) { (result) in
                completion(result)
            }
        } else if let service = self as? OfflineWeatherForecastService {
            service.fetchOfflineForecast() {(result) in
                completion(result)
            }
        }
    }
    
}
