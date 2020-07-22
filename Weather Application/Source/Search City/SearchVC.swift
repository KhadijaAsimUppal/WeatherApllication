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


    @IBAction func backButtonTapped(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
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


extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryBoards.main.instantiateViewController(withIdentifier: Identifiers.forecastMainVCIdentifier)
        (vc as? ForecastMainVC)?.vm.selectedCity.value = vm.city(at: indexPath.row)
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }

    }
}


extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text else {return}
        isFiltering ? vm.filterCitiesForSearchText(text) : vm.filterCitiesForSearchText(" ")
    }
    
}


