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

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUISearchController()

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

}


extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return vm.filteredCitiesCount
        }
        return vm.citiesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.searchCellIdentifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        if isFiltering {
            cell.setUpAndConfigureCell(vm.filteredCities.value?[indexPath.row])
        }
        else {
            cell.setUpAndConfigureCell(vm.cities.value?[indexPath.row])
        }
        return cell
    }
}


extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterCitiesForSearchText(searchBar.text ?? " ")
    }

    func filterCitiesForSearchText(_ searchText: String) {
        vm.filteredCities.value = vm.cities.value?.filter
            {($0?.name?.lowercased().contains(searchText.lowercased()) ?? false)
        }
      tableView.reloadData()
    }
}


