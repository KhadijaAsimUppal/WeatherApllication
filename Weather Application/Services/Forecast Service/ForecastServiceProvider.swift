//
//  ForecastServiceProvider.swift
//  Weather Application
//
//  Created by Khadija Asim on 24/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

struct ForecastServiceProvider: WeatherForecastService {
    func getForecastService(_ networkHandler: NetworkHandler?) -> WeatherForecastService {
        guard let networkHandler = networkHandler else {return OfflineWeatherForecastService()}
        return LiveWeatherForecastService(networkHandler)
    }
}
