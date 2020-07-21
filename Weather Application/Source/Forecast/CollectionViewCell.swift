//
//  CollectionViewCell.swift
//  Weather Application
//
//  Created by Khadija Asim on 20/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempConstantLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tempMinMaxLabel: UILabel!

    var vm = CollectionViewCellVM()

    func bindVM() {
        vm.weatherIcon.bind {[weak self] (image) in
            DispatchQueue.main.async {
                self?.icon.image = image
            }
        }
    }
}

extension CollectionViewCell {
    func configureCell() {
        bindVM()
        vm.fetchIcon()
        timeLabel.text = vm.timeString
        tempConstantLabel.text = vm.temperatureString
        tempMinMaxLabel.text = vm.temperatureMinMaxString
    }
}
