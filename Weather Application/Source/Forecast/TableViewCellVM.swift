//
//  TableViewCellVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 21/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

class TableViewCellVM {

    var dateWiseForecast: Bindable<DateWiseForecast?> = Bindable(nil)
    var dateString: String {
        return dateWiseForecast.value?.date ?? " "
    }

    var dateWiseForecastCount: Int {
        return dateWiseForecast.value?.forecast.count ?? 0
    }

    init() {
        
    }
}
