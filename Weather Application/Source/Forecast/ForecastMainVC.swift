//
//  ViewController.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class ForecastMainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let vm = ForecastMainVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
    }

    func bindVM() {
        vm.forecasts.bindAndTrigger { [weak self] (value) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}

extension ForecastMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.forecastsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCellIdentifier, for: indexPath) as? TableViewCell else {return UITableViewCell()}
        let dayWiseForecast = vm.forecasts.value[indexPath.row]
        //CR: Chnage this setup method the way I have changed it in the SearchTableViewCell, i.e set the model directly in the vm model and then use bindAndTrigger method for asking cell to load data
        cell.setUpAndConfigureCell(dayWiseForecast)
        return cell
    }

    
}


