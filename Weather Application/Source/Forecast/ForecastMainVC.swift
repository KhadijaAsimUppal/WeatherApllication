//
//  ViewController.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class ForecastMainVC: UIViewController {

    @IBOutlet weak var viewModeButton: UIButton!
    @IBOutlet weak var viewModeLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var vm = ForecastMainVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
    }

    func setUpUI() {
        vm.fetchForecast()
        cityNameLabel.text = vm.cityNameString
        countryNameLabel.text = vm.countryNameString

    }

    func bindVM() {
        vm.forecasts.bindAndTrigger { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        vm.selectedCity.bindAndTrigger { [weak self] _ in
            DispatchQueue.main.async {
                self?.setUpUI()
            }
        }
    }
    @IBAction func switchModeButtonTapped(_ sender: Any) {
        vm.toggleViewMode()
        changeStateOfViewModeButton()
        changeStateOfLocationButton()
        updateUI()

    }
    
    @IBAction func locationButtunTapped(_ sender: Any) {
        let vc = StoryBoards.main.instantiateViewController(withIdentifier: Identifiers.searchNavigationVCIdentifier)
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
}

extension ForecastMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.forecastsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCellIdentifier, for: indexPath) as? DayWiseForecastsCell else {return UITableViewCell()}
        cell.vm.dateWiseForecast.value = vm.forecasts(at: indexPath.row)
        return cell
    }

    
}

extension ForecastMainVC {
    func changeStateOfLocationButton() {
        let isLiveMode = (vm.currentViewMode == .live)
        locationButton.isUserInteractionEnabled = isLiveMode
        locationButton.isEnabled = isLiveMode
        locationButton.isHidden = !isLiveMode
    }

    func changeStateOfViewModeButton() {
        let isLiveMode = (vm.currentViewMode == .live)
        let viewModeButtonTitle = isLiveMode ? "OFFLINE" : "LIVE"
        viewModeButton.setTitle(viewModeButtonTitle, for: .normal)
    }

    func updateUI() {
        let isLiveMode = (vm.currentViewMode == .live)
        viewModeLabel.text = isLiveMode ? "LIVE FORECAST" : "OFFLINE"
        
    }
}


