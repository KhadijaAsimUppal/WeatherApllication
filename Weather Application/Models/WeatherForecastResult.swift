//
//  WeatherForecastResult.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

struct WeatherForecastResult: Decodable {
    let cod: String?
    let message: Float?
    let cnt: Int?
    let list: [WeatherForecastModel?]?
    let city: CityModel?

}
