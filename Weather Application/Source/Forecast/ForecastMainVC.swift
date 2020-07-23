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

    func bindVM() {
        vm.forecasts.bindAndTrigger { [weak self] _ in
            DispatchQueue.main.async {
                self?.reloadTableView()
            }
        }

        vm.selectedCity.bindAndTrigger { [weak self] _ in
            DispatchQueue.main.async {
                self?.setUpUI()
            }
        }
        vm.setDefaultCity()
    }

    @IBAction func switchModeButtonTapped(_ sender: Any) {
        vm.toggleViewMode()
        setViewModeButtonLabel()
        setLocationButtonState()
        DispatchQueue.main.async {
            self.setUpUI()
            self.reloadTableView()
        }
    }
    
    @IBAction func locationButtunTapped(_ sender: Any) {
        let vc = StoryBoards.main.instantiateViewController(withIdentifier: Identifiers.searchNavigationVCIdentifier)
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
}


extension ForecastMainVC {
    private func setUpUI() {
        setViewModeLabel()
        setViewModeButtonLabel()
        setLocationButtonState()
        vm.fetchForecast()
        cityNameLabel.text = vm.cityNameString
        countryNameLabel.text = vm.countryNameString
    }

    private func reloadTableView() {
        tableView.reloadData()
    }

    private func setLocationButtonState() {
        let isLiveMode = (vm.currentViewMode == .live)
        locationButton.isUserInteractionEnabled = isLiveMode
        locationButton.isEnabled = isLiveMode
        locationButton.isHidden = !isLiveMode
    }

    private func setViewModeButtonLabel() {
        let isLiveMode = (vm.currentViewMode == .live)
        let viewModeButtonTitle = isLiveMode ? "OFFLINE" : "LIVE"
        viewModeButton.setTitle(viewModeButtonTitle, for: .normal)
    }

    private func setViewModeLabel() {
        let isLiveMode = (vm.currentViewMode == .live)
        viewModeLabel.text = isLiveMode ? "LIVE FORECAST" : "OFFLINE"
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


