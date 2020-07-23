//
//  CitiesManager.swift
//  Weather Application
//
//  Created by Khadija Asim on 23/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

class CitiesManager {

    lazy private var citiesService = CitiesService()
    static let shared = CitiesManager()
    var cities: [CityModel?]?

    private init() {
        self.fetchCities()
    }
}

extension CitiesManager {
    func fetchCities() {
        citiesService.fetchCities() { (result) in
            switch result {
                case.success(let cities):
                    self.cities = cities
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
}
