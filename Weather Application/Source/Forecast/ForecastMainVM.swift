//
//  ForecastMainVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 20/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

class ForecastMainVM {
    lazy private var forecastService = WeatherForecastService(NetworkHandler())
    private var forecast: WeatherForecastResult? {
        didSet {
            organiseForecastResult()
        }
    }
    init() {
        fetchForecast()
    }
}

extension ForecastMainVM {
    func fetchForecast() {
        forecastService.fetchWeatherForecast("71549") { (result) in
            switch result {
                case.success(let forecast):
                    self.forecast = forecast
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

    func organiseForecastResult() {
        var dateWiseForecastDict: [String: [WeatherForecastModel?]] = [:]
        let dateList = forecast?.list?.compactMap{ $0?.dtTxt?.dateStringWithoutTime()}.removeDuplicates()

        dateList?.forEach {
            let key = $0
            let singleDayForecast = forecast?.list?.filter {
                return $0?.dtTxt?.dateStringWithoutTime() == key
            }
            dateWiseForecastDict[key] = singleDayForecast
        }
    }


}
