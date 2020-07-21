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
}

extension CollectionViewCell {
    func configureCell() {
        timeLabel.text = vm.timeString
        tempConstantLabel.text = vm.temperatureString
        tempMinMaxLabel.text = vm.temperatureMinMaxString
    }
}
