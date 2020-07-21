//
//  CollectionViewCellVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 20/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCellVM {
    lazy private var iconService = WeatherIconService(NetworkHandler())
    var weatherIcon: Bindable<UIImage?> = Bindable(nil)
    var forecast: WeatherForecastModel?

    //CR: name of property says timeString but inside it you are returning just dateWithoutTime name is confusing to me
    var timeString: String {
        return forecast?.dtTxt?.timeStringWithoutDate() ?? " "
    }

    var temperatureString: String {
        return (convertToCelcius(forecast?.main?.temp ?? 0).toString() + " °C" )
    }

    var temperatureMinMaxString: String {
        //CR: show temprature to atleast one or two decimal places not as an Int value
        return (convertToCelcius(forecast?.main?.tempMax ?? 0).toString() + " / " + convertToCelcius(forecast?.main?.tempMin ?? 0).toString())
    }

}


extension CollectionViewCellVM {
    //CR: This method for converting kelvin to celcius should be in some utility class from where it could be accessed by any one later on if required.
    private func convertToCelcius(_ value: Double) -> Double {
        return (value - 273.15)
    }

    //CR: Since cells are being reused so you should pass the forcast model you have at class level to this method and when server response comes back at that time you should check if the forcast icon at the class level is the same model for which the serve returned the image for otherwise you may end up showing wrong icon. discuss this with me over the call if its not clear.
    func fetchIcon() {
        guard let weatherIconPath = forecast?.weather?.first?.icon else {return}
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


