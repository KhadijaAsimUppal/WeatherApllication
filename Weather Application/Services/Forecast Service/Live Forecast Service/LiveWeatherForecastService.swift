//
//  WeatherForecastService.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

typealias ForecastRequestResult = Result<WeatherForecastResult, Error>
typealias ForecastRequestCompletion = (ForecastRequestResult)->()

struct LiveWeatherForecastService: WeatherForecastService {
    var networkHandler: NetworkHandler

    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

extension LiveWeatherForecastService: DataModelDecoder {
    func fetchWeatherForecast(_ cityId: String, completion: @escaping ForecastRequestCompletion){
        let endPoint = WeatherAPI.getForecast(cityID: cityId)
        networkHandler.fetchData(endPoint) {(result) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    print(NetworkError.noData.localizedDescription)
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let forecast : WeatherForecastResult? = try self.decodeModel(data: data)
                    guard let forecastResult = forecast else {
                        print(NetworkError.failed.localizedDescription)
                        completion(.failure(NetworkError.failed))
                        return
                    }
                    completion(.success(forecastResult))
                } catch {
                    print(NetworkError.unableToDecode.localizedDescription)
                    completion(.failure(NetworkError.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
