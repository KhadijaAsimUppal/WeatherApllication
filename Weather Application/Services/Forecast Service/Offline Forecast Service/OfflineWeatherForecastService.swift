//
//  OfflineWeatherForecastService.swift
//  Weather Application
//
//  Created by Khadija Asim on 24/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

struct OfflineWeatherForecastService: WeatherForecastService, DataModelDecoder {

    func fetchOfflineForecast(_ completion: @escaping ForecastRequestCompletion) {
        guard let path = Bundle.main.url(forResource: "offlineForecast", withExtension: "json") else {return}
        let jsonData = try? Data(contentsOf: path)
        do {
            let forecast : WeatherForecastResult? = try self.decodeModel(data: jsonData)
            guard let forecastResult = forecast else {
                completion(.failure(NetworkError.failed))
                return
            }
            completion(.success(forecastResult))

        } catch {
            completion(.failure(NetworkError.unableToDecode))

        }
    }

    
}
