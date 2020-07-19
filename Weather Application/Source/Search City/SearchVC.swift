//
//  SearchVC.swift
//  Weather Application
//
//  Created by Khadija Asim on 17/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let vm = SearchVM()
    let searchController = UISearchController(searchResultsController: nil)

    //CR: No need for this computed property, remove it you can change the isFiltering property below to what I did and it should work, Plus the return statement is not properly indented. Make sure your indentation of code is correct everywhere.
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return searchController.isActive && !text.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUISearchController()
        bindVM()

    }

}


extension SearchVC {
    func setUpUISearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Text.searchBarPlaceholderText
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func bindVM() {
        //CR: allCities should be a private variable in vm. You should set the cities array with allCities array when you get the allCities data from the file after checking if user is not filtering. Write a didSet block on allCities and set the cities array inside that.use bind and trigger on cities
        vm.allCities.bindAndTrigger { [weak self] (value) in
            self?.tableView.reloadData()
        }
        vm.cities.bind { [weak self] (value) in
            self?.tableView.reloadData()
        }
    }

}


extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.citiesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.searchCellIdentifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.setUpAndConfigureCell(vm.citiesList?[indexPath.row])
        return cell
    }
}


extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //CR: No need to for this setSearchState metod in vm. What you should do is first have an if condition here on "isFiltering" variable here and if its met then call the function "vm.filterCitiesForSearchText(searchBar.text)" and inside "vm.filterCitiesForSearchText" method it will check if the text is nil or empty string it will set searchState to unfiltered otherwise will set the state to filtered.
        vm.setSearchState(isFiltering)
        //CR: You should pass nil value to "filterCitiesForSearchText" method and it should check if string is nil or empty it shouldn't filter but rasther show allCities. no need to check searchBar.text for nil here and sending a string with a space.
        vm.filterCitiesForSearchText(searchBar.text ?? " ")
    }

}


