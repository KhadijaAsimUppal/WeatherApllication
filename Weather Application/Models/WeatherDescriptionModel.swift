//
//  WeatherDescriptionModel.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

struct WeatherDescriptionModel: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
