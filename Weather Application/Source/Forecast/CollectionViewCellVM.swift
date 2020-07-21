//
//  CollectionViewCellVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 20/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

class CollectionViewCellVM {
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
}


