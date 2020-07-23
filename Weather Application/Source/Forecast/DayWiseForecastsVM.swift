//
//  TableViewCellVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 21/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

class DayWiseForecastsVM {

    var dateWiseForecast: Bindable<DateWiseForecast?> = Bindable(nil)

    var dateString: String? {
        return dateWiseForecast.value?.date.toDate()?.elaboratedDateString() ?? " "
    }
    var dateWiseForecastCount: Int {
        return dateWiseForecast.value?.forecast.count ?? 0
    }

}

extension DayWiseForecastsVM {
    func forecast(at index: Int) -> WeatherForecastModel? {
        guard index >= 0, index < dateWiseForecastCount else { return nil }
        return dateWiseForecast.value?.forecast[index]
    }
}
