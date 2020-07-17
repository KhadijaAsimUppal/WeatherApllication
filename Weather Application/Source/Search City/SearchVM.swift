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
    var currentState: searchState = .unfiltered
    var allCities : Bindable<[CityModel?]?> = Bindable([])
    var cities : Bindable<[CityModel?]?> = Bindable([])

    var citiesCount: Int {
        switch currentState {
            case .filtered:
                return cities.value?.count ?? 0
            case .unfiltered:
                return allCities.value?.count ?? 0
        }
    }

    var citiesList: [CityModel?]? {
        switch currentState {
            case .filtered:
                return cities.value
            case .unfiltered:
                return allCities.value
        }
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
                    self.allCities.value = cities
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

    func filterCitiesForSearchText(_ searchText: String) {
        cities.value = allCities.value?.filter
            {($0?.name?.lowercased().contains(searchText.lowercased()) ?? false)
        }
    }

    func setSearchState(_ state: Bool) {
        if (state == true){
            currentState = .filtered
        }
        else {currentState = .unfiltered}

    }

}
