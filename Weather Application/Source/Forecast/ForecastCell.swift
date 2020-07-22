//
//  CollectionViewCell.swift
//  Weather Application
//
//  Created by Khadija Asim on 20/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempConstantLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tempMinMaxLabel: UILabel!

    var vm = ForecastVM()

    override func awakeFromNib() {
        bindVM()
    }

    func bindVM() {
        vm.weatherIcon.bind {[weak self] (image) in
            DispatchQueue.main.async {
                self?.icon.image = image
            }
        }
        vm.forecast.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.setUpCell()
            }
        }
    }
}

extension ForecastCell {
    func setUpCell() {
        vm.fetchIcon()
        timeLabel.text = vm.timeString
        tempConstantLabel.text = vm.temperatureString
        tempMinMaxLabel.text = vm.temperatureMinMaxString
    }
}
