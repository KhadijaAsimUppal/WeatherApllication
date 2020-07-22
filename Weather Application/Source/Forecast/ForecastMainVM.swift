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
    var selectedCity: Bindable<CityModel?> = Bindable(nil)

    var cityNameString: String {
        return selectedCity.value?.name ?? " "
    }
    var countryNameString: String {
        return selectedCity.value?.country ?? " "
    }
    var dateString: String? {
        guard let date = forecasts.value[0]?.forecast[0]?.dtTxt else {return nil}
        return date.elaboratedDateString()
    }
    var tempString: String {
        return (forecasts.value[0]?.forecast[0]?.main?.temp ?? 0).convertToCelcius().toString(withFormat: "%.1f") + " °C"
    }
    var forecastsCount:  Int {
        return forecasts.value.count
    }
    var cityID: String? {
        guard let cityID = selectedCity.value?.id else {return nil}
        return (String(cityID))
    }
}

extension ForecastMainVM {
    func fetchForecast() {
        guard let cityId = cityID else {return}
        fetchForecast(for: cityId)
    }

    private func fetchForecast(for id: String) {
        forecastService.fetchWeatherForecast(id) { (result) in
            switch result {
                case.success(let forecast):
                    self.organiseForecastResult(forecast)
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
    //CR: Review the commented method below and see if it does what you wanted to do and is it in any way better than the existing "organiseForecastResult" method
    func organiseForecastResult(_ forecastResult: WeatherForecastResult?) {
        var dateWiseForecastDict: [String: [WeatherForecastModel?]] = [:]
        forecastResult?.list?.forEach({ forcast in
            if let dateStr = forcast?.dtTxt?.dateStringWithoutTime() {
                if let _ = dateWiseForecastDict[dateStr] {
                    dateWiseForecastDict[dateStr]?.append(forcast)
                }else {
                    dateWiseForecastDict[dateStr] = [forcast]
                }
            }
        })
        var dateWiseForcasts = dateWiseForecastDict.map {(key, forecast) in return DateWiseForecast(date: key, forecast: forecast)}
        dateWiseForcasts = dateWiseForcasts.sorted(by: { (first, second) -> Bool in
            guard let firstDate = first.forecast.first??.dtTxt, let secondDate = second.forecast.first??.dtTxt else { return false }
            return firstDate < secondDate
        })
        forecasts.value = dateWiseForcasts
    }
//    func organiseForecastResult() {
//        var dateWiseForecastDict: [String: [WeatherForecastModel?]] = [:]
//        let dateList = forecastResult?.list?.compactMap { $0?.dtTxt?.dateStringWithoutTime()
//        }.removeDuplicates()
//
//        dateList?.forEach {
//            let key = $0
//            let singleDayForecast = forecastResult?.list?.filter {
//                $0?.dtTxt?.dateStringWithoutTime() == key
//            }
//            dateWiseForecastDict[key] = singleDayForecast
//        }
//
//        let dateWiseForcasts = dateWiseForecastDict.map {(key, forecast) in return DateWiseForecast(date: key, forecast: forecast)}
//        forecasts.value = dateWiseForcasts
//
//    }
}

extension ForecastMainVM {
    func forecasts(at index: Int) -> DateWiseForecast? {
        guard index >= 0, index < forecastsCount else { return nil }
        return forecasts.value[index]
    }


}
