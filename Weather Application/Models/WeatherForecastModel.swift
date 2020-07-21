//
//  WeatherForecastModel.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

struct WeatherForecastModel: Decodable {
    let dtTxt: Date?
    let main: WeatherMeasurementModel?
    let weather: [WeatherDescriptionModel]?
}
