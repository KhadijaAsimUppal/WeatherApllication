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

    //CR: Just return the "cities" count no need for this switch.
    var citiesCount: Int {
        switch currentState {
            case .filtered:
                return cities.value?.count ?? 0
            case .unfiltered:
                return allCities.value?.count ?? 0
        }
    }

    //CR: You do not need this variable you should always use "cities" Array when state is set to unfiltered set the "cities" array to "allCities", otherwise whatever data is there after filtering. It reduces the need for this switch and extra computed property. Instead of this computed property you should have a method that should return city to the VC after checking if the index passed by the VC is in bounds of the array.
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
        //CR: Please indent the filter method below peoperly. the curly bracket should be on the same line as filter
        cities.value = allCities.value?.filter
            {($0?.name?.lowercased().contains(searchText.lowercased()) ?? false)
        }
    }

    //CR: there's no need for this method ploease see my comments in VC in "updateSearchResults" method to modify your implementation
    func setSearchState(_ state: Bool) {
        //CR: even if you needed to implement this method you could have done something like this
        //currentState = state ? .filtered : .unfiltered
        if (state == true){
            currentState = .filtered
        }
        else {currentState = .unfiltered} //CR: This code is not properly indent. Please follow same pattern everywhere of starting and closing branckets. With starting bracket on same line as its starting block and closing bracket on next line. expect for the cases of guard where you could return on the same line where starting and closing brackets can be on same line.

    }

}
