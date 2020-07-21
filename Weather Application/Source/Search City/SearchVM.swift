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
    var currentState: SearchState = .unfiltered
    var cities : Bindable<[CityModel?]?> = Bindable([])
    private var allCities : [CityModel?]? {
        didSet {
            cities.value = (currentState == .unfiltered) ? allCities : cities.value
        }
    }
    
    var citiesCount: Int {
        return cities.value?.count ?? 0
    }

    var citiesList: [CityModel?]? {
        return cities.value
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
                    self.allCities = cities
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

    func filterCitiesForSearchText(_ searchText: String) {
        guard !searchText.isEmpty else {currentState = .unfiltered; return}
        currentState = .filtered
        cities.value = allCities?.filter {($0?.name?.lowercased().contains(searchText.lowercased()) ?? false)}
     

    }

}
