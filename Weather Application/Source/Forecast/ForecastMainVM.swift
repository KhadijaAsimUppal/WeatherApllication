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
    var forecasts: Bindable<[DateWiseForecast?]> = Bindable([])
    private var forecastResult: WeatherForecastResult? {
        didSet {
            organiseForecastResult()
        }
    }

    var forecastsCount:  Int {
        return forecasts.value.count
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
                    self.forecastResult = forecast
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

    func organiseForecastResult() {
        var dateWiseForecastDict: [String: [WeatherForecastModel?]] = [:]
        let dateList = forecastResult?.list?.compactMap { $0?.dtTxt?.dateStringWithoutTime()
        }.removeDuplicates()

        dateList?.forEach {
            let key = $0
            let singleDayForecast = forecastResult?.list?.filter {
                $0?.dtTxt?.dateStringWithoutTime() == key
            }
            dateWiseForecastDict[key] = singleDayForecast
        }
        
        let dateWiseForcasts = dateWiseForecastDict.map {(key, forecast) in return DateWiseForecast(date: key, forecast: forecast)
        }
        forecasts.value = dateWiseForcasts

    }
}


