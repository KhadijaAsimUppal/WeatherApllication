//
//  TableViewCell.swift
//  Weather Application
//
//  Created by Khadija Asim on 21/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    let vm = TableViewCellVM()

    override func awakeFromNib() {
        bindVM()
    }

    func bindVM() {
        vm.dateWiseForecast.bindAndTrigger { [weak self] (value) in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    func setUpAndConfigureCell(_ model: DateWiseForecast?) {
        vm.dateWiseForecast.value = model
        dateLabel.text = vm.dateString
    }
  
}


extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.dateWiseForecastCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.collectionViewCellIdentifier, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        let forecast = vm.dateWiseForecast.value?.forecast[indexPath.row]
        cell.setUpAndConfigureCell(forecast)
        return cell

    }

}
