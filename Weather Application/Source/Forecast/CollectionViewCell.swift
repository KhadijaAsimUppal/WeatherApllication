//
//  CollectionViewCell.swift
//  Weather Application
//
//  Created by Khadija Asim on 20/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

//CR: collection view cell is very generic use names with something more concrete.
class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempConstantLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tempMinMaxLabel: UILabel!

    var vm = CollectionViewCellVM()

    override func awakeFromNib() {
        bindVM()
    }

    func bindVM() {
        vm.weatherIcon.bind {[weak self] (image) in
            DispatchQueue.main.async {
                self?.icon.image = image
            }
        }
    }
}

extension CollectionViewCell {
    func setUpAndConfigureCell(_ model: WeatherForecastModel?) {
        vm.forecast = model
        vm.fetchIcon()
        timeLabel.text = vm.timeString
        tempConstantLabel.text = vm.temperatureString
        tempMinMaxLabel.text = vm.temperatureMinMaxString
    }
}
