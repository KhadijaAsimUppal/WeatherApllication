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
        searchController.searchBar.placeholder = TextConstants.searchBarPlaceholderText
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func bindVM() {
        vm.cities.bindAndTrigger { [weak self] (value) in
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
        cell.vm.cityModel.value = vm.city(at: indexPath.row)
        return cell
    }
    
}


extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text else {return}
        isFiltering ? vm.filterCitiesForSearchText(text) : vm.filterCitiesForSearchText(" ")
    }
    
}


