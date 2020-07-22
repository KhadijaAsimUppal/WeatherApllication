//
//  TableViewCell.swift
//  Weather Application
//
//  Created by Khadija Asim on 21/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class DayWiseForecastsCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    let vm = DayWiseForecastsVM()

    override func awakeFromNib() {
        bindVM()
    }

    func bindVM() {
        vm.dateWiseForecast.bindAndTrigger { [weak self] _ in
            DispatchQueue.main.async {
                self?.setUpCell()
                self?.collectionView.reloadData()
            }
        }
    }

    func setUpCell() {
        dateLabel.text = vm.dateString
    }
  
}


extension DayWiseForecastsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.dateWiseForecastCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.collectionViewCellIdentifier, for: indexPath) as? ForecastCell else {return UICollectionViewCell()}
        cell.vm.forecast.value = vm.forecast(at: indexPath.row)
        return cell

    }

}
