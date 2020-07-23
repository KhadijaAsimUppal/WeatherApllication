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
    var currentViewMode: ViewMode = .live
    var forecasts: Bindable<[DateWiseForecast?]> = Bindable([])
    var selectedCity: Bindable<CityModel?> = Bindable(nil)
    var offlineCity: CityModel?

    var cityNameString: String {
        switch currentViewMode {
            case .live:
                return selectedCity.value?.name ?? " "
            case .offline:
                return offlineCity?.name ?? " "
        }
    }

    var countryNameString: String {
        switch currentViewMode {
            case .live:
                return selectedCity.value?.country ?? " "
            case .offline:
                return offlineCity?.country ?? " "
        }
    }

    var cityID: String? {
        guard let cityID = selectedCity.value?.id else {return nil}
        return (String(cityID))
    }

    var forecastsCount:  Int {
        return forecasts.value.count
    }
}


extension ForecastMainVM {
    func fetchForecast() {
        switch currentViewMode {
            case .live:
                guard let cityId = cityID else {return}
                fetchForecast(for: cityId)
            case .offline:
                fetchOfflineForecast()
        }

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

    private func fetchOfflineForecast() {
        forecastService.fetchOfflineForecast() { (result) in
            switch result {
                case.success(let forecast):
                    self.organiseForecastResult(forecast)
                    self.setOfflineCity(forecast.city)
                case .failure(let error):
                    debugPrint(error)
            }
        }

    }
}


extension ForecastMainVM {
    func forecasts(at index: Int) -> DateWiseForecast? {
        guard index >= 0, index < forecastsCount else { return nil }
        return forecasts.value[index]
    }

    func toggleViewMode() {
        currentViewMode.toggle()
    }

    func setDefaultCity() {
        let isLiveMode = (currentViewMode == .live)
        if isLiveMode, selectedCity.value == nil {
            let defaultCity = CityModel(id: 1172451, name: "Lahore", country: "PK")
            selectedCity.value = defaultCity
        }
    }

    func setOfflineCity(_ city: CityModel?) {
        guard let offlineCity = city else {return}
        self.offlineCity = offlineCity
    }
}


extension ForecastMainVM {
    //CR: Review the commented method below and see if it does what you wanted to do and is it in any way better than the existing "organiseForecastResult" method
    private func organiseForecastResult(_ forecastResult: WeatherForecastResult?) {
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



