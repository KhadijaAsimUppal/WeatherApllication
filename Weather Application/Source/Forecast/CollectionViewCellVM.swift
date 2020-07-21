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

    var timeString: String {
        return forecast?.dtTxt?.timeStringWithoutDate() ?? " "
    }

    var temperatureString: String {
        return (convertToCelcius(forecast?.main?.temp ?? 0).toString() + " °C" )
    }

    var temperatureMinMaxString: String {
        return (convertToCelcius(forecast?.main?.tempMax ?? 0).toString() + " / " + convertToCelcius(forecast?.main?.tempMin ?? 0).toString())
    }



}

extension CollectionViewCellVM {
    private func convertToCelcius(_ value: Double) -> Double {
        return (value - 273.15)
    }


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


