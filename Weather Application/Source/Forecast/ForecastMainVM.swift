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
    //CR: I dont rhink there is a need for this property you can directly pass the forcastResult recieved from your service to the "organiseForecastResult" method to keep things simplified
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
        forecastService.fetchWeatherForecast("1172451") { (result) in
            switch result {
                case.success(let forecast):
                    self.forecastResult = forecast
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
    //CR: Review the commented method below and see if it does what you wanted to do and is it in any way better than the existing "organiseForecastResult" method
//    func organiseForecastResult() {
//        var dateWiseForecastDict: [String: [WeatherForecastModel?]] = [:]
//        forecastResult?.list?.forEach({ forcast in
//            if let dateStr = forcast?.dtTxt?.dateStringWithoutTime() {
//                if let _ = dateWiseForecastDict[dateStr] {
//                    dateWiseForecastDict[dateStr]?.append(forcast)
//                }else {
//                    dateWiseForecastDict[dateStr] = [forcast]
//                }
//            }
//        })
//        var dateWiseForcasts = dateWiseForecastDict.map {(key, forecast) in return DateWiseForecast(date: key, forecast: forecast)}
//        dateWiseForcasts = dateWiseForcasts.sorted(by: { (first, second) -> Bool in
//            guard let firstDate = first.forecast.first??.dtTxt, let secondDate = second.forecast.first??.dtTxt else { return false }
//            return firstDate < secondDate
//        })
//        forecasts.value = dateWiseForcasts
//    }
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

        let dateWiseForcasts = dateWiseForecastDict.map {(key, forecast) in return DateWiseForecast(date: key, forecast: forecast)}
        forecasts.value = dateWiseForcasts

    }
}


