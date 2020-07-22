//
//  CollectionViewCellVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 20/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation
import UIKit

class ForecastVM {
    lazy private var iconService = WeatherIconService(NetworkHandler())
    var weatherIcon: Bindable<UIImage?> = Bindable(nil)
    var forecast: Bindable<WeatherForecastModel?> = Bindable(nil)

    var timeString: String {
        return forecast.value?.dtTxt?.timeStringWithoutDate() ?? " "
    }

    var temperatureString: String {
        return ((forecast.value?.main?.temp ?? 0).convertToCelcius().toString(withFormat: "%.1f") + " °C" )
    }

    var temperatureMinMaxString: String {
        return ((forecast.value?.main?.tempMax ?? 0).convertToCelcius().toString() + "°" + " / " + (forecast.value?.main?.tempMin ?? 0).convertToCelcius().toString() + "°")
    }

}


extension ForecastVM {

    func fetchIcon() {
        fetchIcon(for: forecast.value)
    }

    private func fetchIcon(for forecast: WeatherForecastModel?) {
        guard let weatherIconPath = forecast?.weather?.first?.icon else {return}
        iconService.fetchIcon(for: weatherIconPath) { (result) in
            switch result {
                case.success(let image):
                    guard let currentIconPath = self.forecast.value?.weather?.first?.icon else {return}
                    if weatherIconPath == currentIconPath {
                        self.weatherIcon.value = image
                    } else {return}
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

}


