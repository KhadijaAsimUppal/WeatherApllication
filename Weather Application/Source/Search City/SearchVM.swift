//
//  SearchVM.swift
//  Weather Application
//
//  Created by Khadija Asim on 17/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

class SearchVM {
    
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

}

extension SearchVM {
    func fetchCities() {
        self.allCities = CitiesManager.shared.cities
    }

    func filterCitiesForSearchText(_ searchText: String) {
        guard !searchText.isEmpty else {currentState = .unfiltered; return}
        currentState = .filtered
        cities.value = allCities?.filter {($0?.name?.lowercased().contains(searchText.lowercased()) ?? false)}

    }

}

extension SearchVM {
    func city(at index: Int) -> CityModel? {
        guard index >= 0, index < citiesCount else { return nil }
        return citiesList?[index]
     }
}
