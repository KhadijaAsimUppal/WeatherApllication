//
//  SearchVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 17/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

class SearchVM {
    lazy private var citiesService = CitiesService()
    var cities : Bindable<[CityModel?]?> = Bindable([])

    var citiesCount: Int {
        return cities.value?.count ?? 0
    }

    init() {
        fetchCities()
    }
}

extension SearchVM {
    func fetchCities() {
        citiesService.fetchCities() { (result) in
            switch result {
                case.success(let cities):
                    self.cities.value = cities
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

}
