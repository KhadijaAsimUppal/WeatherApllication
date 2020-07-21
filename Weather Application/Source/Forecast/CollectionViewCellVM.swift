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
        return forecast?.dtTxt?.dateStringWithoutTime() ?? " "
    }

}


