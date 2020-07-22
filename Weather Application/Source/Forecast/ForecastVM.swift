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

    //CR: name of property says timeString but inside it you are returning just dateWithoutTime name is confusing to me
    var timeString: String {
        return forecast.value?.dtTxt?.timeStringWithoutDate() ?? " "
    }

    var temperatureString: String {
        return ((forecast.value?.main?.temp ?? 0).convertToCelcius().toString() + " °C" )
    }

    var temperatureMinMaxString: String {
        return ((forecast.value?.main?.tempMax ?? 0).convertToCelcius().toString() + "°" + " / " + (forecast.value?.main?.tempMin ?? 0).convertToCelcius().toString() + "°")
    }

}


extension ForecastVM {

    //CR: Since cells are being reused so you should pass the forcast model you have at class level to this method and when server response comes back at that time you should check if the forcast icon at the class level is the same model for which the serve returned the image for otherwise you may end up showing wrong icon. discuss this with me over the call if its not clear.
    func fetchIcon() {
        guard let weatherIconPath = forecast.value?.weather?.first?.icon else {return}
        iconService.fetchIcon(for: weatherIconPath) { (result) in
            switch result {
                case.success(let image):
                    self.weatherIcon.value = image
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

}


